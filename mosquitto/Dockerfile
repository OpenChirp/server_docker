# from https://github.com/eclipse/mosquitto/tree/53616be0e296f6186f52c791e241c76d53380078/docker/1.4.10
FROM alpine:3.5 
MAINTAINER David Audet <david.audet@ca.com>

RUN apk update
RUN apk add bash

LABEL Description="Eclipse Mosquitto MQTT Broker"

RUN apk --no-cache add mosquitto && \
    mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log && \
    cp /etc/mosquitto/mosquitto.conf /mosquitto/config && \
    chown -R mosquitto:mosquitto /mosquitto && \
    apk --no-cache add openssl

COPY mosquitto.conf /mosquitto/config/
COPY docker-entrypoint.sh /
RUN chmod +x docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"] 

# IMPORTANT: startup-mosquitto.sh will generate a self-signed certificate for mosquitto
# (a new certificate must be generated if the docker instance changes address)
COPY startup-mosquitto.sh /
RUN chmod +x /startup-mosquitto.sh
CMD ["/startup-mosquitto.sh"]
