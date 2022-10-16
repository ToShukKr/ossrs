FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    unzip \
    tcl \
    cmake \
    pkg-config \
    patch \
    wget

WORKDIR /root

RUN wget https://github.com/ossrs/srs/releases/download/v4.0-r3/srs-server-4.0-r3.tar.gz

RUN tar -xf srs-server-4.0-r3.tar.gz

WORKDIR /root/srs-server-4.0-r3/trunk

RUN ./configure

RUN make

RUN mkdir -p /opt/srs/objs

RUN cp -r conf/ /opt/srs/conf

RUN cp objs/srs /opt/srs/objs/srs

RUN rm -rf /root/srs-server-4.0-r3

WORKDIR /opt/srs

CMD ["./objs/srs", "-c", "conf/docker.conf"]
