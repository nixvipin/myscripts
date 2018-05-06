#!/bin/bash

yum install haproxy -y

#!/bin/bash
mkdir -p /data
cd /data
wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.30/bin/apache-tomcat-8.5.30.tar.gz
tar -zxvf apache-tomcat-8.5.30.tar.gz
mv apache-tomcat-8.5.30 apache-tomcat2
cd apache-tomcat2/conf
sed -i '69s/8080/8008/' server.xml
sed -i '116s/8010/8011/' server.xml
sed -i '22s/8015/8016/' server.xml
rm /data/apache-tomcat-8.5.30.tar.gz
echo -e "\nTomcat2 installation is complete."



echo -e "\n\e[32mEdit below configuration in /etc/haproxy/haproxy.cfg\e[0m


#---------------------------------------------------------------------
# main frontend which proxys to the backends
#---------------------------------------------------------------------
frontend  main *:80
    mode                http
    acl url_static       path_beg       -i /static /images /javascript /stylesheets
    acl url_static       path_end       -i .jpg .gif .js

    use_backend static          if url_static
    default_backend             myproject

	
Add below configuration in /etc/haproxy/haproxy.cfg


backend myproject
    balance roundrobin
    server web1 127.0.0.1:8001 check
    server web2 127.0.0.1:8008 check

\n\e[32mRestart HAProxy service 'systemctl restart haproxy'\e[0m\n"

