include Makefile.metadata.variable
include Makefile.image.variable
include Makefile.user.variable

# Build Variables
#
# Variables used for the generic build
TAG ?= alpine
VERSION ?= alpine

# Variables
#
# Common variables of the project.
DOCKER_IMAGE := ${REGISTRY}/${NAMESPACE}/${PROJECT}
RELEASE_IMAGE ?= $(DOCKER_IMAGE)
IMAGE_REF ?= $(DOCKER_IMAGE):$(PREFIX_TAG)$(TAG)

# File System Variables
#
# Variables related to the file system paths.
DIRECTORY := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
DIRECTORY_ROOT := $(shell dirname $(DIRECTORY))
VERSIONS := $(DIRECTORY_ROOT)/versions
DOCKER_DIR ?= $(VERSIONS)/$(VERSION)
DOCKERFILE ?= $(VERSIONS)/$(VERSION)/Dockerfile

# Rules
#
# Rules of the makefile
.PHONY: test build debug pull push prune clean release 

# Build rules
#
# Build rules for the docker project.

build:
	docker build --pull \
		 -t $(IMAGE_REF) \
		--build-arg BUILD_DATE="${BUILD_DATE}" \
		--build-arg VERSION="${CODE_VERSION}" \
		--build-arg VCS_REF="${GIT_COMMIT}" \
		--build-arg DUID="${DUID}" \
		--build-arg DGID="${DGID}" \
		-f ${DOCKERFILE} ${DOCKER_DIR}/. \

alpine-3.2: VERSION=alpine-3.2
alpine-3.2: TAG=alpine-3.2
alpine-3.2: build

alpine-3.3: VERSION=alpine-3.3
alpine-3.3: TAG=alpine-3.3
alpine-3.3: build

alpine-3.4: VERSION=alpine-3.4
alpine-3.4: TAG=alpine-3.4
alpine-3.4: build

alpine-3.5: VERSION=alpine-3.5
alpine-3.5: TAG=alpine-3.5
alpine-3.5: build

alpine: VERSION=alpine
alpine: TAG=alpine
alpine: build

ubuntu-16.04: VERSION=ubuntu-16.04
ubuntu-16.04: TAG=ubuntu-16.04
ubuntu-16.04: build

ubuntu-16.10: VERSION=ubuntu-16.10
ubuntu-16.10: TAG=ubuntu-16.10
ubuntu-16.10: build

ubuntu-17.04: VERSION=ubuntu-17.04
ubuntu-17.04: TAG=ubuntu-17.04
ubuntu-17.04: build

ubuntu: VERSION=ubuntu
ubuntu: TAG=ubuntu
ubuntu: build

# Testing rules
#
# Test rules for docker projects.

debug:
	@echo Docker Image: $(IMAGE_REF)

test:
	sh ${DIRECTORY_ROOT}/tests/test_${VERSION}.sh $(IMAGE_REF)

# Generic rules
#
# Generic rules for docker projects.
clean:
	docker rmi $(shell docker images | grep ${NAMESPACE}/${PROJECT} | tr -s ' ' | cut -d ' ' -f 3)

prune:
	docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi

pull:
	docker pull $(IMAGE_REF)

push:
	docker push $(IMAGE_REF)

release:
	docker tag $(IMAGE_REF) $(RELEASE_IMAGE):$(TAG)
	docker push $(RELEASE_IMAGE):$(TAG)