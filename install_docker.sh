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
--> Let's start build docker image
7.  cd
8.  mkdir mydocker
9.  cd mydocker
10. vim Dockerfile

#This is sample image
FROM centos:latest
#Maintainer name
MAINTAINER <Your_Mail_ID>
#Execute Run
RUN yum install httpd -y
COPY index.html /var/www/html
#Export port
EXPOSE 80
#Status
CMD [“/usr/sbin/httpd”, “-D”, “FOREGROUND”]

11.  vim index.html

<body style="background-color:powderblue;">

<h1>This is test page</h1>
<p>Hello! Docker</p>

</body>

# -t is used to tag name
12.  docker build -t mydocker:1.0 .
13.  docker images
# -d to run in daemon mode, -p FRONT_PORT:BACKEND_PORT
14.  docker run -d -p 8080:80 mydocker:1.0 /usr/sbin/httpd -D FOREGROUND
# It will show docker process
15.  docker ps
# -it interctive mode, bash - Login to the VM.
16.  docker exec -it <CONTAINER_ID> bash
# You should see SHELL something like [root@c0726811c3a7 /]#
# You can make some changes into the VM. Once you're done exit from the container.
17.  exit
# Commit your changes. CONTEINR_ID you can get from 'docker ps'.
18. docker commit <CONTEINR_ID> mydocker:1.0
# Tag image
19.  docker tag mydocker:1.0 <DOCKER_USER_NAME>/mydockerimg
20.  docker images
# Push Image. Make sure you're log-in, otherwisr use 'docker login'.
21.  docker image push nixvipin/mydockerimg

-->  Now let's setup Nginx container
# Pull Ngnix image
22.  docker pull nginx
# -p FRONTEND_PORT_BACKEND_PORT, -d deamon mode
23.  docker run --name docker-nginx-new -p 8081:80 -e TERM=xterm -d nginx
#Login to the container shell
24.  docker exec -it <CONTAINER_ID> bash
25.  You should be able to see Nginx default home page on when you hit http://192.168.56.102:8081 in browser.

-->  Now let's have one more example setup Jenkins on port 8082
26.  docker search jenkins
27.  docker pull jenkins
28.  docker images
29.  docker run -d -p 8082:8080 -p 50000:50000 jenkins
30.  You should be able to see Jenkins default home page on when you hit http://192.168.56.102:8082 in browser. 
31.  docker ps
32.  docker exec -it  CONTAINER_ID  bash
33.  yum install git -y
34.  mkdir /docker-data
35.  cd /docker-data
36.  git clone https://github.com/nixvipin/myscripts.git
37.  cd myscripts
38.  sh initial_install.sh
39.  exit
# Commit your changes. CONTEINR_ID you can get from 'docker ps'.
40. docker commit <CONTEINR_ID> mydocker:1.0
#Tag image
###  Push this image into docker repository.
41.  docker tag jenkins nixvipin/jenkinsimage
# Push Image. Make sure you're log-in, otherwisr use 'docker login'.
42.  docker image push nixvipin/jenkinsimage
43.  You should be able to see images uploaded in your docker repository on hub.docker.com homepage. \e[0m\e"
