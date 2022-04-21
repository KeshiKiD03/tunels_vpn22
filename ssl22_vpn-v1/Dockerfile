# SSL22:VPN KESHI
FROM debian:latest
LABEL version="1.0"
LABEL author=" @keshi ASIX-M11"
LABEL subject="VPN Server - VPN"
RUN apt-get update
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y vim xinetd procps iproute2 tree nmap vim nano systemd openssl openvpn apache2 
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD /opt/docker/startup.sh
