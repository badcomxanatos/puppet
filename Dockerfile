FROM ruby:alpine
MAINTAINER Chef Software, Inc. <docker@chef.io>

ARG VERSION=3.2.6
ARG GEM_SOURCE=https://rubygems.org

RUN mkdir -p /share
RUN apk add --update build-base libxml2-dev libffi-dev git openssh-client && \
    apk add bash curl py-pip && \
    pip install --upgrade pip && \
    apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python-dev make && \
    pip install azure-cli && \
    gem install --no-document --source ${GEM_SOURCE} --version ${VERSION} inspec && \
    apk del build-base
ENTRYPOINT ["inspec"]
CMD ["help"]
VOLUME ["/share"]
WORKDIR /share
COPY ./test/ /share
