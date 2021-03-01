FROM alpine:3.12

RUN apk update && apk add influxdb && \
    rm -rf /var/cache/apk/*

COPY      /usr/local/etc/influxdb.conf
EXPOSE	8086

CMD /usr/sbin/influxd