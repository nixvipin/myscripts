#!/bin/bash

yum install -y yum-utils device-mapper-persistent-data lvm2 -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce -y
yum list docker-ce --showduplicates | sort -r
systemctl start docker
systemctl enable docker

echo -e "\n\e[32m

1.  Log in on https://hub.docker.com/
2.  Click on Create Repository.
3.  Choose a name (e.g. mycloud_project) and a description for your repository and click Create.
4.  Execute 'docker login' and enter your docker hub login details on your server
5.  docker images
6.  docker search centos
7.  cd
8.  mkdir apacheserver
9.  cd apacheserver
10. vim Dockerfile

#This is sample image
FROM centos
#Maintainer name
MAINTAINER nix.vipin@gmail.com
#Execute Run
RUN yum install httpd -y
#Export port
EXPOSE 80
#Status
CMD ["echo ","Images Created"]


11.  docker build -t apacheserver:apacheserver .
12.  docker images
13.  docker ps -l
14.  docker run -it apacheserver:apacheserver /bin/bash
15.  docker ps -l

\e[0m\e"
