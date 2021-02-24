# FROM alpine:3.12

# RUN apk update && apk add wget php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session
# RUN mkdir -p /usr/share/webapps/ && cd /usr/share/webapps/
# RUN wget https://wordpress.org/wordpress-5.6.tar.gz

# RUN tar -xzvf wordpress-5.6.tar.gz 
# RUN rm wordpress-5.6.tar.gz

# RUN mkdir -p /var/www && mv /wordpress /var/www/

# COPY	/src/wp-config.php			/var/www/wordpress/
# COPY	/src/execute.sh				/

# EXPOSE	5050

# ENTRYPOINT sh execute.sh
FROM alpine:3.12.0

RUN apk update && \
	apk add wget && \
	apk add php php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

#Install Wordpress
RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xvf latest.tar.gz && \
	mkdir /www &&\
	mv wordpress/* /www && \
	rm -rf /var/cache/apk/* && \
	rm -rf latest.tar.gz

COPY /src/wp-config.php /www/wp-config.php

EXPOSE 5050

CMD php -S 0.0.0.0:5050 -t /www/