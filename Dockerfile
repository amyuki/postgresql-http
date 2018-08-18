FROM postgres:latest 
RUN localedef -i zh_CN -c -f UTF-8 -A /usr/share/locale/locale.alias zh_CN.UTF-8
ENV LANG zh_CN.UTF-8

RUN apt-get update && apt-get install -y apt-utils git build-essential libtool autoconf ca-certificates libssl-dev postgresql-server-dev-$PG_MAJOR postgresql-$PG_MAJOR-cron

RUN mkdir -p /usr/src/pgext
RUN git clone https://github.com/curl/curl.git /usr/src/pgext/curl && cd /usr/src/pgext/curl/ && ./buildconf && ./configure && make && make install
RUN git clone https://github.com/mshen7310/pgsql-http.git /usr/src/pgext/pgsql-http && cd /usr/src/pgext/pgsql-http && make && make install

RUN mkdir -p /docker-entrypoint-initdb.d
ADD create_extensions.sql /docker-entrypoint-initdb.d
ADD postgresql.conf /etc/postgresql/postgresql.conf
ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH
