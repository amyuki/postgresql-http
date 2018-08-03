FROM postgres:alpine
MAINTAINER Michael Shen <mshen@sparkpad.com>

RUN apk add --no-cache --virtual .build-deps \
    autoconf \
    automake \
    g++ \
    json-c-dev \
    libtool \
    libxml2-dev \
    make \
    perl \
    git \
    ca-certificates \
    openssl \
    curl \
    tar \
    curl-dev
 
RUN mkdir -p /usr/src/pgext && \
    cd /usr/src/pgext && \
    git clone https://github.com/jessfraz/dockerfiles.git pgsql-http &&\
    ls -alh && \
    pwd && \
    cd pgsql-http && \
    make install
