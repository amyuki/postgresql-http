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
 
RUN mkdir -p /usr/src/pgext
RUN cd /usr/src/pgext
RUN git clone git@github.com:pramsey/pgsql-http.git pgsql-http
RUN cd /usr/src/pgext/pgsql-http
RUN make install
