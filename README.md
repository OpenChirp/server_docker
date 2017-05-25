# Openchirp Server Socker
Multi-container docker instances for Openchirp Server Services. 

Use `docker-compose` (from inside the `openchirp-docker` repo folder):
`docker-compose up`

## Openchirp Services

### web
Apache : Hosts static angular2 website files

Source Repo : https://github.com/OpenChirp/website

### node
Node.js : Hosts REST Server

Source Repo : https://github.com/OpenChirp/openchirp_rest   

### influxdb
### mongodb
### redis
### mosquitto

## Other services

### mqtt-tsdb-storage-service
TSDB Storage Service ( Python code) 

Source Repo : https://github.com/OpenChirp/mqtt_tsdb_storage_service

### serialization-service
Lora Serialization Service( Go code)

Source Repo : https://github.com/OpenChirp/easybits
