#!/bin/bash

. common.sh

cat > /etc/systemd/system/tiles-postgis.service <<EOF
[Unit]
Description=Docker container tiles-postgis
After=docker.service
Requires=docker.service

[Service]
ExecStart=/usr/bin/docker start -a "${DOCKER_PREFIX}-postgis"
ExecStop=/usr/bin/docker stop -t 20 "${DOCKER_PREFIX}-postgis"
TimeoutStopSec=30s
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/tiles-mapproxy.service <<EOF
[Unit]
Description=Docker container tiles-mapproxy
After=docker.service tiles-postgis.service
BindsTo=docker.service tiles-postgis.service

[Service]
ExecStart=/usr/bin/docker start -a "${DOCKER_PREFIX}-mapproxy"
ExecStop=/usr/bin/docker stop -t 20 "${DOCKER_PREFIX}-mapproxy"
TimeoutStopSec=30s
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable tiles-mapproxy
