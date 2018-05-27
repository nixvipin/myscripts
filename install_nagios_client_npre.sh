#!/bin/bash
rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y nrpe nagios-plugins-all

read -p "Enter your server Nagios server private IP Address >" ser_pip

echo -e "\n\e[32mModify the NRPE configuration file to accept the connection from the Nagios server, Edit the /etc/nagios/nrpe.cfg file (line 117)

allowed_hosts=127.0.0.1,$ser_pip

Anad Execute below commands

systemctl restart nrpe
systemctl enable nrpe
\e[0m\n
"

