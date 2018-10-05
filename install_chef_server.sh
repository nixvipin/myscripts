#!/bin/bash

IPADDRESS=`ip a | grep -v docker | grep inet -w | tail -1 | awk '{print $2}' | awk -F '/' '{print $1}'`

echo -e "\n"
read -p "Have you taken snapshop of your VM (y/n) > " ans

if [ $ans = y ]
then
echo -e "\n\e[32mStarting Installation.. \e[0m\n"
sleep 5
else
echo -e "\n\e[32mPlease take VM snapshot first..\e[0m\n"
exit 1
fi

read -p "Enter your mail id > " MAIL_ID
read -p "Enter your Chef Server IP Address > " CHEF_SERVIP
read -p "Enter your workstation/Node IP Address. > " WSIP

yum  install ntpdate -y; ntpdate 1.ro.pool.ntp.org
sh install_initial.sh

rm -f chef-server-core-12.15.8-1.el7.x86_64.rpm
wget https://packages.chef.io/files/stable/chef-server/12.15.8/el/7/chef-server-core-12.15.8-1.el7.x86_64.rpm
rpm -ivh chef-server-core-12.15.8-1.el7.x86_64.rpm
chmod 600 ~/.netrc
chef-server-ctl reconfigure
chef-server-ctl status
chef-server-ctl install chef-manage
opscode-manage-ctl reconfigure
chef-server-ctl reconfigure
mkdir ~/.chef
chef-server-ctl user-create chefadmin Tom Cruise $MAIL_ID 'redhat' --filename /root/.chef/chefadmin.pem
chef-server-ctl org-create chef-organization 'Chef Oraganization' --association_user chefadmin --filename /root/.chef/chefvalidator.pem
echo -e "\n\e[32mEnter below workstation root password..Type "yes" (if asked) \e[0m\n" 
ssh $WSIP 'mkdir -p /root/chef-repo/.chef/'
echo -e "\n\e[32mAgain enter below workstation root password..\e[0m\n"
scp /root/.chef/chefadmin.pem /root/.chef/chefvalidator.pem root@$WSIP:/root/chef-repo/.chef/

firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --reload

echo -e "\n\e[32m

Add below line in /etc/hosts and start from step 1 below.

$IPADDRESS `hostname`

1. Now login to our Management console for our Chef server with the user/password  "chefadmin" created and password redhat --  http://$IPADDRESS

2. Download the Starter Kit for WorkStation. Administration > Choose Organization > Click Settings Icon > Download Starter Kit

3. Once starter kit downlaod complete. Use WinSCP and upload this Kit to your Workstation ($WSIP) into /root/ directory.

\e[0m\n"
