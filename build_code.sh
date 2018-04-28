#!/bin/bash

echo $BUILD_NUMBER
exit 1

JAVA_HOME=/data/jdk1.8
MAVEN_HOME=/data/maven
PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH
CATALINA_BASE=/data/apache-tomcat

export PATH JAVA_HOME MAVEN_HOME CATALINA_BASE BUILD_NUMBER

cd /data/
rm -rf /data/myproject/
git clone https://github.com/nixvipin/myproject.git
cd /data/myproject/employees
mvn clean install

if [ $? = 0 ]
then
echo -e "\n*** Build Succesfull ***\n"
mkdir -p /data/backup/$BUILD_NUMBER
cp -a /data/myproject/employees/target/SpringHibernateExample.war /data/backup/$BUILD_NUMBER/
else
echo -e "\n*** Build is Failed ***\n"
exit 1
fi

