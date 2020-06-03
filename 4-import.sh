#!/bin/bash

. common.sh

DOCKER_IMAGE=debian:buster
DOCKER_NAME="${DOCKER_PREFIX}-data"

DATA_FILENAME=`basename "${DATA_URL}"`

docker pull "${DOCKER_IMAGE}"

docker rm -v "${DOCKER_NAME}"
docker run -i -t -d \
	--link "${DOCKER_PREFIX}-postgis:postgres" \
	-v "${HOST_DATA_DIR}:/srv/pbf" \
	-v "${HOST_CARTO_DIR}:/srv/carto" \
	--name "${DOCKER_NAME}" \
	"${DOCKER_IMAGE}"

docker exec -i -t "${DOCKER_NAME}" bash -c "apt-get update && apt-get -y install --no-install-recommends --no-install-suggests osm2pgsql wget"
docker exec -i -t "${DOCKER_NAME}" bash -c "cd /srv/pbf && wget -N ${DATA_URL}"
docker exec -i -t "${DOCKER_NAME}" bash -c "cd /srv/pbf && PGPASSWORD=${POSTGRES_PASSWORD} osm2pgsql --slim --hstore --cache ${DATA_MEM_MB} --number-processes ${DATA_CPU_CORES} --host postgres --username ${POSTGRES_USER} --database ${POSTGRES_USER}  --style /srv/carto/repo/openstreetmap-carto.style --tag-transform-script /srv/carto/repo/openstreetmap-carto.lua /srv/pbf/${DATA_FILENAME}"

docker stop "${DOCKER_NAME}"
