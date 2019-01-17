KUBECTL_BASE=$1
KUBECTL_VERSION=$2
KUBECTL_CLIENT_PATH=${KUBECTL_BASE}/${KUBECTL_VERSION}

mkdir -p ${KUBECTL_CLIENT_PATH} && \
  wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -O ${KUBECTL_CLIENT_PATH}/kubectl && \
  chmod 744 ${KUBECTL_CLIENT_PATH}/kubectl
