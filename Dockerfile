FROM gocd/gocd-agent-alpine-3.5:v17.5.0

# (ref) https://github.com/hashicorp/docker-hub-images/blob/master/terraform/Dockerfile-light
ENV TERRAFORM_VERSION=0.9.5
ENV TERRAFORM_SHA256SUM=0cbb5474c76d878fbc99e7705ce6117f4ea0838175c13b2663286a207e38d783

RUN apk add --update git curl openssh && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

ENTRYPOINT ["/docker-entrypoint.sh"]