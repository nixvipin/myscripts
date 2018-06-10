#!/bin/bash

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
cd /data/apache-tomcat/webapps/employee/
scp jenkins@$CLIENT_PRIVATE_IP:/data/backup/$SOURCE_BUILD_NUMBER/SpringHibernateExample.war .
jar -xf SpringHibernateExample.war
rm SpringHibernateExample.war
cd /data/apache-tomcat/bin
./startup.sh
sleep 30
tail -n 100 ../logs/catalina.out
echo -e "\e[42m...Deployment is successfull on Tomcat1..\e[0m"

if [ -d /data/apache-tomcat2 ]
then
cd /data/apache-tomcat2/bin
./shutdown.sh
sleep 10
cd /data/apache-tomcat2/webapps
rm -rf /data/apache-tomcat2/webapps/employee/*
mkdir -p /data/apache-tomcat2/webapps/employee/
cd /data/apache-tomcat2/webapps/employee/
scp -i $PAM_FULL_PATH centos@$CLIENT_PRIVATE_IP:/data/backup/$SOURCE_BUILD_NUMBER/SpringHibernateExample.war .
jar -xf SpringHibernateExample.war
rm SpringHibernateExample.war
cd /data/apache-tomcat2/bin
./startup.sh
sleep 30
tail -n 100 ../logs/catalina.out
echo -e "\e[42m...Deployment is successfull on Tomcat2..\e[0m"
else
echo "\nDone.\n"
fi
