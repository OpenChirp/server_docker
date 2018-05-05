# python container; see https://hub.docker.com/_/python/
FROM python:3

# change working directory
WORKDIR /code

# copy code into the docker container 
COPY ./code/ /code/

# install dependencies
RUN pip install -r requirements.txt

# copy config file
COPY service.conf /run/service.conf.start

COPY startup-service.sh /run/
COPY wait-for-it.sh /run/
RUN chmod +x /run/wait-for-it.sh
RUN chmod +x /run/startup-service.sh
CMD ["/run/wait-for-it.sh", "rest:10010", "--","/bin/bash", "/run/startup-service.sh"]
