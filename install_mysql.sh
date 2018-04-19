#!/bin/bash

echo "[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.1/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1" > /etc/yum.repos.d/MariaDB.repo

yum install MariaDB-server MariaDB-client -y

systemctl start mariadb
systemctl enable mariadb
systemctl status mariadb

mysql_secure_installation


mysql -V
mysqld --print-defaults
read -p "Enter MySQL root password to login -->" password
mysql -u root -p$password

echo -e "\eYou're all set!"
