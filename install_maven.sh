#!/bin/bash

cd /data
wget http://redrockdigimark.com/apachemirror/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz
tar -xzf apache-maven-3.5.3-bin.tar.gz
mv apache-maven-3.5.3 maven
rm apache-maven-3.5.3-bin.tar.gz
<<<<<<< HEAD

echo -e "\n\e[32mAdd below 3 lines in /etc/profile file

MAVEN_HOME=/data/maven
PATH=\$MAVEN_HOME/bin:\$PATH
export PATH MAVEN_HOME\n

And Execute 'source /etc/profile && mvn -version'\e[0m\e"


=======
>>>>>>> 3ee5b003de3ea0be4b67553e0afd6701f28a47eb
