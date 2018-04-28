#!/bin/bash

read -p "This is a client or server ? > " mac_type 

cp -a /etc/profile /etc/profile_bak

its_client()
{
if [ -d /data/jdk1.8 ]
then
  if [ -d /data/maven ] 
  then
  echo -e "\nGive below 4 lines in /etc/profile file in last\n

JAVA_HOME=/data/jdk1.8
MAVEN_HOME=/data/maven
PATH=\$JAVA_HOME/bin:\$MAVEN_HOME/bin:\$PATH
export PATH JAVA_HOME MAVEN_HOME\n

And Execute 'source /etc/profile' and check java version by executing 'java -version' and maven version 'mvn -version'\n"

  else
  echo -e "\nDirectory not found '/data/maven'"
  exit 1
  fi

else
echo -e "\nDirectory not found '/data/jdk1.8'"

fi

}

its_server()
{
if [ -d /data/jdk1.8 ]
then
echo -e "\nGive below 3 lines in /etc/profile file in last\n

JAVA_HOME=/data/jdk1.8
PATH=\$JAVA_HOME/bin:\$PATH
export PATH JAVA_HOME \n

#And Execute 'source /etc/profile' and check java version by executing 'java -version'"

else

echo -e "\nDirectory not found '/data/jdk1.8'"

fi
}

case $mac_type in
client)
its_client
;;

server)
its_server
;;

*)
echo "select one client/server"
exit 1
;;

esac 
