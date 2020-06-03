#!/bin/bash

. common.sh

rm -Rfv "${HOST_POSTGRES_DIR}"/*
rm -Rfv "${HOST_DATA_DIR}"/*
rm -Rfv "${HOST_CARTO_DIR}"/*
rm -Rfv "${HOST_MAPNIK_DIR}"/*
