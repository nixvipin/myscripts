#!/bin/bash


java -version || grep JAVA_HOME /etc/profile

if [ $? = 0 ]
then
echo "JAVA path already set on `whereis java`"
echo -e "\n\e[33mYou might need to execute below\nsource /etc/profile\njava -version\e[0m"
else
  if [ ! -f /usr/bin/wget ]
  then
  echo "Installing wget " 
  yum install wget -y
  else
  echo "wget is already installed in `whereis wget`"
  fi
VER=8u131
URL=https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-$VER-linux-x64.tar.gz
#wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3a%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk8-downloads-2133151.html; oraclelicense=accept-securebackup-cookie;" "$URL" -O /tmp/jdk-$VER-linux-x64.tar.gz
wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz -O /tmp/jdk-8u131-linux-x64.tar.gz
tar -xzf /tmp/jdk-$VER-linux-x64.tar.gz --directory=/usr/local/
rm -f /tmp/jdk-$VER-linux-x64.tar.gz
echo "JAVA_HOME=/usr/local/jdk1.8.0_131" >> /etc/profile
echo "PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile
echo "export JAVA_HOME PATH" >> /etc/profile
source /etc/profile
echo -e "\n\e[32mExecute below\nsource /etc/profile\njava -version\e[0m\e"
 if [ $? = 0 ]
 then
 echo " Java is installed on `whereis java`"
 else
 echo "Error installing Java"
 fi
fi


