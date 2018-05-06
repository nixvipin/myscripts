rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y install puppet-agent
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

echo -e "\nMake the client entry in /etc/hosts file

11.22.33.44 puppet client01"

echo -e "\nGo to the server and sign the certificate. For example

/opt/puppetlabs/bin/puppet cert list
/opt/puppetlabs/bin/puppet cert sign host1.nyc3.example.com

"
