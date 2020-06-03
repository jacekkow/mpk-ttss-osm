FROM node

ENV CARTO_REPO https://github.com/gravitystorm/openstreetmap-carto

RUN	apt-get update \
	&& apt-get -y dist-upgrade \
	&& apt-get -y install --no-install-suggests --no-install-recommends git

RUN	groupadd -r -g 500 map \
	&& useradd -r -u 500 -g 500 map \
	&& mkdir -p /home/map \
	&& chown map:map /home/map

VOLUME /home/map/carto

USER map
WORKDIR /home/map

RUN npm install carto polytogeojson

CMD	git init carto/repo \
	&& cd carto/repo \
	&& git remote add origin "${CARTO_REPO}" || true \
	&& git fetch origin master \
	&& git reset --hard origin/master \
	&& cd - \
	&& wget -N "${DATA_URL_EXTENT}" \
	&& node -e 'process.stdout.write(JSON.stringify(require("polytogeojson")(require("fs").readFileSync(0, "utf-8"))));' < `basename "${DATA_URL_EXTENT}"` > carto/extent.geojson \
	&& cp -Rf carto/repo/symbols carto/ \
	&& sed -i -e '/^    type: "postgis"$/,/^    key_field: ""$/c\    type: "postgis"\n    host: "postgres"\n    user: "'$POSTGRES_USER'"\n    password: "'$POSTGRES_PASSWORD'"\n    dbname: "'$POSTGRES_USER'"\n    key_field: ""' carto/repo/project.mml \
	&& ./node_modules/.bin/carto carto/repo/project.mml > carto/mapnik.xml
