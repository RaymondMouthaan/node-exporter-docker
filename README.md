Node-exporter-docker
================
[Node-exporter](https://github.com/prometheus/node_exporter) is a Prometheus exporter for machine metrics, written in Go with pluggable metric collectors.

[![Build Status](https://travis-ci.org/RaymondMouthaan/node-exporter-docker.svg?branch=master)](https://travis-ci.org/RaymondMouthaan/node-exporter-docker)
[![This image on DockerHub](https://img.shields.io/docker/pulls/raymondmm/node-exporter.svg)](https://hub.docker.com/r/raymondmm/node-exporter/)

This project builds a docker image and adds qemu-arm-static and uses manifest-tool to push manifest list to docker hub.

## Architectures
Currently supported archetectures:
- **linux-arm**

## Usage
### docker run
```
docker run -it -p9199:9100 --name myNodeExporter \
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
version: "3.4"

...
services:

  node-exporter:
      image: raymondmm/node-exporter
      environment:
        - HOST_HOSTNAME=/etc/host_hostname
      volumes:
        - /proc:/host/proc:ro
        - /sys:/host/sys:ro
        - /:/rootfs:ro
        - /etc/hostname:/etc/host_hostname:ro
      command:
        - '--path.procfs=/host/proc'
        - '--path.sysfs=/host/sys'
        - --collector.filesystem.ignored-mount-points
        - "^/(sys|proc|dev|host|etc|rootfs/var/lib/docker/containers|rootfs/var/lib/docker/overlay2|rootfs/run/docker/netns|rootfs/var/lib/docker/aufs)($$|/)"
        - '--collector.textfile.directory=/etc/node-exporter'
      ports:
        - 9100:9100
      networks:
        - monitor-net

      deploy:
        mode: global
        restart_policy:
          condition: on-failure
...        
```

For more details check the official documentation at [Prometheus Node-Exporter](https://github.com/prometheus/node_exporter).
