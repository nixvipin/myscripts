#!/bin/bash
yum remove salt-minion -y
rm /etc/salt/minion
rpm -e epel-release-7-11.noarch
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum clean expire-cache -y 
yum install salt-minion -y

read -p "Please enter your salt master IP Address: > " saltmas_ip

echo -e "\n
master: $saltmas_ip
hash_type: sha256
" >> /etc/salt/minion

systemctl start salt-minion.service
systemctl enable salt-minion.service

echo -e "n\Now execute below on Salt Master Server

1. salt-key -L
2. salt-key --accept=`hostname`
3. salt `hostname` test.ping
4. salt `hostname` cmd.run pwd
5. salt `hostname` cmd.run "ls -l"

"
