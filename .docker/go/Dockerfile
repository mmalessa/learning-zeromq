FROM golang:1.22.2-bookworm

RUN apt-get update -qq -y \
    && apt-get install -y build-essential ca-certificates file make gcc libzmq5 libzmq5-dev

RUN   mkdir /go/pkg
RUN   chmod a+rwx /go/pkg

ARG APP_USER_ID
RUN useradd -s /bin/sh -u ${APP_USER_ID} -m appuser
USER appuser

WORKDIR /go/src/app
