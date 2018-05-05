#!/bin/bash

JAVA_HOME=/data/jdk1.8
MAVEN_HOME=/data/maven
PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH
CATALINA_BASE=/data/apache-tomcat

export PATH JAVA_HOME MAVEN_HOME CATALINA_BASE BUILD_NUMBER

cd /data/workspace/$JOB_NAME/myproject_local/employee
mvn clean install

if [ $? = 0 ]
then
echo -e "\n*** Build Succesfull ***\n"
mkdir -p /data/backup/$BUILD_NUMBER
cp -a /data/workspace/$JOB_NAME/myproject_local/employee/target/SpringHibernateExample.war /data/backup/$BUILD_NUMBER/
chown -R centos:centos /data/backup/$BUILD_NUMBER/
else
echo -e "\n*** Build is Failed ***\n"
exit 1
fi

