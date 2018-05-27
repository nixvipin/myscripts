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

read -p "\nEnter MySQL root password which you entered above --> " my_password

echo -e "\n========== Execute commands in\e[32m green\e[0m ==========\n


mysql -uroot -p$my_password

MariaDB [(none)]>\e[32m create database mydb;\e[0m
Query OK, 1 row affected (0.00 sec)

MariaDB [(none)]>\e[32m grant all on mydb.* to myuser@'localhost' identified by 'mypass';\e[0m
Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> \e[32m exit\e[0m
Bye
[root@server01 myscripts]#\e[32m mysql -umyuser -pmypass mydb \e[0m

MariaDB [mydb]>\e[32m CREATE TABLE EMPLOYEE(
    ->     id INT NOT NULL auto_increment,
    ->     name VARCHAR(50) NOT NULL,
    ->     joining_date DATE NOT NULL,
    ->     salary DOUBLE NOT NULL,
    ->     ssn VARCHAR(30) NOT NULL UNIQUE,
    ->     PRIMARY KEY (id)
    -> );\e[0m
Query OK, 0 rows affected (0.02 sec)

MariaDB [mydb]> \e[32m desc EMPLOYEE; \e[0m
+--------------+-------------+------+-----+---------+----------------+
| Field        | Type        | Null | Key | Default | Extra          |
+--------------+-------------+------+-----+---------+----------------+
| id           | int(11)     | NO   | PRI | NULL    | auto_increment |
| name         | varchar(50) | NO   |     | NULL    |                |
| joining_date | date        | NO   |     | NULL    |                |
| salary       | double      | NO   |     | NULL    |                |
| ssn          | varchar(30) | NO   | UNI | NULL    |                |
+--------------+-------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

MariaDB [mydb]> \e[32m select * from EMPLOYEE; \e[0m
Empty set (0.00 sec)

MariaDB [mydb]>\e[32m exit \e[0m

\n"

