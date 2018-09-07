#!/bin/bash

echo -e "\n\e[32m ...Installing Docker Packages...\e[0m\e"
yum install -y yum-utils device-mapper-persistent-data lvm2 -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce -y
yum list docker-ce --showduplicates | sort -r
systemctl start docker
systemctl enable docker

echo -e "\n\e[32mPlease follow below steps :

################################
#   SIGNUP TO DOCKER REGISTRY  #
################################

1. Signup to https://hub.docker.com/
2. Click on Create Repository.
3. Enter a project name and a description for your repository and click Create.
4. Execute on Docker Server 'docker login' and enter your docker hub login details on your server. You should see the message --> Login Succeeded.

################################
#   CREATE A CUSTOMIZED IMAGE  #
################################

1. docker images
2. docker search centos
4. mkdir /data/mydocker
5. cd /data/mydocker
6. vim Dockerfile

FROM centos:latest
MAINTAINER <Enter_Your_Mail_ID>
RUN yum install httpd -y
COPY index.html /var/www/html
EXPOSE 80
CMD [“/usr/sbin/httpd”, “-D”, “FOREGROUND”]

11. vim index.html

<h1>This is my sample page</h1>
<p>Hello! Docker</p>

12. docker build -t mydocker:1.0 .
13. docker images
14. docker run -d -p 8080:80 mydocker:1.0 /usr/sbin/httpd -D FOREGROUND
15. docker ps
16. docker exec -it <CONTAINER_ID> bash
17. exit
18. docker commit <CONTEINR_ID> mydocker:1.0
19. docker tag mydocker:1.0 <DOCKER_USER_NAME>/mydockerimg
20. docker images
21. docker image push <DOCKER_USER_NAME>/mydockerimg

##############################################
#   DOWNLOAD NGINX IMAGE AND START CONTAINER #
##############################################

22. docker pull nginx
23. docker run --name docker-nginx-new -p 8081:80 -e TERM=xterm -d nginx
24. docker exec -it <CONTAINER_ID> bash
25.  You should be able to see Nginx default home page on when you hit http://192.168.56.101:8081 in browser.

\e[0m\e"
