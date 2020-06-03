FROM debian:bullseye

RUN	apt-get update \
	&& apt-get -y dist-upgrade \
	&& apt-get -y install --no-install-suggests --no-install-recommends \
		gdal-bin python3-psycopg2 python3-requests python3-yaml

RUN	groupadd -r -g 500 map \
	&& useradd -r -u 500 -g 500 map \
	&& mkdir -p /home/map \
	&& chown map:map /home/map

VOLUME /home/map/carto

USER map
WORKDIR /home/map

ADD get-external-data.py .
CMD PGPASSWORD="${POSTGRES_PASSWORD}" ./get-external-data.py \
		-v \
		-c carto/repo/external-data.yml \
		-D carto/data \
		-H postgres \
		-U "${POSTGRES_USER}" \
		-d "${POSTGRES_USER}"
