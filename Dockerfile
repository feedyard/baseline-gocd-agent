FROM gocd/gocd-agent-alpine-3.5:v17.5.0

ENV TERRAFORM_VERSION=0.9.8
ENV INSPEC_VERSION=1.27.0
ENV AWSPEC_VERSION=0.77.1

RUN apk add --update --no-cache git openssh bash bash-doc bash-completion \
    python3 ruby ruby-bundler ruby-dev g++ libffi-dev musl-dev make

RUN python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache
RUN pip install invoke

RUN echo "gem: --no-document" > /etc/gemrc
RUN gem install inspec -v ${INSPEC_VERSION}
RUN gem install awspec -v ${AWSPEC_VERSION}

COPY packages/terraform_${TERRAFORM_VERSION}_linux_amd64.zip /
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

HEALTHCHECK NONE

ENTRYPOINT ["/docker-entrypoint.sh"]
