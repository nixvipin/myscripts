#!/bin/bash

VER=3.6.0

cd /data
wget http://mirrors.estointernet.in/apache/maven/maven-3/$VER/binaries/apache-maven-$VER-bin.tar.gz

if [ $? != 0 ];
then
echo -e "\nDownload failed..\n"
fi

tar -xzf apache-maven-$VER-bin.tar.gz
mv apache-maven-$VER maven
rm apache-maven-$VER-bin.tar.gz

echo -e "\n\e[32mAdd below 3 lines in /etc/profile file

MAVEN_HOME=/data/maven
PATH=\$MAVEN_HOME/bin:\$PATH
export PATH MAVEN_HOME\n

And Execute 'source /etc/profile && mvn -version'\e[0m\e"
