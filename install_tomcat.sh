#!/bin/bash
TOMCAT_VERSION=8.5.32

mkdir -p /data
cd /data
http://redrockdigimark.com/apachemirror/tomcat/tomcat-8/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
tar -zxvf apache-tomcat-$TOMCAT_VERSION.tar.gz
mv apache-tomcat-$TOMCAT_VERSION apache-tomcat
cd apache-tomcat/bin
sed -i.orig.bak 's/8080/8001/g' /data/apache-tomcat/conf/server.xml
sed -i 's/8009/8010/g' /data/apache-tomcat/conf/server.xml
sed -i 's/8005/8015/g' /data/apache-tomcat/conf/server.xml
rm /data/apache-tomcat-$TOMCAT_VERSION.tar.gz
cp -a /data/myscripts/employees.war /data/apache-tomcat/webapps/
cd /data/apache-tomcat/bin
./startup.sh
echo -e "\n\e[32m ...Tomcat installation is complete... You should be able to access http://SERVERIP::8001/employee\e[0m\e\n"
