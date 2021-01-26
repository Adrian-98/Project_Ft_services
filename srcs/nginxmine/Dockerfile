FROM alpine:latest

RUN apk update && apk add nginx

RUN adduser -D -g 'www' www \
&& mkdir /www && chown -R www:www /var/lib/nginx \		
&& chown -R www:www /www 

RUN rm /etc/nginx/nginx.conf

#COPY id_rsa_key_ssh /etc/ssh/ssh_host_rsa_key
#COPY sshd_config /etc/ssh/
COPY nginx.conf /etc/nginx/
COPY /start.sh			/

ENTRYPOINT	sh start.sh

EXPOSE 80