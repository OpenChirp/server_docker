# Openchirp Server Docker
Multi-container docker setup for Openchirp Services. 

## Environment Variables
The openchirp docker uses the following environment variables:
 Variable Name | Description|
---------------|--------------------|
ADMIN_PASSWORD   | Admin password for REST API and grafana |  
REST_MQTT_PASSWORD | Password for the rest server to mosquitto connection |

## Quick reference
Please set the environment variables before running the commands.
* Start-up the application by running [Compose](https://docs.docker.com/compose/) inside the `server_docker` repo folder.

  * For a **demonstration configuration**:
The following command pulls pre-built openchirp images from docker hub. 

  > `docker-compose up -d`
  

  * For a **development configuration**:
 The following command compiles the code locally. Run ./fetch-repos.sh before running this command to clone the openchirp repos from github.

  > `docker-compose -f docker-compose.yml -f docker-compose.devel.yml up -d`   

   
* List running containers:

  > `docker-compose ps`

* See the logs:

  > `docker-compose logs`

* Stop the application

  > `docker-compose stop`

* More: Check [Compose Documentation](https://docs.docker.com/compose/overview/)

## Ports Exposed
 Port | Container| Credentials|
------|----------|
80    | Website|  Static Content
7000  | REST API| admin@localhost.com  : $ADMIN_PASSWORD|
1883   | MQTT|
3000   | Grafana| admin  : $ADMIN_PASSWORD
9000   | Mapper Service|

For development configuration , all databases ports are exposed too .

## Website Address

The demo website is configured for localhost (http://localhost). An admin user is seeded 

If you are deploying the application in a docker host with a name that can be resolved with DNS, configure your instance to use this name by editing the `httpd/config.ts` file (this is a copy of [this config.ts](https://github.com/OpenChirp/website/blob/master/src/app/config.ts)). This will require rebuilding the image using the development config: 
  > `docker-compose rm web && docker-compose -f docker-compose.yml -f docker-compose.devel.yml up --build -d`.

## Containers

The application is composed of the following containers.

1. **web** (apache server; static angular2 website files; [Source Repo](https://github.com/OpenChirp/website))

2. **node** (node.JS application; REST API server application; [Source Repo](https://github.com/OpenChirp/openchirp_rest))

3. **mongodb** (all metadata about users, devices, services, locations, templates etc in stored in this database)

4. **influxdb** (time series database)

5. **redis** (user session store)

6. **mosquitto** (MQTT broker)

7. **mqtt-influx-storage-service** (time series storage service)
   InfluxDB Storage Service; [Source Repo](https://github.com/OpenChirp/mqtt_influx_storage_service)
8. **grafana** (visualization service); [Source Repo](https://github.com/OpenChirp/grafana_dashboards)
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

* **docker-compose.test-rest.yml**: Starts services needed to tests the REST application

### Demonstration Configuration

The demonstration configuration uses pre-built Openchirp images from [Docker Hub](https://hub.docker.com/u/openchirp/), persists data on the host, exposes a minimal amount of ports, restarts services automatically and defines log limits. ** This is the default configuration **

### Development Configuration

The development configuration exposes all service ports, does not persist files and mounts application code from the host.

Before starting a development configuration you should get the source code using the **fetch-repos.sh** script:
> chmod +x fetch-repos.sh && ./fetch-repos.sh

You start a **development configuration** using the **docker-compose.devel.yml** file:

> `docker-compose -f docker-compose.yml -f docker-compose.devel.yml up -d`

You also have a **development configuration** with persistence configured in the **docker-compose.devel-persistence.yml**. Run it with:

> `docker-compose -f docker-compose.yml -f docker-compose.devel-persistence.yml up -d`

## Openchirp Docker Images

Docker images with the Openchirp services application code and configuration were created, and are used by the **demonstration configuration**. The workflow intended is to use the development configuration(s) to perform changes, and then create new releases of the images which are then uploaded to Docker Hub. This allows to package the whole service (code included) in a docker image that can be easily redistributed.

Once you have a working application, you can create a set of images using the **commit-and-push-images.sh  script**, which takes an image tag as argument. E.g. to commit images with a “v1” tag, do:

> `./commit-and-push-images.sh v1`

## Future...

### SSL Configuration
SSL configuration is not done for HTTP and MQTT ports exposed.

### Monitoring

A [monitoring, logging and alerting suite](https://github.com/uschtwill/docker_monitoring_logging_alerting) can be integrated into this application.
