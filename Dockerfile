FROM golang:1-stretch
MAINTAINER Beauli Zhu <beaulizhu@gmail.com>


RUN echo -e "deb http://repo.mysql.com/apt/debian/ stretch mysql-5.7\ndeb-src http://repo.mysql.com/apt/debian/ stretch mysql-5.7" > /etc/apt/sources.list.d/mysql.list && \
    wget -O /tmp/RPM-GPG-KEY-mysql https://repo.mysql.com/RPM-GPG-KEY-mysql && \
    apt-key add /tmp/RPM-GPG-KEY-mysql && \
    apt update && \
    apt install -y mysql-community-client

RUN go get github.com/tools/godep && \
  (go get github.com/siddontang/go-mysql-elasticsearch || true ) && \
  cd /go/src/github.com/siddontang/go-mysql-elasticsearch && \
  make

COPY run.sh /run_go_mysql_es
ENTRYPOINT ["/run_go_mysql_es"]
