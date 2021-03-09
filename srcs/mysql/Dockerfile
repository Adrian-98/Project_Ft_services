FROM alpine:3.12

RUN apk -U upgrade && apk add mysql mariadb-client openrc && \
apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache && \
    mkdir -p /run/mysqld && \
    chown -R root:root /run/mysqld

COPY	/src/my.cnf			/etc/
COPY	/src/wordpress.sql		/
COPY	/src/execute.sh			/
COPY	/src/telegraf.conf		/etc/telegraf/
COPY    /src/init_file             /

RUN chmod 777 execute.sh

EXPOSE 3306

ENTRYPOINT sh  execute.sh