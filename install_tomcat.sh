#!/bin/bash
mkdir -p /data
cd /data
wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.30/bin/apache-tomcat-8.5.30.tar.gz
tar -zxvf apache-tomcat-8.5.30.tar.gz
mv apache-tomcat-8.5.30 apache-tomcat
cd apache-tomcat/bin
sed -i.orig.bak 's/8080/8001/g' /data/apache-tomcat/conf/server.xml
sed -i 's/8009/8010/g' /data/apache-tomcat/conf/server.xml
sed -i 's/8005/8015/g' /data/apache-tomcat/conf/server.xml
rm /data/apache-tomcat-8.5.30.tar.gz
echo -e "\eTomcat installation is done.."
