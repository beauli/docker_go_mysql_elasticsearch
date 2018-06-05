FROM golang:1-alpine3.7
MAINTAINER Beauli Zhu <beaulizhu@gmail.com>


RUN apk update && \
    apk add mysql-client && \
    apk add git && \
    apk add make

RUN go get github.com/tools/godep && \
  (go get github.com/siddontang/go-mysql-elasticsearch || true ) && \
  cd /go/src/github.com/siddontang/go-mysql-elasticsearch && \
  make

COPY run.sh /run_go_mysql_es
ENTRYPOINT ["/run_go_mysql_es"]
