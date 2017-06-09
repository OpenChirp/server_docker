# Openchirp Server Docker
Multi-container docker setup for Openchirp Services. 

### Quick reference

* Start-up the application by running [Compose](https://docs.docker.com/compose/) inside the `server_docker` repo folder.

  * For a **demonstration configuration**:

  > `docker-compose up -d`

  * For a **development configuration**:

  > `docker-compose -f docker-compose.yml -f docker-compose.devel.yml up -d`   
   
* List running containers:

  > `docker-compose ps`

* See the logs:

  > `docker-compose logs`

* Stop the application

  > `docker-compose stop`

* More: Check [Compose Documentation](https://docs.docker.com/compose/overview/)

## Containers

The application is composed of the following containers.

1. **web** (apache server; static angular2 website files; [Source Repo](https://github.com/OpenChirp/website))

2. **node** (node.JS application; REST API server application; [Source Repo](https://github.com/OpenChirp/openchirp_rest))

3. **mongodb** (database)

4. **influxdb** (time series database)

5. **redis** (data structure store)

6. **mosquitto** (MQTT broker)

7. **mqtt-tsdb-storage-service** (time series storage service)
   TSDB Storage Service; [Source Repo](https://github.com/OpenChirp/mqtt_tsdb_storage_service)
<!--
<>8. **serialization-service**
<>   Lora Serialization Service; [Source Repo](https://github.com/OpenChirp/easybits)
-->

## Multiple Configurations

The `docker-compose.yml` contains the base configuration and `docker-compose.override.yml` is used to setup the containers for a **demonstration configuration**. By default, [Compose](https://docs.docker.com/compose/) will read `docker-compose.yml` and `docker-compose.override.yml`.

See [Share Compose configurations between files and projects](https://docs.docker.com/compose/extends/) for details.

These are the configurations provided:

* **docker-compose.yml**: Base Configuration

* **docker-compose.override.yml**: Demonstration Configuration (**default**)

* **docker-compose.devel.yml**: Development Configuration with no persistence

* **docker-compose.devel-persistence.yml**: Development Configuration with persistence

### Demonstration Configuration

The demonstration configuration uses pre-built Openchirp images from [Docker Hub](https://hub.docker.com/u/openchirp/), persists data on the host, exposes a minimal amount of ports, restarts services automatically and defines log limits. ** This is the default configuration **

### Development Configuration

You can start a **development configuration** using the **docker-compose.devel.yml** file by running:

> `docker-compose -f docker-compose.yml -f docker-compose.devel.yml up -d`

The development configuration exposes all service ports, does not do persistance and mounts application code from the host.

You also have a **development configuration** with persistence configured in the **docker-compose.devel-persistence.yml**. Run it with:

> `docker-compose -f docker-compose.yml -f docker-compose.devel-persistence.yml up -d`


## Monitoring


https://github.com/uschtwill/docker_monitoring_logging_alerting