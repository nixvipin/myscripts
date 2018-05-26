#!/bin/bash
rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y nrpe nagios-plugins-all

read -p "Enter your server Nagios server private IP Address >" ser_pip

echo -e "\n\e[32mModify the NRPE configuration file to accept the connection from the Nagios server, Edit the /etc/nagios/nrpe.cfg file.

allowed_hosts=127.0.0.1,$ser_pip

\e[0m\n
"
systemctl start nrpe
systemctl enable nrpe
