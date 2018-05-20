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
172.31.30.44 server01 server01.us-west-2.compute.internal
172.31.31.22 puppet client01.us-west-2.compute.internal
\e[0m

# Replace IPs with you Server and Client Private IP Address repectively
# and exeute 'sh install_puppet_agent.sh' on client machine"

mkdir -p /etc/puppetlabs/code/modules/mymodule/{files,manifests}
echo "This file was present on puppet master" > /etc/puppetlabs/code/modules/mymodule/files/data.txt
