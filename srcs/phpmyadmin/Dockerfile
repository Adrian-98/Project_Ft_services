FROM	alpine:3.12

RUN		apk add wget php php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session && \
		apk add openrc && \
		wget https://files.phpmyadmin.net/phpMyAdmin/4.9.2/phpMyAdmin-4.9.2-all-languages.tar.gz && \
		tar -xzvf phpMyAdmin-4.9.2-all-languages.tar.gz && \
		rm -rf phpMyAdmin-4.9.2-all-languages.tar.gz && \
		mkdir -p /www/phpmyadmin &&\
		mv phpMyAdmin-4.9.2-all-languages/* /www/phpmyadmin


COPY	/srcs/config.inc.php		/www/phpmyadmin/config.inc.php
COPY	/srcs/execute.sh				/

EXPOSE	5000

ENTRYPOINT sh execute.sh
