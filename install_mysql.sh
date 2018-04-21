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

echo -e "\n Installation is done!\n"

echo -e "\nSet the MySQL privileges using below commands\n"

echo -e "mysql -uroot -p$password"

echo -e "\ncreate database mydb;\n"

echo "grant all on mydb.* to myuser@'localhost' identified by 'mypass';\n"

echo "mysql -umyuser -pmypass mydb"

echo "Now execute Below command

CREATE TABLE EMPLOYEE(
    id INT NOT NULL auto_increment, 
    name VARCHAR(50) NOT NULL,
    joining_date DATE NOT NULL,
    salary DOUBLE NOT NULL,
    ssn VARCHAR(30) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

"

echo -e "\nexit\n"

echo "Done\n"

