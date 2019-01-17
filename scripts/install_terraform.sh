TERRAFORM_BASE=$1
TERRAFORM_VERSION=$2
TERRAFORM_PATH=${TERRAFORM_BASE}/v${TERRAFORM_VERSION}

mkdir -p ${TERRAFORM_PATH} && \
    wget -q "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -O ${TERRAFORM_PATH}/terraform.zip && \
    unzip -d ${TERRAFORM_PATH} ${TERRAFORM_PATH}/terraform.zip && \
    chmod 744 ${TERRAFORM_PATH}/terraform && \
    chmod 744 ${TERRAFORM_PATH}/terraform && \
    rm ${TERRAFORM_PATH}/terraform.zip
