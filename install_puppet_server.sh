yum -y install ntp
ntpdate pool.ntp.org
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y install puppetserver
sed -i -e "s/^\(JAVA_ARGS\s*=\s*\).*\$/\1\"-Xms128m -Xmx256m -XX:MaxPermSize=256m\"/" /etc/sysconfig/puppetserver
systemctl restart ntpd
systemctl enable ntpd
systemctl restart puppetserver
systemctl enable puppetserver

echo -e "\nPlease make 'server' entry in /etc/hosts file. For Example

\e[32m11.22.33.44 server01\e[0m

#Replace 11.22.33.44 with you Server Private IP Address\n"
