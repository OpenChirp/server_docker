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

## Website Address

The demo website is configured for the URL [openchirp.demo](https://openchirp.demo). You need to make this address resolve to the container host so that **your** browser can access this URL. One way to do this is to add `<ip-of-container-host> openchirp.demo` to your [hosts](https://en.wikipedia.org/wiki/Hosts_(file)) file.

If you are deploying the application in a docker host with a name that can be resolved with DNS, configure your instance to use this name by editing the `httpd/config.ts` file (this is a copy of [this config.ts](https://github.com/OpenChirp/website/blob/master/src/app/config.ts)). This will require rebuilding the image using the development config: 
  > `docker-compose rm web && docker-compose -f docker-compose.yml -f docker-compose.devel.yml up --build -d`.

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

### Mosquitto Configuration
Currently Mosquitto is configured with two listners: TLS on port 1883 and no security on port 1884. The later port is not mapped and should not be accessible outside the docker environment. It was needed so that the rest application could connect to the Mosquitto server with minor changes (change the config file as opposed to change the code to support self-signed certificates used by the this docker instance of Mosquitto).

Mosquitto is also not configured with users or ACLs.

### Authentication

The rest service is configured with no auth.

## Monitoring

A [monitoring, logging and alerting suite](https://github.com/uschtwill/docker_monitoring_logging_alerting) can be integrated into this application.
