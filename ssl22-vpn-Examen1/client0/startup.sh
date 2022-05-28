#! /bin/bash

cp /opt/docker/daytime /etc/xinetd.d/.

/etc/init.d/xinetd start

systemctl start openvpn@client.service

/bin/bash
