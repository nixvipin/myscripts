#!/bin/bash

grep -w "SELINUX=enforcing" /etc/selinux/config | grep -v "#"

if [ $? != 0 ]
then
echo "ok.."
else
echo -e "\nChange below config in '/etc/selinux/config' file and try again.

SELINUX=enforcing

to 

SELINUX=permissive

"

exit 1
fi

yum install epel-release -y
yum install nginx -y
sed -s 's/80/8004/g' /etc/nginx/nginx.conf
systemctl start nginx
systemctl enable nginx
systemctl status nginx
