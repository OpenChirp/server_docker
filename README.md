# Openchirp Server Docker
Multi-container docker setup for Openchirp Services. 

## Environment Variables
The openchirp docker uses the following environment variables. Please set these environment variables before running the docker commands.


|Variable Name | Description|
|---------------|--------------------|
| HOSTNAME   | This should be set to a DNS resolvable hostname for the machine or set to localhost. Please note, website won't work if this value is not set |  
| ADMIN_PASSWORD   | Password for admin user to login to website and grafana |  
| REST_MQTT_PASSWORD | Password for the rest server to mosquitto connection |

## Quick reference
Remember to set the environment variabled described above before running the command below.
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

| Port | Container| Credentials|
| ------|----------|------------|
| 80    | Website|  Static Content|
| 7000  | REST API| admin@localhost.com  : $ADMIN_PASSWORD|
| 1883   | MQTT|-|
| 3000   | Grafana| admin  : $ADMIN_PASSWORD|
| 9000   | Mapper Service|-|

For development configuration, all databases ports are exposed too .

## Website Address

The demo website is configured for the hostname set in $HOSTNAME environment variable (http://$HOSTNAME). Login using email : admin@localhost.com and password: $ADMIN_PASSWORD


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
9. **gpsmapper-service** (mapper service); [Source Repo](https://github.com/OpenChirp/gpsmapper-service)
10. **seed-data** (this container seeds data and exits); 

## Multiple Configurations

The `docker-compose.yml` contains the base configuration and `docker-compose.override.yml` is used to setup the containers for a **demonstration configuration**. By default, [Compose](https://docs.docker.com/compose/) will read `docker-compose.yml` and `docker-compose.override.yml`.

See [Share Compose configurations between files and projects](https://docs.docker.com/compose/extends/) for details.

These are the configurations provided:

* **docker-compose.yml**: Base Configuration

* **docker-compose.override.yml**: Demonstration Configuration (**default**)

* **docker-compose.devel.yml**: Development Configuration

* **docker-compose.test-rest.yml**: Starts services needed to tests the REST application

### Demonstration Configuration

The demonstration configuration uses pre-built Openchirp images from [Docker Hub](https://hub.docker.com/u/openchirp/), persists data on the host, exposes a minimal amount of ports, restarts services automatically and defines log limits. ** This is the default configuration **

### Development Configuration

The development configuration compiles all the code locally and mounts the code volumes from host machine to the containers. This configuration persists data on the host in data folder and also exposes all the database ports.  To start a fresh instance with no previous data, just deleting the data folder will do the trick. 

Before starting a development configuration you should get the source code using the **fetch-repos.sh** script:
> chmod +x fetch-repos.sh && ./fetch-repos.sh

You start a **development configuration** using the **docker-compose.devel.yml** file:

> `docker-compose -f docker-compose.yml -f docker-compose.devel.yml up -d`


## Openchirp Docker Images

Docker images with the Openchirp services application code and configuration were created, and are used by the **demonstration configuration**. The workflow intended is to use the development configuration(s) to perform changes, and then create new releases of the images which are then uploaded to Docker Hub. This allows to package the whole service (code included) in a docker image that can be easily redistributed.

Once you have a working application, you can create a set of images using the **commit-and-push-images.sh  script**, which takes an image tag as argument. E.g. to commit images with a “v1” tag, do:

> `./commit-and-push-images.sh v1`

## Future...

### SSL Configuration
SSL configuration is not done for HTTP and MQTT ports exposed.

### Reverse Proxy Setup
The apache config for proxying requests to ports 7000, 3000, 9000 is not done.

### Monitoring

A [monitoring, logging and alerting suite](https://github.com/uschtwill/docker_monitoring_logging_alerting) can be integrated into this application.
