#!/bin/bash
#

# Khushboo commented out the self signed CA setup for SSL done by Nuno.
#cd /etc/ssl/certs/
#chmod +x generate-CA.sh
#export HOSTLIST="mosquitto-server"
# generate self-signed certificate using generate-CA.sh (from https://github.com/owntracks/tools/blob/master/TLS/generate-CA.sh)
#bash /etc/ssl/certs/generate-CA.sh mosquitto-server
#chmod 777 /etc/ssl/certs/*

#
#Save openchirp_rest user(for node.js app) and its hashed password in file backend for mosquitto auth
echo "openchirp_rest:"$(/etc/mosquitto/np -p $REST_MQTT_PASSWORD) >  /etc/mosquitto/passwords

# startup mosquitto
mosquitto -c /etc/mosquitto/mosquitto.conf
