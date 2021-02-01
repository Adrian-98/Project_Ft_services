FROM alpine:3.12

RUN apk -U upgrade && apk add mariadb mariadb-client openrc && \
    mkdir -p /run/mysqld/

COPY	/src/my.cnf			/etc/
COPY	/src/wordpress.sql		/
COPY	/src/start.sh			/

RUN chmod 777 start.sh

EXPOSE 3306
#ENTRYPOINT [ "start.sh" ] 

