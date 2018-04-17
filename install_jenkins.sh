#!/bin/bash

java -version
if [ $? = 0 ]
then
echo "ok to proceed.."
else
echo "Install Java & try again"
fi

if [ -f /usr/bin/wget ]
then
echo "ok.."
else
echo "wget is not installed..installing it now.."
yum install wget -y
fi

setup_tomcat()
{
mkdir -p /data
cd /data
wget http://redrockdigimark.com/apachemirror/tomcat/tomcat-7/v7.0.85/bin/apache-tomcat-7.0.85.tar.gz
tar -zxvf apache-tomcat-7.0.85.tar.gz
mv /data/apache-tomcat-7.0.85 /data/jenkins
sed -i.orig.bak 's/8080/8002/g' /data/jenkins/conf/server.xml
}

set_war()
{
cd /data/jenkins/webapps
wget "https://updates.jenkins-ci.org/latest/jenkins.war"
}

start_jenkins()
{
cd /data/jenkins/bin
./startup.sh
sleep 10
tail -n 50 ../logs/catalina.out
echo -e "\eJenkins Started successfully\e"
}

setup_jenkins()
{
setup_tomcat
set_war
start_jenkins
}
