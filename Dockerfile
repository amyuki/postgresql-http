FROM base/archlinux:latest

RUN pacman -Sy --noconfirm postgresql curl git base-devel
RUN mkdir -p /usr/src/pgext
RUN git clone https://github.com/pramsey/pgsql-http.git /usr/src/pgext/pgsql-http
RUN cd /usr/src/pgext/pgsql-http && make install

RUN sudo -u postgres initdb -D '/var/lib/postgres/data'


VOLUME /var/lib/postgresql/data

#COPY docker-entrypoint.sh /usr/local/bin/
#RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
#ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres", "-D", "/var/lib/postgresql/data"]
