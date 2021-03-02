# FROM alpine:3.12

# RUN apk update && apk add vsftpd openssl && \
# 	apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache && \
# 	openssl req -x509 -out /etc/ssl/certs/vsftpd.crt -keyout /etc/ssl/private/vsftpd.key -newkey rsa:2048 -nodes -sha256 -subj '/CN=localhost'

# #create user
# RUN		echo -e "user\nuser" | adduser user -h /ftps_user;
# RUN		chown user:user /ftps_user
# RUN		touch /var/log/vsftpd.log
# RUN		echo "user" >> /etc/vsftpd/vsftpd.userlist

# #COPY 	/src/vsftpd.conf /etc/vsftpd/vsftpd.conf
# COPY	/src/telegraf.conf			/etc/telegraf/
# COPY	/src/execute.sh				/

# EXPOSE 20 21 31000

# CMD  vsftpd /etc/vsftpd/vsftpd.conf

# ENTRYPOINT	sh execute.sh
FROM	alpine:3.12.0

RUN		apk update &&\
		apk add openssl &&\
		apk add vsftpd &&\
		rm -rf /var/cache/apk/*

RUN    apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

#FTPS conf
RUN		echo -e "user\nuser" | adduser user -h /ftps_user; &&\
		chown user:user /ftps_user &&\
		touch /var/log/vsftpd.log &&\
		echo "user" >> /etc/vsftpd/vsftpd.userlist &&\
		openssl req -x509 -out /etc/ssl/certs/vsftpd.crt -keyout /etc/ssl/private/vsftpd.key -newkey rsa:2048 -nodes -sha256 -subj '/CN=localhost'

COPY	/src/telegraf.conf			/etc/telegraf/
COPY	/src/execute.sh				/

EXPOSE	20 21 31000

CMD		vsftpd /etc/vsftpd/vsftpd.conf

ENTRYPOINT	sh execute.sh