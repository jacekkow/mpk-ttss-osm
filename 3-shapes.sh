#!/bin/bash -x

. common.sh

DOCKER_NAME="${DOCKER_PREFIX}-shapes"
DOCKER_IMAGE="${DOCKER_IMAGE_PREFIX}shapes"
DOCKER_DIR=shapes

docker build -t "${DOCKER_IMAGE}" "${DOCKER_DIR}"
docker run -i -t \
	--link "${DOCKER_PREFIX}-postgis:postgres" \
	-e "POSTGRES_USER=${POSTGRES_USER}" \
	-e "POSTGRES_PASSWORD=${POSTGRES_PASSWORD}" \
	-v "${HOST_CARTO_DIR}:/home/map/carto" \
	--name "${DOCKER_NAME}" \
	"${DOCKER_IMAGE}"

docker rm -v "${DOCKER_NAME}"
