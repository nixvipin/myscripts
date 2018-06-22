#!/bin/bash
yum remove salt-master -y
rm /etc/salt/master
rpm -e epel-release-7-11.noarch
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
yum clean expire-cache -y 
yum install salt-master -y


echo -e "\n
interface: 0.0.0.0
hash_type: sha256
" >> /etc/salt/master

mkdir -p /srv/salt/
systemctl start salt-master.service
systemctl enable salt-master.service
