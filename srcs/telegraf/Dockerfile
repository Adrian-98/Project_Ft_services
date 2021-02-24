FROM	alpine:3.12.0

RUN		apk update

#Intall Telegraf
RUN		apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/
RUN		rm -rf /var/cache/apk/*

CMD		/usr/bin/telegraf