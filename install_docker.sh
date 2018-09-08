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
CMD ["/usr/sbin/httpd", "-D", "BACKGROUND"]\n
-> vim index.html
\n<h1>This is my sample page</h1>
<p>Hello! Docker</p>\n
-> docker build -t mydocker:1.0 .
-> docker images
-> docker run -d -p 8080:80 mydocker:1.0 /usr/sbin/httpd -D FOREGROUND
-> docker ps
# You should see the Apache page on http://192.168.56.101:8080
-> Login to the docker VM and edit the page by login into Docker container.
-> docker exec -it <CONTAINER_ID> bash
-> ps -ef | grep apache
-> vi /var/www/html/index.html
# You should see changed on http://192.168.56.101:8080
# Now stop the Apache service before exit and pushing the image into Docker Registry.
-> pkill -9 httpd
-> rm /run/httpd/httpd.pid
# Edit "/etc/httpd/conf/httpd.conf" and uncomment "ServerName localhost"
-> vi +95 /etc/httpd/conf/httpd.conf
-> exit
# Commit the changes we did in container
-> docker ps
-> docker commit <CONTEINR_ID> mydocker:1.0
-> docker tag mydocker:1.0 <DOCKER_USER_NAME>/mydockernewimg
-> docker images
-> docker image push <DOCKER_USER_NAME>/mydockerimg\n
-> Verify the Image on https://hub.docker.com/
# To Re-use the container. Stop and remove container.
-> docker ps
-> docker stop <CONTAINER_ID>
->  docker ps -a
-> docker rm <CONTAINER_ID>
# Remove  all images
-> docker rmi $(docker images -q)
# Download image we commited earlier
-> docker pull <username>/mydockernewimg
-> docker images
#Create container with mounting /data into it and give some name to container.
docker create -v /data --name mycont  nixvipin/mydockernewimg /usr/sbin/httpd -D FOREGROUND
docker ps -a

##############################################
#   DOWNLOAD NGINX IMAGE AND START CONTAINER #
##############################################\n
-> docker pull nginx
-> docker run --name docker-nginx-new -p 8081:80 -e TERM=xterm -d nginx
-> docker exec -it <CONTAINER_ID> bash
->  You should be able to see Nginx default home page on when you hit http://192.168.56.101:8081 in browser.
\e[0m\e"
