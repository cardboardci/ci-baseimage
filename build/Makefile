include Makefile.file.variable
include Makefile.metadata.variable
include Makefile.image.variable
include Makefile.user.variable

# Variables
#
# Variables used in the Makefile to specify the image.
VERSION ?= alpine
TAG_SUFFIX ?=
TAG_PREFIX ?=

# Registry
#
# Sets up the staging repository 
STAGING_REGISTRY ?= $(REGISTRY)
STAGING_NAMESPACE ?= $(NAMESPACE)
STAGING_PROJECT ?= $(PROJECT)

# Variables
#
# Common variables of the project.
IMAGE := ${REGISTRY}/${NAMESPACE}/${PROJECT}
STAGING_IMAGE := ${STAGING_REGISTRY}/${STAGING_NAMESPACE}/${STAGING_PROJECT}
WORKING_IMAGE ?= $(STAGING_IMAGE):$(TAG_PREFIX)$(TAG)$(TAG_SUFFIX)

## 
## Rules
##
.PHONY: build test prune clean debug pull push release image debug

ifeq (,$(wildcard $(PATH_DOCKER)))
    $(error The version $(VERSION) is not valid for this image.  See versions/ for possible image versions.)
endif

ifeq (,$(wildcard $(PATH_OPTIONS)))
    $(error The version $(VERSION) is incorrectly setup and does not have a 'Makefile.options'.)
endif

# Pull variables from the Makefile.options
include $(PATH_OPTIONS)

ifndef TAG
    $(error The version $(VERSION) is incorrectly setup and does not have a 'TAG' variable.)
endif

ifeq (,$(wildcard $(PATH_DOCKER)))
    $(error The version $(VERSION) is not valid for this image.  See versions/ for possible image versions.)
endif

ifeq (,$(wildcard $(PATH_DOCKERFILE)))
    $(error A dockerfile could not be found at the path $(PATH_DOCKERFILE))
endif

# Build
#
# Builds the image pulling variables from the `.variable` files.

# Build the working image.
build:
	docker build --pull \
		 -t $(WORKING_IMAGE) \
		 \
		--build-arg BUILD_DATE="${BUILD_DATE}" \
		--build-arg VERSION="${CODE_VERSION}" \
		--build-arg VCS_REF="${GIT_COMMIT}" \
		\
		--build-arg DUID="${DUID}" \
		--build-arg DGID="${DGID}" \
		\
		-f $(PATH_DOCKERFILE) $(PATH_DOCKER)/. \

# Testing
#
# Run tests on the provided image

# Tests the working docker image.
test:
	sh ${MOUNT_TESTS}/test_${VERSION}.sh $(WORKING_IMAGE)

# Tidy Up
#
# Facilitates cleaning of the docker images related to this image.

# Removes unused images.
prune:
	docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi

# Removes the image (and all tags).
clean:
	docker images | grep ${STAGING_NAMESPACE}/${STAGING_PROJECT} | tr -s ' ' | cut -d ' ' -f 3 | xargs --no-run-if-empty docker rmi

# Registry 
#
# Facilitates pushing and pulling the image from a registry.

pull:
	docker pull $(WORKING_IMAGE)

push:
	docker push $(WORKING_IMAGE)

release:
	docker tag $(WORKING_IMAGE) $(IMAGE):$(TAG)

# Output
#
# Output details about the variables of the build process.

# Prints the working name of the image.
image:
	@echo $(WORKING_IMAGE)

# Prints the variable value (make debug-VARIABLE)
debug-%  : ; @echo $* = $($*)

# Prints a collection of relevant variables
info:
	@echo Image Version: $(VERSION)
	@echo CODE_VERSION = $(CODE_VERSION)
	@echo GIT_COMMIT = $(GIT_COMMIT)
	@echo BUILD_DATE = $(BUILD_DATE)
	@echo Working Image: $(WORKING_IMAGE)
	@echo
	@echo Registry:
	@echo IMAGE = $(IMAGE)
	@echo STAGING_IMAGE = $(STAGING_IMAGE)	
	@echo
	@echo Pathing:
	@echo PATH_DOCKER: $(PATH_DOCKER)
	@echo PATH_DOCKERFILE: $(PATH_DOCKERFILE)
	@echo PATH_BUILD = $(PATH_BUILD)
	@echo PATH_ROOT = $(PATH_ROOT)
	@echo PATH_VERSIONS = $(PATH_VERSIONS)
	@echo PATH_TESTS = $(PATH_TESTS)