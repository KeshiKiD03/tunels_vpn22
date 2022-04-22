#! /bin/bash

cp -r . /etc/openvpn/server
mkdir -p /usr/lib/systemd/system
#cp /opt/docker/openvpn@.service /usr/lib/systemd/system/openvpn@.service

systemctl start openvpn-server@server.service

/bin/bash # DE MOMENT INTERACTIU
