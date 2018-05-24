#!/bin/bash

yum remove httpd -y 
cd /etc
rm -rf httpd
setenforce 0
yum install httpd php php-cli gcc glibc glibc-common gd gd-devel net-snmp openssl-devel wget unzip 
-y
useradd nagios
groupadd nagcmd
usermod -a -G nagcmd nagios
usermod -a -G nagcmd apache
cd /tmp
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.1.1.tar.gz
wget http://www.nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz
tar zxf nagios-4.1.1.tar.gz
tar zxf nagios-plugins-2.1.1.tar.gz
cd nagios-4.1.1
./configure --with-command-group=nagcmd
make all
make install
make install-init
make install-config
make install-commandmode
make install-webconf

echo -e "\nSet Nagios console password"

htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

cd /tmp/nagios-plugins-2.1.1
./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
make all
make install
service httpd start
service nagios start


echo "\nYou should now be able to access your machine by navigating to 
http://ClientPublicIP/nagios/"
