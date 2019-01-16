FROM jenkins/jenkins:lts

USER root

# install common system modules
RUN apt-get update -q && \
    apt-get install -q -y curl git git-flow \
    apt-transport-https ca-certificates curl gnupg2 software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && apt-get install docker-ce -y && \
    usermod -a -G docker jenkins

RUN apt-get update -q && \
    apt-get install -q -y \
    python2.7 python2.7-dev libpython2.7-dev \
    python3 python3-dev libpython3-dev \
    virtualenv

# install cloud tools
ENV KUBECTL_BASE=/opt/kubectl
ENV KUBECTL_VERSION=v1.13.0
ENV KUBECTL_CLIENT_PATH=${KUBECTL_BASE}/${KUBECTL_VERSION}

RUN mkdir -p ${KUBECTL_CLIENT_PATH} && \
    wget https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -O ${KUBECTL_CLIENT_PATH}/kubectl && \
    chmod +x ${KUBECTL_CLIENT_PATH}/kubectl


ENV OC_BASE /opt/openshift-origin-client-tools

ENV OC_CLIENT_VERSION=v3.11.0
ENV OC_CLIENT_VERSION_GH_REF=0cbc58b
ENV OC_CLIENT_PATH=${OC_BASE}/${OC_CLIENT_VERSION}

RUN mkdir -p ${OC_CLIENT_PATH} && \
    wget -q https://github.com/openshift/origin/releases/download/${OC_CLIENT_VERSION}/openshift-origin-client-tools-${OC_CLIENT_VERSION}-${OC_CLIENT_VERSION_GH_REF}-linux-64bit.tar.gz -O ${OC_CLIENT_PATH}/openshift-origin-client-tools.tar.gz && \
    tar --strip-components=1 -xzf ${OC_CLIENT_PATH}/openshift-origin-client-tools.tar.gz -C ${OC_CLIENT_PATH} && \
    rm ${OC_CLIENT_PATH}/openshift-origin-client-tools.tar.gz && \
    chmod +x ${OC_CLIENT_PATH}/kubectl && \
    chmod +x ${OC_CLIENT_PATH}/oc

ENV KUSTOMIZE_BASE=/opt/kustomize
ENV KUSTOMIZE_VERSION=1.0.11
ENV KUSTOMIZE_PATH=${KUSTOMIZE_BASE}/v${KUSTOMIZE_VERSION}

RUN mkdir -p $KUSTOMIZE_PATH && \
    wget -q "https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64" -O ${KUSTOMIZE_PATH}/kustomize && \
    chmod u+x $KUSTOMIZE_PATH/kustomize

USER jenkins

# disable the jenkins install wizard
RUN echo "2.0" > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

# copy groovy scripts for preconfigure  the jenkins
COPY config/init.groovy.d/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# preinstall the needet jenkins plugins
COPY config/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt
