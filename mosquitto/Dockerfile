# from https://github.com/eclipse/mosquitto/tree/53616be0e296f6186f52c791e241c76d53380078/docker/1.4.10
FROM alpine:3.5 
MAINTAINER David Audet <david.audet@ca.com>

RUN apk update
RUN apk add bash

LABEL Description="Eclipse Mosquitto MQTT Broker"

RUN apk --no-cache add mosquitto=1.4.10-r2 && \
    mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log && \
    cp /etc/mosquitto/mosquitto.conf /mosquitto/config && \
    chown -R mosquitto:mosquitto /mosquitto

COPY mosquitto.conf /mosquitto/config/
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]