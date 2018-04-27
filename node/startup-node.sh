#!/bin/bash
#
sed -e "s/REST_MQTT_PASSWORD/$REST_MQTT_PASSWORD/" /usr/src/app/config/docker.json
  
npm start
