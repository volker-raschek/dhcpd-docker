# CONTAINER_RUNTIME
# The CONTAINER_RUNTIME variable will be used to specified the path to a
# container runtime. This is needed to start and run a container image.
CONTAINER_RUNTIME?=$(shell which docker)

# DHCPD_IMAGE_REGISTRY_NAME
# Defines the name of the new container to be built using several variables.
DHCPD_IMAGE_REGISTRY_NAME:=docker.io
DHCPD_IMAGE_REGISTRY_USER:=volkerraschek

DHCPD_IMAGE_NAMESPACE?=${DHCPD_IMAGE_REGISTRY_USER}
DHCPD_IMAGE_NAME:=dhcpd
DHCPD_IMAGE_VERSION?=latest
DHCPD_IMAGE_FULLY_QUALIFIED=${DHCPD_IMAGE_REGISTRY_NAME}/${DHCPD_IMAGE_NAMESPACE}/${DHCPD_IMAGE_NAME}:${DHCPD_IMAGE_VERSION}
DHCPD_IMAGE_UNQUALIFIED=${DHCPD_IMAGE_NAMESPACE}/${DHCPD_IMAGE_NAME}:${DHCPD_IMAGE_VERSION}

# BUILD CONTAINER IMAGE
# ==============================================================================
PHONY:=container-image/build
container-image/build:
	${CONTAINER_RUNTIME} build \
		--file Dockerfile \
		--no-cache \
		--pull \
		--tag ${DHCPD_IMAGE_FULLY_QUALIFIED} \
		--tag ${DHCPD_IMAGE_UNQUALIFIED} \
		.

# DELETE CONTAINER IMAGE
# ==============================================================================
PHONY:=container-image/delete
container-image/delete:
	- ${CONTAINER_RUNTIME} image rm ${DHCPD_IMAGE_FULLY_QUALIFIED} ${DHCPD_IMAGE_UNQUALIFIED}
	- ${CONTAINER_RUNTIME} image rm ${BASE_IMAGE_FULL}

# PUSH CONTAINER IMAGE
# ==============================================================================
PHONY+=container-image/push
container-image/push:
	echo ${DHCPD_IMAGE_REGISTRY_PASSWORD} | ${CONTAINER_RUNTIME} login ${DHCPD_IMAGE_REGISTRY_NAME} --username ${DHCPD_IMAGE_REGISTRY_USER} --password-stdin
	${CONTAINER_RUNTIME} push ${DHCPD_IMAGE_FULLY_QUALIFIED}

# PHONY
# ==============================================================================
# Declare the contents of the PHONY variable as phony.  We keep that information
# in a variable so we can use it in if_changed.
.PHONY: ${PHONY}