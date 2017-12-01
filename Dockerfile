FROM jenkins/jenkins:2.92

USER root

RUN apt-get update &&  apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y

RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

# RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install docker-ce -y

RUN usermod -a -G docker jenkins

RUN apt-get update &&  apt-get install git-flow -y

USER jenkins

# disable the jenkins install wizard
RUN echo "2.0" > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

# copy groovy scripts for preconfigure  the jenkins
COPY config/init.groovy.d/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# preinstall the needet jenkins plugins
COPY config/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt
