# python container; see https://hub.docker.com/_/python/
FROM python

# clone mqtt_tsdb_storage_service repo code into the docker container 
RUN git clone https://github.com/OpenChirp/mqtt_tsdb_storage_service.git /code

# change working directory
WORKDIR /code

# copy config file
ADD service.config /code/

# install dependencies
RUN pip install -r requirements.txt