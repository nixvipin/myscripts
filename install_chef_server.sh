#!/bin/bash

read -p "Enter your mail id > " MAIL_ID

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

echo -e "\n\e[32mIn your workstation create a dir

mkdir -p /root/chef-repo/.chef/
download /root/.chef/chefadmin.pem and /root/.chef/chefvalidator.pem (Use WinSCP to download)
upload these files inside /root/chef-repo/.chef/ on workstation machine.

\e[0m\n"
