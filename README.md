# Dockerized Baseimage
[![Image][image-badge]][image-link]
[![License][license-badge]][license-link]
[![Build][build-badge]][build-link]

---

 * [Summary](#summary)
 * [Usage](#usage)
 * [Components](#components)
 * [Build Process](#build-process)
 * [Labels](#labels)
 * [User and Group Mapping](#user-and-group-mapping)

## Summary

A super small Alpine image for usage as a continuous integration base image.

## Usage

You can use this image locally with `docker run`, calling [`rsvg-convert`](http://manpages.ubuntu.com/manpages/zesty/man1/rsvg-convert.1.html) as such:

```console
docker run -v /media/:/media/ jrbeverly/rsvg rsvg-convert test.svg -o test.png
```

### Gitlab
You can setup a new docker image based on this image with the following:

```yaml
FROM jrbeverly/baseimage:3.5

RUN apk add --update make
```

## Image Tags

Build tags available with the image `jrbeverly/baseimage:{TAG}`.

| Tag | Status | Description |
| --- | ------ | ----------- |
| [![Version edge][edge-badge]][edge-link] | [![Image edge][edge-image-badge]][edge-link] | An alpine image based on `alpine:edge`. |
| [![Version 3.5][3.5-badge]][3.5-link] | [![Image 3.5][3.5-image-badge]][3.5-link] | An alpine image based on `alpine:3.5`. |
| [![Version 3.4][3.4-badge]][3.4-link] | [![Image 3.4][3.4-image-badge]][3.4-link] | An alpine image based on `alpine:3.4`. |
| [![Version 3.3][3.3-badge]][3.3-link] | [![Image 3.3][3.3-image-badge]][3.3-link] | An alpine image based on `alpine:3.3`. |
| [![Version 3.2][3.2-badge]][3.2-link] | [![Image 3.2][3.2-image-badge]][3.2-link] | An alpine image based on `alpine:3.2`. |

## Components

### Metadata Arguments

Metadata build arguments used in the system, the follow the [Label Schema Convention](http://label-schema.org).

| Variable | Value | Description |
| -------- | ----- |------------ |
| BUILD_DATE | see [metadata.variable](build/Makefile.metadata.variable) | The Date/Time the image was built. |
| VERSION | see [metadata.variable](build/Makefile.metadata.variable) | Release identifier for the contents of the image. |
| VCS_REF | see [metadata.variable](build/Makefile.metadata.variable) | Identifier for the version of the source code from which this image was built. |

### Build Arguments

Build arguments used in the system.

| Variable | Value | Description |
| -------- | ------- |------------ |
| DUID | see [user.variable](build/Makefile.user.variable) | The [user id](http://www.linfo.org/uid.html) of the docker user. |
| DGID | see [user.variable](build/Makefile.user.variable) | The [group id](http://www.linfo.org/uid.html) of the docker user's group. |

### Volumes

Volumes exposed by the docker container.[^1]

| Volume | Description |
| ------ | ----------- |

### Environment Variables

Environment variables used in the system.

| Variable | Default | Description |
| -------- | ------- |------------ |
| HOME | / | The pathname of the user's home directory. |

## Build Process

To build the docker image, use the included [`Makefile`](Makefile). It is recommended to use the makefile to ensure all build arguments are provided.

```
make VERSION=3.5 build
```

You can also build the image manually, as visible in [`Makefile`](Makefile).  However this is discouraged as the makefile ensures all build arguments are properly formatted.

## Labels

The docker image follows the [Label Schema Convention](http://label-schema.org).  The values in the namespace can be accessed by the following command:

```console
docker inspect -f '{{ index .Config.Labels "org.label-schema.LABEL" }}' IMAGE
```

The label namespace `io.gitlab.jrbeverly` is common among `jrbeverly-docker` images and is a loosely structured set of values.  The values in the namespace can be accessed by the following command:

```console
docker inspect -f '{{ index .Config.Labels "io.gitlab.jrbeverly.LABEL" }}' IMAGE
```

## User and Group Mapping

All processes within the docker container will be run as the **docker user**, a non-root user.  The **docker user** is created on build with the user id `DUID` and a member of a group with group id `DGID`.  

Any permissions on the host operating system (OS) associated with either the user (`DUID`) or group (`DGID`) will be associated with the docker user.  The values of `DUID` and `DGID` are visible in the [Build Arguments](#build-arguments), and can be accessed by the commands:

```console
docker inspect -f '{{ index .Config.Labels "io.gitlab.jrbeverly.user" }}' IMAGE
docker inspect -f '{{ index .Config.Labels "io.gitlab.jrbeverly.group" }}' IMAGE
```

The notation of the build variables is short form for docker user id (`DUID`) and docker group id (`DGID`). 

[^1]: It is necessary to ensure that the **docker user** (`DUID`) has permission to access volumes. (see [User / Group Identifiers](#user-and-group-mapping))

[build-badge]: https://gitlab.com/jrbeverly-docker/docker-baseimage/badges/master/build.svg
[build-link]: https://gitlab.com/jrbeverly-docker/docker-baseimage/commits/master

[license-badge]: https://images.microbadger.com/badges/license/jrbeverly/baseimage.svg
[license-link]: https://microbadger.com/images/jrbeverly/baseimage "Get your own license badge on microbadger.com"

[image-badge]: https://img.shields.io/badge/alpine-_-orange.svg?maxAge=2592000
[image-link]: https://hub.docker.com/_/alpine/

[edge-badge]: https://images.microbadger.com/badges/version/jrbeverly/baseimage:edge.svg
[edge-image-badge]: https://images.microbadger.com/badges/image/jrbeverly/baseimage:edge.svg
[edge-link]: https://microbadger.com/images/jrbeverly/baseimage:edge "Get your own version badge on microbadger.com"

[3.5-badge]: https://images.microbadger.com/badges/version/jrbeverly/baseimage:3.5.svg
[3.5-image-badge]: https://images.microbadger.com/badges/image/jrbeverly/baseimage:3.5.svg
[3.5-link]: https://microbadger.com/images/jrbeverly/baseimage:3.5 "Get your own version badge on microbadger.com"

[3.4-badge]: https://images.microbadger.com/badges/version/jrbeverly/baseimage:3.4.svg
[3.4-image-badge]: https://images.microbadger.com/badges/image/jrbeverly/baseimage:3.4.svg
[3.4-link]: https://microbadger.com/images/jrbeverly/baseimage:3.4 "Get your own version badge on microbadger.com"

[3.3-badge]: https://images.microbadger.com/badges/version/jrbeverly/baseimage:3.3.svg
[3.3-image-badge]: https://images.microbadger.com/badges/image/jrbeverly/baseimage:3.3.svg
[3.3-link]: https://microbadger.com/images/jrbeverly/baseimage:3.3 "Get your own version badge on microbadger.com"

[3.2-badge]: https://images.microbadger.com/badges/version/jrbeverly/baseimage:3.2.svg
[3.2-image-badge]: https://images.microbadger.com/badges/image/jrbeverly/baseimage:3.2.svg
[3.2-link]: https://microbadger.com/images/jrbeverly/baseimage:3.2 "Get your own version badge on microbadger.com"