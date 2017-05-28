FROM alpine:3.5
MAINTAINER jrbeverly

# Environment Variables
#
# Environment variables present in the docker container.
ENV HOME=/

# Provision
#
# Copy and execute provisioning scripts of the docker container.
COPY provision/install.sh /tmp/install.sh
RUN sh /tmp/install.sh && rm -f /tmp/install.sh

# Options
#
# Configuration options of the docker container.
WORKDIR /media
ENTRYPOINT []
CMD []

# User Arguments
#
# Arguments used in the user process of the docker container.
ARG DUID
ARG DGID

# User
#
# Configuration of the docker user for container execution.
RUN addgroup -g ${DGID} -S docker && adduser -S -G docker -u ${DUID} docker

# Metadata Arguments
#
# Arguments used for the metadata of the docker container.
ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

# Metadata 
#
# The metadata of the docker container.
LABEL \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="baseimage" \
    org.label-schema.description="A minimal base image modified for Docker-CI." \
    org.label-schema.url="" \
    org.label-schema.license="MIT" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://gitlab.com/jrbeverly-docker/docker-baseimage.git" \
    org.label-schema.vendor="jrbeverly" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0" \
    io.jrbeverly.user=$DUID \
    io.jrbeverly.group=$DGID