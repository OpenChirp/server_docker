# go container; see https://hub.docker.com/_/golang/
FROM golang

# clone mqtt_tsdb_storage_service repo code into the docker container 
RUN git clone https://github.com/OpenChirp/easybits.git /go/src/app

# change working directory
WORKDIR /go/src/app

RUN go get -d -v

RUN go build