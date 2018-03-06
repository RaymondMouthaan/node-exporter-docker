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
docker run -d TODO
```

### docker stack

```
docker stack deploy node-exporter --compose-file docker-compose-node-exporter.yml
```

Example of docker-compose.yml

```
TODO
```

For more details check the official documentation at [Prometheus Node-Exporter](https://github.com/prometheus/node_exporter).
