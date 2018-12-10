#!/bin/bash
#
#This script to be executed on client01

yum -y install ntp
ntpdate pool.ntp.org
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y install puppetserver
sed -i -e "s/^\(JAVA_ARGS\s*=\s*\).*\$/\1\"-Xms128m -Xmx256m -XX:MaxPermSize=256m\"/" /etc/sysconfig/puppetserver
systemctl restart ntpd
systemctl enable ntpd
systemctl restart puppetserver
systemctl enable puppetserver
/opt/puppetlabs/bin/puppet module install puppetlabs-apache

echo -e "\nPlease make below entries in /etc/hosts file. For Example

\e[32m
<REPLACE_SERVER01_PVT_IP> server01 <ADD_AWS_FQDN>
<REPLACE_CLIENT01_PVT_IP> puppet client01 <ADD_AWS_FQDN>
\e[0m

# Replace IPs with you Server and Client Private IP Address repectively
# and exeute 'sh install_puppet_agent.sh' on server01"

mkdir -p /etc/puppetlabs/code/modules/mymodule/{files,manifests}
echo "This file was present on puppet master(client01)" > /etc/puppetlabs/code/modules/mymodule/files/data.txt
