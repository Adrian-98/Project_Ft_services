FROM alpine:3.12

RUN apk update && apk add influxdb && \
    rm -rf /var/cache/apk/*

EXPOSE	8086

CMD /usr/sbin/influxd