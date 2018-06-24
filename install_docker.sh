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

12.  docker build -t mydocker:1.0 .
13.  docker images
14.  docker run -d -p 8080:80 mydocker:1.0 /usr/sbin/httpd -D FOREGROUND
15.  docker ps
16.  docker exec -it <CONTAINER_ID> bash
17.  exit
###  Let's push this image into your repository
18.  docker tag mydocker:1.0 <DOCKER_USER_NAME>/mydockerimg
19.  docker images
20.  docker image push nixvipin/mydockerimg

-->  Now let's setup Nginx container
21.  docker pull nginx
22.  docker run --name docker-nginx-new -p 8081:80 -e TERM=xterm -d nginx
23.  docker exec -it <CONTAINER_ID> bash
24.  You should be able to see Nginx default home page on when you hit http://192.168.56.102:8081 in browser.

-->  Now let's have one more example setup Jenkins on port 8082
25.  docker search jenkins
26.  docker pull jenkins
27.  docker images
28.  docker run -d -p 8082:8080 -p 50000:50000 jenkins
29.  You should be able to see Jenkins default home page on when you hit http://192.168.56.102:8082 in browser. 
30.  docker ps
31.  docker exec -it  CONTAINER_ID  bash
32.  yum install git -y
33.  mkdir /docker-data
34.  cd /docker-data
35.  git clone https://github.com/nixvipin/myscripts.git
36.  cd myscripts
37.  sh initial_install.sh
38.  exit
###  Push this image into docker repository.
39.  docker tag jenkins nixvipin/jenkinsimage
40.  docker image push nixvipin/jenkinsimage
41.  You should be able to see images uploaded in your docker repository on hub.docker.com homepage.

\e[0m\e"
