Node-exporter-docker
================
[Node-exporter](https://github.com/prometheus/node_exporter) is a Prometheus exporter for machine metrics, written in Go with pluggable metric collectors.

[![Build Status](https://travis-ci.org/RaymondMouthaan/node-exporter-docker.svg?branch=master)](https://travis-ci.org/RaymondMouthaan/node-exporter-docker)
[![This image on DockerHub](https://img.shields.io/docker/pulls/raymondmm/node-exporter.svg)](https://hub.docker.com/r/raymondmm/node-exporter/)

This project builds a docker image and adds qemu-arm-static and uses manifest-tool to push manifest list to docker hub.

Adds the capability of obtain the host hostname and expose it as a value in the container.

## Architectures
Currently supported architectures:
- **linux-arm32v6**
- **linux-arm64v8**
- **linux-amd64**

## Usage
### docker run
```
docker run -it -p9100:9100 --name myNodeExporter \
  -v /proc:/host/proc \
  -v /sys:/host/sys \
  -v /:/rootfs \
  -v /etc/hostname:/etc/host_hostname \
  -e HOST_HOSTNAME=/etc/host_hostname \
  raymondmm/node-exporter:latest \
  --path.procfs /host/proc \
  --path.sysfs /host/sys \
  --collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)" \
  --collector.textfile.directory /etc/node-exporter
```

### docker stack

```
docker stack deploy node-exporter --compose-file docker-compose-node-exporter.yml
```

Example of docker-compose.yml

```
  node-exporter:
    image: raymondmm/node-exporter
    environment:
      - NODE_ID={{.Node.ID}}
    volumes:
      - /etc/hostname:/etc/nodename:ro
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /mnt/docker-cluster:/mnt/docker-cluster:ro
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/TZ:ro
    command:
      - '--path.procfs=/host/proc'
      - '--path.sysfs=/host/sys'
      - '--collector.textfile.directory=/etc/node-exporter/'
      - '--collector.filesystem.ignored-mount-points=^/(sys|proc|dev|host|etc)($$|/)'
      # no collectors are explicitely enabled here, because the defaults are just fine,
      # see https://github.com/prometheus/node_exporter
      # disable ipvs collector because it barfs the node-exporter logs full with errors on my centos 7 vm's
      - '--no-collector.ipvs'
    ports:
      - 9100:9100
    networks:
      - indonesia-net
    deploy:
      mode: global
      restart_policy:
        condition: on-failure
```

For more details check the official documentation at [Prometheus Node-Exporter](https://github.com/prometheus/node_exporter).
