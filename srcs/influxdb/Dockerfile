FROM alpine:3.12

RUN apk update && apk add openrc --no-cache && \
	apk add influxdb && \
    openrc && touch /run/openrc/softlevel

COPY	/src/execute.sh				/

EXPOSE	8086

ENTRYPOINT sh execute.sh