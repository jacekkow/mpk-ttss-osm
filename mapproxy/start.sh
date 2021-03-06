#!/bin/sh

if [ ! -f data/mapproxy.yaml ]; then
	cp mapproxy.yaml data/
fi
if [ ! -f data/extent.geojson ]; then
	cp carto/extent.geojson data/
fi

uwsgi --http-socket :8080 --master --processes "${MAPPROXY_PROCESSES}" --plugins python --module wsgi
