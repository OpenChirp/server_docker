
# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang:1.10.2

RUN go get github.com/openchirp/gpsmapper-service

CMD ["/go/bin/gpsmapper-service"]