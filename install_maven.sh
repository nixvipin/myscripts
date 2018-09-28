#!/bin/bash

VER=3.5.4

cd /data
wget http://mirrors.wuchna.com/apachemirror/maven/maven-3/$VER/binaries/apache-maven-$VER-bin.tar.gz
tar -xzf apache-maven-$VER-bin.tar.gz
mv apache-maven-$VER maven
rm apache-maven-$VER-bin.tar.gz

echo -e "\n\e[32mAdd below 3 lines in /etc/profile file

MAVEN_HOME=/data/maven
PATH=\$MAVEN_HOME/bin:\$PATH
export PATH MAVEN_HOME\n

And Execute 'source /etc/profile && mvn -version'\e[0m\e"
