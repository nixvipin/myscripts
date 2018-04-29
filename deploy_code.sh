#!/bin/bash

PAM_FULL_PATH=$3
CLIENT_PRIVATE_IP=$2
SOURCE_BUILD_NUMBER=$1

JAVA_HOME=/data/jdk1.8
PATH=$JAVA_HOME/bin:$PATH
export PATH JAVA_HOME
cd /data/apache-tomcat/bin
./shutdown.sh
sleep 10
cd /data/apache-tomcat/webapps
rm -rf /data/apache-tomcat/webapps/employee/*
mkdir -p /data/apache-tomcat/webapps/employee/
#cp -a /data/backup/$JOB_NUMBER/SpringHibernateExample.war /data/apache-tomcat/webapps/employee/
cd /data/apache-tomcat/webapps/employee/
scp -i $PAM_FULL_PATH centos@$CLIENT_PRIVATE_IP:/data/backup/$SOURCE_BUILD_NUMBER/SpringHibernateExample.war .
jar -xf SpringHibernateExample.war
rm SpringHibernateExample.war
cd /data/apache-tomcat/bin
./startup.sh
sleep 10
tail -n 100 ../logs/catalina.out
echo -e "\e[42m...Deployment is successfull..\e[0m"

