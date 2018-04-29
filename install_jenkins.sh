#!/bin/bash

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

setup_tomcat()
{
mkdir -p /data
cd /data
wget http://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.30/bin/apache-tomcat-8.5.30.tar.gz
tar -zxvf apache-tomcat-8.5.30.tar.gz
mv /data/apache-tomcat-8.5.30 /data/jenkins
rm /data/apache-tomcat-8.5.30.tar.gz
sed -i.orig.bak 's/8080/8002/g' /data/jenkins/conf/server.xml
}

set_war()
{
cd /data/jenkins/webapps
wget "https://updates.jenkins-ci.org/latest/jenkins.war"
}

start_jenkins()
{
cd /data/jenkins/bin
./startup.sh
sleep 10
tail -n 50 ../logs/catalina.out
echo -e "\nJenkins Started successfully\n"
}

setup_jenkins()
{
setup_tomcat
set_war
#start_jenkins
}

setup_jenkins

echo -e "\nAdd below line in /data/jenkins/conf/context.xml\n

<Context>

    <!-- Default set of monitored resources. If one of these changes, the    -->
    <!-- web application will be reloaded.                                   -->
    <WatchedResource>WEB-INF/web.xml</WatchedResource>
    <WatchedResource>${catalina.base}/conf/web.xml</WatchedResource>
\e[32m<Resources cachingAllowed="true" cacheMaxSize="100000" />\e[0m

    <!-- Uncomment this to disable session persistence across Tomcat restarts -->
    <!--
    <Manager pathname="" />
    -->
</Context>

"
echo -e "\nStart Jenkins by following below commands 

cd /data/jenkins/bin
./startup.sh

"

echo -e "\nOnce started, Jenkins will be accessible on - http://<Node_IP>:8002/jenkins\n"
