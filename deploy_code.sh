#!/bin/bash

cd /data/apache-tomcat/bin
./shutdown.sh
sleep 10
cd /data/apache-tomcat/webapps
rm -rf /data/apache-tomcat/webapps/employee/*
mkdir -p /data/apache-tomcat/webapps/employee/
cp -a /data/myproject/employees/target/SpringHibernateExample.war /data/apache-tomcat/webapps/employee/
cd /data/apache-tomcat/webapps/employee/
jar -xf SpringHibernateExample.war
rm SpringHibernateExample.war
cd /data/apache-tomcat/bin
./startup.sh
sleep 10
tail -n 100 ../logs/catalina.out
echo -e "\e[42m...Deployment is successfull..\e[0m"

