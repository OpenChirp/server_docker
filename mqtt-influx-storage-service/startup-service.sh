#!/bin/bash

# Wait for seed_data container to finish generating tokens
while [ ! -f /tokens/storage_service.token ]
do
  sleep 2
done

source /tokens/storage_service.token

#Update service ID and its token in service configuration file
sed -e "s/SERVICE_ID/$SERVICE_ID/" /run/service.conf.start | \
    sed -e "s/PASSWORD/$SERVICE_TOKEN/" > /run/service.conf

#Start service
python /code/influx_service.py -f /run/service.conf
  
