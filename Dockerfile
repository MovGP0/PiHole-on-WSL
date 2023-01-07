# use Ubuntu base image
FROM ubuntu:latest

# install dependencies
RUN apt-get update
RUN apt-get install -y curl dnsutils netcat

# add setup configuration file
COPY setupVars.conf /etc/pihole/setupVars.conf

# download and run PiHole installation script
RUN curl -sSL https://install.pi-hole.net | bash /dev/stdin --unattended

# expose ports for DNS and web management
EXPOSE 53/tcp 53/udp 80/tcp

# start pihole application
ENTRYPOINT [ "pihole" ]
CMD [ "-a", "-p" ]

## create docker image using
# docker build -t pihole .

## create docker container using
# docker run -d --name pihole -p 53:53/tcp -p 53:53/udp -p 80:80/tcp pihole