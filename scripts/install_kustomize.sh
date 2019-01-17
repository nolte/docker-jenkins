KUSTOMIZE_BASE=$1
KUSTOMIZE_VERSION=$2
KUSTOMIZE_PATH=${KUSTOMIZE_BASE}/v${KUSTOMIZE_VERSION}

mkdir -p ${KUSTOMIZE_PATH} && \
    wget -q "https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64" -O ${KUSTOMIZE_PATH}/kustomize && \
    chmod 744 ${KUSTOMIZE_PATH}/kustomize
