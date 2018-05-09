# from https://gist.github.com/hardillb/0ce50250d40ff6fc3d623ddb5926ec4d
# Made several changes to component versions and some other housekeeping
FROM ubuntu:16.04
MAINTAINER Ben Hardill <hardillb@gmail.com> 

ENV DEBIAN_FRONTEND noninteractive 

USER root

RUN apt-get update && apt-get install -y \ 
	pkg-config \
	libssl-dev \
	libsasl2-dev \
	git \
	wget \
	mosquitto \
	mosquitto-clients \
	libmosquitto-dev \
	mosquitto-dev \
	jq \
	curl \
	mongodb-clients \
	libcurl4-openssl-dev \
	cron \
&& rm -rf /var/lib/apt/lists/*

#Need mosquitto source code to compile auth plugin
WORKDIR /usr/local/src
RUN wget http://mosquitto.org/files/source/mosquitto-1.4.14.tar.gz
RUN tar xvzf ./mosquitto-1.4.14.tar.gz

# Need mongo c driver for auth plugin
RUN wget https://github.com/mongodb/mongo-c-driver/releases/download/1.6.3/mongo-c-driver-1.6.3.tar.gz
RUN tar zxf ./mongo-c-driver-1.6.3.tar.gz
WORKDIR /usr/local/src/mongo-c-driver-1.6.3
RUN ./configure
RUN make
RUN make install
RUN ldconfig

# Fetch auth plugin
WORKDIR /usr/local/src
RUN git clone https://github.com/jpmens/mosquitto-auth-plug.git
WORKDIR /usr/local/src/mosquitto-auth-plug
COPY config.mk /usr/local/src/mosquitto-auth-plug
RUN make
RUN cp /usr/local/src/mosquitto-auth-plug/auth-plug.so /etc/mosquitto/
RUN cp /usr/local/src/mosquitto-auth-plug/np /etc/mosquitto/

RUN chown mosquitto /etc/mosquitto
COPY mosquitto.conf /etc/mosquitto/

COPY acls /etc/mosquitto/
COPY generate-CA.sh /etc/ssl/certs/

RUN mkdir -p /var/log/mosquitto/
WORKDIR /usr/local/src

#COPY docker-entrypoint.sh /usr/local/src/

#RUN chmod +x /usr/local/src/docker-entrypoint.sh

#ENTRYPOINT ["/usr/local/src/docker-entrypoint.sh"] 

COPY startup-mosquitto.sh /usr/local/src/
RUN chmod +x /usr/local/src/startup-mosquitto.sh
CMD ["/usr/local/src/startup-mosquitto.sh"]
