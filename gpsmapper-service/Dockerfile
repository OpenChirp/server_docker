
# TODO : use a slimmer image to reduce overall image size
# Using a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang:1.10.2

RUN go get github.com/openchirp/gpsmapper-service
COPY startup_service.sh /run/
COPY service.env /run/
RUN chmod +x /run/startup_service.sh
#RUN source /run/service.env
CMD ["/bin/bash","/run/startup_service.sh"]
