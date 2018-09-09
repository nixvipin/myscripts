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
#create own Dockerfile as per requirement

\nFROM centos:latest
MAINTAINER <Enter_Your_Mail_ID>
RUN yum install httpd -y
COPY index.html /var/www/html
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]\n

-> vim index.html
#create a index page below.

\n<h1>This is my sample page</h1>
<p>Hello! Docker</p>\n

# Build own Docker
-> docker build -t mydockerimg .
# See Docker Images on local server 0 (You should see 2 Images base and ours)
-> docker images
# Run container (You should see SHA)
-> docker run -d -p 8081:80 mydockerimg
# Verify running container (You should see a container runnig)
-> docker ps
# Verify Apache page on http://192.168.56.101:8081 (You should see index.html page)
-> Login to the docker VM and edit the page by login into Docker container.
-> docker exec -it <CONTAINER_ID> /bin/bash
# See the running httpd service
-> ps -ef | grep httpd
# Edit index.html
-> vi /var/www/html/index.html
# You should see changed on http://192.168.56.101:8081
# Also create a test user in our container
-> useradd mytest
# Verify user is created
-> cat /etc/passwd
# Now exit container
-> exit
# Commit the changes so we can push to Docker Registry.
-> docker ps
-> docker commit <CONTEINR_ID> mydockerimg
# We need to need in order to push this container to Docker Registry.
-> docker tag mydockerimg <DOCKER_USER_NAME>/mydockerremote
# Verify tagged properly
-> docker images
# Push the tagged image
-> docker image push <DOCKER_USER_NAME>/mydockerremote\n
# Verify the Image on https://hub.docker.com/

##############################################
#   DOWNLOAD NGINX IMAGE AND START CONTAINER #
##############################################\n
-> docker pull nginx
-> docker run --name docker-nginx-new -p 8081:80 -e TERM=xterm -d nginx
-> docker exec -it <CONTAINER_ID> bash
-> You should be able to see Nginx default home page on when you hit http://192.168.56.101:8081 in browser.
\e[0m\e"
