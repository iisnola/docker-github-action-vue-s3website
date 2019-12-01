
# Container image that runs your code
FROM node:alpine


LABEL "com.github.actions.name"="Publish Vue Js App to S3"
LABEL "com.github.actions.description"="Builds the prodution ready app and then deploys to a already setup S3 website bucket."
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/iisnola/docker-github-action-vue-s3website"
LABEL "homepage"="https://github.com/iisnola/docker-github-action-vue-s3website"
LABEL "maintainer"="Sal <ssparacio@interactivedev.com>"

LABEL "Name"="Publish Vue Js App to S3"
LABEL "Version"="1.0.0"

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apk -v --update add \
        git \
        python \
        py-pip \
        && \
    pip install --upgrade awscli==1.14.5 s3cmd==2.0.1 python-magic && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/* && \
    npm install -g vue && \
    npm install -g @vue/cli

VOLUME /root/.aws

VOLUME /project

WORKDIR /project


# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]