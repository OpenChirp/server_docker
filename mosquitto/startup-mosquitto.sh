#!/bin/bash
#
cd /etc/ssl/certs/
chmod +x generate-CA.sh
export HOSTLIST="mosquitto-server"
# generate self-signed certificate using generate-CA.sh (from https://github.com/owntracks/tools/blob/master/TLS/generate-CA.sh)
bash /etc/ssl/certs/generate-CA.sh mosquitto-server
chmod 777 /etc/ssl/certs/*
# startup mosquitto

mosquitto -c /etc/mosquitto/mosquitto.conf
