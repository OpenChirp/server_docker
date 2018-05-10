#!/bin/bash
# Wait for seed_data container to finish generating tokens
while [ ! -f /tokens/mapper_service.token ]
do
  sleep 2
done

source /tokens/mapper_service.token
source /run/service.env

# Start service
export FRAMEWORK_SERVER MQTT_SERVER HTTP_PORT SERVICE_ID SERVICE_TOKEN
/go/bin/gpsmapper-service