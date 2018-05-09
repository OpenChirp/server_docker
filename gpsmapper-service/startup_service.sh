#!/bin/bash
# Wait for seed_data container to finish generating tokens
while [ ! -f /tokens/mapper_service.token ]
do
  sleep 2
done
# Add tokens to env file
cat /tokens/mapper_service.token >> /run/service.env

/go/bin/gpsmapper-service -e /run/service.env