#!/bin/bash

DOCKER_PREFIX=tiles-20200601
DOCKER_IMAGE_PREFIX=
HOST_DIR="/srv/tiles/${DOCKER_PREFIX}"

# POSTGRES

POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres

PG_OPTIONS='
	-c max_connections=300
	-c max_worker_processes=24
	-c max_parallel_workers=24
	-c max_parallel_workers_per_gather=2
	-c shared_buffers=4GB
	-c work_mem=256MB
	-c maintenance_work_mem=2GB
	-c effective_cache_size=32GB
	-c effective_io_concurrency=10
	-c random_page_cost=1.1
	-c synchronous_commit=off
	-c fsync=off
'

HOST_POSTGRES_DIR="${HOST_DIR}/postgres"

# DATA

DATA_URL=http://download.geofabrik.de/europe/poland/malopolskie-latest.osm.pbf
DATA_URL_EXTENT=https://download.geofabrik.de/europe/poland/malopolskie.poly
DATA_MEM_MB=4096
DATA_CPU_CORES=8

HOST_DATA_DIR="${HOST_DIR}/pbf"

# CARTO

CARTO_REPO=https://github.com/gravitystorm/openstreetmap-carto

HOST_CARTO_DIR="${HOST_DIR}/carto"

# MAPPROXY

HOST_MAPPROXY_DIR="${HOST_DIR}/mapproxy"

MAPPROXY_PROCESSES=24
