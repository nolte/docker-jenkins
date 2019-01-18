FROM jenkins/jenkins:lts

USER root

# install common system modules
RUN apt-get update -q && \
    apt-get install -q -y curl git git-flow jq\
    apt-transport-https ca-certificates curl gnupg2 software-properties-common libnss3-tools

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && apt-get install docker-ce -y && \
    usermod -a -G docker jenkins

RUN apt-get update -q && \
    apt-get install -q -y \
    python2.7 python2.7-dev python-pip libpython2.7-dev libssl-dev \
    python3 python3-dev python3-pip libpython3-dev \
    virtualenv

RUN pip install --upgrade pip==18.1
RUN pip3 install --upgrade pip==18.1



# install cloud tools
ARG KUBECTL_BASE=/opt/kubectl

COPY scripts/install_kubectl.sh scripts/install_kubectl.sh
RUN chmod u+x scripts/install_kubectl.sh
RUN scripts/install_kubectl.sh ${KUBECTL_BASE} v1.13.0
RUN scripts/install_kubectl.sh ${KUBECTL_BASE} v1.6.1
RUN scripts/install_kubectl.sh ${KUBECTL_BASE} v1.4.0

RUN ls -all /opt/kubectl

ARG OC_BASE=/opt/openshift-origin-client-tools

COPY scripts/install_oc.sh scripts/install_oc.sh
RUN chmod u+x scripts/install_oc.sh
RUN scripts/install_oc.sh ${OC_BASE} v3.11.0 0cbc58b
RUN scripts/install_oc.sh ${OC_BASE} v3.6.0 c4dd4cf

RUN ls -all ${OC_BASE}

ARG KUSTOMIZE_BASE=/opt/kustomize
COPY scripts/install_kustomize.sh scripts/install_kustomize.sh
RUN chmod u+x scripts/install_kustomize.sh
RUN scripts/install_kustomize.sh ${KUSTOMIZE_BASE} 1.0.11

ARG TERRAFORM_BASE=/opt/terraform
COPY scripts/install_terraform.sh scripts/install_terraform.sh
RUN chmod u+x scripts/install_terraform.sh
RUN scripts/install_terraform.sh ${TERRAFORM_BASE} 0.11.11

RUN chown -R jenkins:jenkins ${KUBECTL_BASE}
RUN chown -R jenkins:jenkins ${KUSTOMIZE_BASE}
RUN chown -R jenkins:jenkins ${OC_BASE}
RUN chown -R jenkins:jenkins ${TERRAFORM_BASE}

USER jenkins

# disable the jenkins install wizard
RUN echo "2.0" > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

# copy groovy scripts for preconfigure  the jenkins
COPY config/init.groovy.d/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# preinstall the needet jenkins plugins
COPY config/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt
