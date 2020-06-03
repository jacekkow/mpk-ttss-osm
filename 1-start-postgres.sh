#!/bin/bash

. common.sh

DOCKER_IMAGE=postgis/postgis:12-3.0
DOCKER_NAME="${DOCKER_PREFIX}-postgis"

docker pull "${DOCKER_IMAGE}"
docker stop "${DOCKER_NAME}" > /dev/null 2>&1
docker rm -v "${DOCKER_NAME}"
docker run -d \
	-v "${HOST_POSTGRES_DIR}:/var/lib/postgresql/data" \
	-e "POSTGRES_USER=${POSTGRES_USER}" \
	-e "POSTGRES_PASSWORD=${POSTGRES_PASSWORD}" \
	--name "${DOCKER_NAME}" \
	"${DOCKER_IMAGE}" \
	${PG_OPTIONS}

sleep 2
echo 'CREATE EXTENSION IF NOT EXISTS hstore;' | docker exec -i --user postgres "${DOCKER_NAME}" psql --dbname="${POSTGRES_USER}"
