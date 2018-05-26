#!/bin/bash


yum remove httpd -y 
systemctl stop mysqld
systemctl disable mysqld
yum remove MariaDB-server MariaDB-client -y
sleep 5
cd /etc
rm -rf httpd
setenforce 0
yum install httpd php php-cli gcc glibc glibc-common gd gd-devel net-snmp openssl-devel wget unzip -y 
useradd nagios
groupadd nagcmd
usermod -a -G nagcmd nagios
usermod -a -G nagcmd apache
cd /tmp
rm nagios-4.1.1.tar.gz nagios-plugins-2.1.1.tar.gz
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

echo -e "\n\e[32mSet Nagios GUI console password.\e[0m\n"

htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

cd /tmp/nagios-plugins-2.1.1
./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
make all
make install
service httpd start
service nagios start


echo -e "\n\e[32mYou should now be able to access Nagios GUI console by navigating to http://ClientPublicIP/nagios/. Default username: nagiosadmin.\e[0m\n"
