# Client 1_VPN
FROM debian:latest
LABEL version="1.0"
LABEL author="@keshi ASIX-M11"
LABEL subject="Client1"
RUN apt-get update
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install procps iproute2 tree nmap vim systemd less openvpn
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD /opt/docker/startup.sh
EXPOSE 1194 22
