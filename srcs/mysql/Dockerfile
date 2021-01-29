FROM alpine

RUN apk -U upgrade && apk add mariadb mariadb-client &&\
mkdir -p /run/mysqld/

COPY /src/wordpress.sql  /
COPY /src/start.sh   /
COPY /src/my.cnf			/etc/

EXPOSE 3306
ENTRYPOINT sh start.sh