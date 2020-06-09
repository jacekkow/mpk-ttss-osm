#!/bin/bash -x

. common.sh

DOCKER_NAME="${DOCKER_PREFIX}-mapproxy"
DOCKER_IMAGE="${DOCKER_IMAGE_PREFIX}mapproxy"
DOCKER_DIR=mapproxy

mkdir "${HOST_MAPPROXY_DIR}"
chown 500:500 "${HOST_MAPPROXY_DIR}"

docker build -t "${DOCKER_IMAGE}" "${DOCKER_DIR}"
docker stop "${DOCKER_NAME}"
docker rm -v "${DOCKER_NAME}"
docker run -i -t -d \
	--link "${DOCKER_PREFIX}-postgis:postgres" \
	-v "${HOST_CARTO_DIR}:/home/mapproxy/carto:ro" \
	-v "${HOST_MAPPROXY_DIR}:/home/mapproxy/data" \
	-e "MAPNIK_MAP_FILE=/home/mapproxy/carto/mapnik.xml" \
	-e "MAPNIK_TILE_DIR=/home/mapproxy/data" \
	-e "MAPPROXY_PROCESSES=${MAPPROXY_PROCESSES}" \
	-p 8080:8080 \
	--name "${DOCKER_NAME}" \
	"${DOCKER_IMAGE}"
docker logs -f "${DOCKER_NAME}"
