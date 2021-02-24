# FROM alpine:3.12

# RUN apk -U upgrade && apk add mariadb mariadb-client openrc && \
#     mkdir -p /run/mysqld/

# COPY	/src/my.cnf			/etc/
# COPY	/src/wordpress.sql		/
# COPY	/src/execute.sh			/

# RUN chmod 777 execute.sh

# EXPOSE 3306

# ENTRYPOINT sh  execute.sh

FROM alpine:3.12.0

#Install MAriaDB
RUN apk update && \
	apk add mariadb mariadb-client openrc && \
	rm -rf /var/cache/apk/*

COPY ./setup.sh .

# Comment next line for new wordpress
COPY wordpress.sql		wordpress.sql

RUN chmod 777 setup.sh

EXPOSE 3306

CMD sh setup.sh