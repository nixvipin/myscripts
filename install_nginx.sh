#!/bin/bash

grep -w "SELINUX=enforcing" /etc/selinux/config | grep -v "#"

if [ $? != 0 ]
then
echo "ok.."
else
echo -e "\nDisable SELinux - Change below config in '/etc/selinux/config' file and restart VM or execute 'setenforce 0'.

SELINUX=enforcing

to 

SELINUX=permissive

"

exit 1
fi

yum install epel-release -y
yum install nginx -y
sed -i 's/80/8004/g' /etc/nginx/nginx.conf
systemctl start nginx
systemctl enable nginx
systemctl status nginx
