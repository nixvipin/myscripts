#!/bin/bash

export CATALINA_BASE=/data/apache-tomcat

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
