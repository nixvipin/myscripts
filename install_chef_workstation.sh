#!/bin/bash
read -p "Have you taken snapshop of your VM (y/n) > " ans

if [ $ans = y ]
then
echo "Starting Installtion.. "
sleep 5
else
echo -e "\n\e[32mPlease take VM snapshot and come again..\e[0m\n"
exit 1
fi

systemctl stop firewalld
systemctl disable firewalld

yum install vim tree ntpdate -y

ntpdate 1.ro.pool.ntp.org

wget https://packages.chef.io/stable/el/7/chefdk-0.14.25-1.el7.x86_64.rpm
rpm -ivh chefdk-0.14.25-1.el7.x86_64.rpm
IPADDRESS=`ip a | grep inet -w | tail -1 | awk '{print $2}' | awk -F '/' '{print $1}'`

echo -e "\n\e[32m
Add below line in /etc/hosts and start from step 1 below.

$IPADDRESS `hostname`

\e[0m\n"

mkdir chef-repo
cd chef-repo

echo -e "package 'httpd'
service 'httpd' do
action [:enable, :start] end

file '/var/www/html/index.html' do
content 'Welcome to Apache in Chef'
end" > hello.rb

chef-apply hello.rb

echo -e "\n\e[32mwe can verify it by running the server IP in the browser..\e[0m\n"

mkdir cookbooks
cd cookbooks/
chef generate cookbook httpd_deploy
chef generate template httpd_deploy index.html

echo -e "\nWelcome to Chef Apache Deployment\n" > ./httpd_deploy/templates/default/index.html.erb
cd  /root/chef-repo/cookbooks/httpd_deploy/recipes
echo -e "\n#
# Cookbook Name:: httpd_deploy
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
package 'httpd'
service 'httpd' do
action [:enable, :start] end

template '/var/www/html/index.html' do
source 'index.html.erb'
end" > default.rb

cd /root/chef-repo
chef-client --local-mode --runlist 'recipe[httpd_deploy]'
cat /var/www/html/index.html

