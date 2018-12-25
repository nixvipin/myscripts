#!/bin/bash

PID=`ps -ef | grep /data/jenkins | grep -v grep | awk '{print $2}'`
TOMCAT_VERSION=8.5.32
java -version

if [ $? = 0 ]
then
echo "ok to proceed..java is installed.."
else
echo "Install Java & try again"
exit 1
fi

if [ -f /usr/bin/wget ]
then
echo "ok to proceed..wget is installed.."
else
echo "wget is not installed..installing it now.."
yum install wget -y
fi


cd /data/
rm -rf jenkins_bak ~/.jenkins_bak
mv jenkins jenkins_bak
mv ~/.jenkins ~/.jenkins_bak

setup_tomcat()
{
kill -9 $PID
mkdir -p /data
cd /data
wget https://archive.apache.org/dist/tomcat/tomcat-8/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
tar -zxvf apache-tomcat-$TOMCAT_VERSION.tar.gz
mv /data/apache-tomcat-$TOMCAT_VERSION /data/jenkins
rm /data/apache-tomcat-$TOMCAT_VERSION.tar.gz
echo -e "export JAVA_OPTS=\"-Xms128m -Xmx512m\"" > /data/jenkins/bin/setenv.sh
chmod +x /data/jenkins/bin/setenv.sh
}

set_war()
{
cd /data/jenkins/webapps
wget "https://updates.jenkins-ci.org/latest/jenkins.war"
}

set_context_file()
{
echo -e "\n
<Context>
    <WatchedResource>WEB-INF/web.xml</WatchedResource>
    <WatchedResource>\${catalina.base}/conf/web.xml</WatchedResource>
    <Resources cachingAllowed=\"true\" cacheMaxSize=\"100000\" />
</Context>
\n
" > /data/jenkins/conf/context.xml
}

start_jenkins()
{
cd /data/jenkins/bin
./startup.sh
echo -e "\n\e[32mJenkins installation is complete - http://Client_PublicIP:8080/jenkins\e[0m\n"
}

setup_jenkins()
{
setup_tomcat
set_war
set_context_file
start_jenkins
}

setup_jenkins

