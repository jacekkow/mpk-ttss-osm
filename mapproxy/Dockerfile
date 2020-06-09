FROM debian

RUN apt-get -y update \
	&& apt-get -y dist-upgrade \
	&& apt-get -y install mapproxy python-mapnik uwsgi \
		fonts-noto ttf-unifont \
	&& groupadd -r -g 500 mapproxy \
	&& useradd -r -u 500 -g 500 mapproxy \
	&& mkdir -p /home/mapproxy \
	&& chown mapproxy:mapproxy /home/mapproxy
RUN apt-get -y install uwsgi-plugin-python

EXPOSE 8080

USER mapproxy
WORKDIR /home/mapproxy

ENV MAPPROXY_PROCESSES 4

COPY mapproxy.yaml wsgi.py start.sh ./
COPY mapnik.py /usr/lib/python2.7/dist-packages/mapproxy/source/mapnik.py

CMD ./start.sh
