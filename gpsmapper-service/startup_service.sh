#!/bin/bash
# Wait for seed_data container to finish generating tokens
while [ ! -f /tokens/mapper_service.token ]
do
  sleep 2
done

# Add tokens to env file
cat /tokens/mapper_service.token >> /run/service.env
# Set environment variable
source /run/service.env
export $(cut -d= -f1 /tokens/storage_service.token)
# Start service
/go/bin/gpsmapper-service