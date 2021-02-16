FROM alpine:3.12

RUN apk update && apk add vsftpd openssl && \
		apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache && \
		echo "root:toor" | chpasswd && \
		openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42/CN=127.0.0.1" \
		-keyout /etc/ssl/private/vsftpd.key \
		-out /etc/ssl/certs/vsftpd.crt

COPY 	/src/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY	/src/telegraf.conf			/etc/telegraf/
COPY	/src/execute.sh				/

EXPOSE	21 30021

CMD  vsftpd /etc/vsftpd/vsftpd.conf

ENTRYPOINT	sh execute.sh