OC_BASE=$1
OC_CLIENT_VERSION=$2
OC_CLIENT_VERSION_GH_REF=$3
OC_CLIENT_PATH=${OC_BASE}/${OC_CLIENT_VERSION}

mkdir -p ${OC_CLIENT_PATH} && \
    wget -q https://github.com/openshift/origin/releases/download/${OC_CLIENT_VERSION}/openshift-origin-client-tools-${OC_CLIENT_VERSION}-${OC_CLIENT_VERSION_GH_REF}-linux-64bit.tar.gz -O ${OC_CLIENT_PATH}/openshift-origin-client-tools.tar.gz && \
    tar --strip-components=1 -xzf ${OC_CLIENT_PATH}/openshift-origin-client-tools.tar.gz -C ${OC_CLIENT_PATH} && \
    rm ${OC_CLIENT_PATH}/openshift-origin-client-tools.tar.gz && \
    chmod 744 ${OC_CLIENT_PATH}/oc
