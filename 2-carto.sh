#!/bin/bash -x

. common.sh

DOCKER_NAME="${DOCKER_PREFIX}-carto"
DOCKER_IMAGE="${DOCKER_IMAGE_PREFIX}carto"
DOCKER_DIR=carto

mkdir "${HOST_CARTO_DIR}"
chown 500:500 "${HOST_CARTO_DIR}"

docker build -t "${DOCKER_IMAGE}" "${DOCKER_DIR}"
docker run -i -t \
	-e "DATA_URL_EXTENT=${DATA_URL_EXTENT}" \
	-e "POSTGRES_USER=${POSTGRES_USER}" \
	-e "POSTGRES_PASSWORD=${POSTGRES_PASSWORD}" \
	-v "${HOST_CARTO_DIR}:/home/map/carto" \
	--name "${DOCKER_NAME}" \
	"${DOCKER_IMAGE}"

docker rm -v "${DOCKER_NAME}"
