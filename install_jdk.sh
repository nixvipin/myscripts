#!/bin/bash

VER=8u201
URL=https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-$VER-linux-x64.tar.gz

wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3a%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk8-downloads-2133151.html; oraclelicense=accept-securebackup-cookie;" "$URL"
tar -xzf jdk-$VER-linux-x64.tar.gz --directory=/usr/local/jdk8
rm -f jdk-$VER-linux-x64.tar.gz

grep JAVA_HOME /etc/profile

if [ $? = 0 ]
then
echo "JAVA path already set on `where java`"
else
echo "JAVA_HOME=/usr/local/jdk8" >> /etc/profile
echo "PATH=$JAVA_HOME/bin:$PATH" >> /etc/profile
export JAVA_HOME PATH >> /etc/profile
fi

