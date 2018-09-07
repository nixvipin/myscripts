#!/bin/bash

echo -e "\n\e[32m ...Installing Docker Packages...\e[0m\e"
yum install -y yum-utils device-mapper-persistent-data lvm2 -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce -y
yum list docker-ce --showduplicates | sort -r
systemctl start docker
systemctl enable docker

echo -e "\n\e[32mPlease follow below steps :\n
#################################
#   SIGNUP TO DOCKER REGISTRY   #
#################################\n
-> Signup to https://hub.docker.com/
-> Click on Create Repository.
-> Enter a project name and a description for your repository and click Create.\n
#################################
#   CREATE A CUSTOMIZED IMAGE   #
#################################\n
-> Execute 'docker login' on Docker Server and enter your docker hub login details on your server.
-> docker images
-> docker search centos
-> mkdir /data/mydocker
-> cd /data/mydocker
-> vim Dockerfile
\nFROM centos:latest
MAINTAINER <Enter_Your_Mail_ID>
RUN yum install httpd -y
COPY index.html /var/www/html
EXPOSE 80
CMD [“/usr/sbin/httpd”, “-D”, “FOREGROUND”]\n
-> vim index.html
\n<h1>This is my sample page</h1>
<p>Hello! Docker</p>\n
-> docker build -t mydocker:1.0 .
-> docker images
-> docker run -d -p 8080:80 mydocker:1.0 /usr/sbin/httpd -D FOREGROUND
-> docker ps
-> docker exec -it <CONTAINER_ID> bash
-> exit
-> docker commit <CONTEINR_ID> mydocker:1.0
-> docker tag mydocker:1.0 <DOCKER_USER_NAME>/mydockerimg
-> docker images
-> docker image push <DOCKER_USER_NAME>/mydockerimg\n
##############################################
#   DOWNLOAD NGINX IMAGE AND START CONTAINER #
##############################################\n
-> docker pull nginx
-> docker run --name docker-nginx-new -p 8081:80 -e TERM=xterm -d nginx
-> docker exec -it <CONTAINER_ID> bash
->  You should be able to see Nginx default home page on when you hit http://192.168.56.101:8081 in browser.
\e[0m\e"
