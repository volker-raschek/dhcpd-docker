# dhcpd-docker

[![Build Status](https://drone.cryptic.systems/api/badges/volker.raschek/dhcpd-docker/status.svg)](https://drone.cryptic.systems/volker.raschek/dhcpd-docker)
[![Docker Pulls](https://img.shields.io/docker/pulls/volkerraschek/dhcpd)](https://hub.docker.com/r/volkerraschek/dhcpd)

This project contains all sources to build the container image
`docker.io/volkerraschek/dhcpd`. The primary goal of the image is to run the
ISC-DHCPD server inside a container to support distributions which does not
deploy a newer version of the DHCP server.

## Usage

### IPv4 (default)

```bash
$ docker run \
    --env DHCP_INTERFACES=br0 \
    --env DHCP_IP=4 \
    --rm \
    --volume ${PWD}/config:/etc/dhcp:ro \
    --volume ${PWD}/data:/var/lib/dhcp:rw \
    --volume /etc/localtime:/etc/localtime:ro \
      volkerraschek/dhcpd-docker:latest
```

### IPv6

```bash
$ docker run \
    --env DHCP_INTERFACES=br0 \
    --env DHCP_IP=4 \
    --rm \
    --volume ${PWD}/config:/etc/dhcpd:ro \
    --volume ${PWD}/data:/var/lib/dhcp:rw \
    --volume /etc/localtime:/etc/localtime:ro \
      volkerraschek/dhcpd-docker:latest
```

## Build image manually

To build the images manually check out the
[repository](https://drone.cryptic.systems/volker.raschek/dhcpd-docker) with
`git` and use the `make` command to build the container images.

```bash
make container-image/build
```
