# VPN Client
FROM debian:latest
LABEL version="1.0"
LABEL author="@keshi ASIX-M11"
LABEL subject="Client0"
RUN apt-get update
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install procps iproute2 tree nmap vim systemd less openvpn
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD /opt/docker/startup.sh
# Probar OpenVPN i Daytime Serveer
EXPOSE 1194 13
