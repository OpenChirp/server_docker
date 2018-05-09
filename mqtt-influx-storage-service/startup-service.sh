#!/bin/bash


#1. Wait for file to be available
#2. Load variable from file
#Update service ID and its token in service configuration file
sed -e "s/SERVICE_ID/$SERVICE_ID/" /run/service.conf.start | \
    sed -e "s/PASSWORD/$TOKEN/" > /run/service.conf

#Start service
python /code/influx_service.py -f /run/service.conf
  
