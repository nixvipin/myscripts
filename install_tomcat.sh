#!/bin/bash
mkdir -p /data
cd /data
wget http://redrockdigimark.com/apachemirror/tomcat/tomcat-7/v7.0.85/bin/apache-tomcat-7.0.85.tar.gz
tar -zxvf apache-tomcat-7.0.85.tar.gz
mv apache-tomcat-7.0.85 apache-tomcat
cd apache-tomcat/bin
echo "change port in /data/apache-tomcat/conf/server.xml and execute ./startup.sh"
