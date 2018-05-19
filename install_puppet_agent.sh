rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y install puppet-agent
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

echo -e "\nMake the client entry in /etc/hosts file

\e[32m
172.31.30.44 server01 server01.us-west-2.compute.internal
172.31.31.22 puppet client01.us-west-2.compute.internal
\e[0m

#Replace IPs with you Client Machine Private IP Address\n"

echo -e "\nGo to the server and sign the certificate. For example

\e[32m
/opt/puppetlabs/bin/puppet cert list
/opt/puppetlabs/bin/puppet cert sign "server01.us-west-2.compute.internal"
/opt/puppetlabs/bin/puppet cert list --all
\e[0m"

echo -e"\nThen create a file /etc/puppetlabs/code/environments/production/manifests/site.pp on puppet master and make below entry


\e[32m
    file {'/tmp/example-ip':                                            # resource type file and filename
      ensure  => present,                                               # make sure it exists
      mode    => '0644',                                                # file permissions
      content => "Here is my Public IP Address: ${ipaddress_eth0}.\n",  # note the ipaddress_eth0 fact
    }


node 'server01.us-west-2.compute.internal' {
  class { 'apache': }             # use apache module
  apache::vhost { 'www.etlhive.com':  # define vhost resource
    port    => '80',
    docroot => '/var/www/html'
  }
}

node default {}

    file {'/var/www/html/testfile':                                            # resource type file and filename
      ensure  => present,                                               # make sure it exists
      mode    => '0644',                                                # file permissions
      content => "Here is my Public IP Address: ${ipaddress_eth0}.\n",  # note the ipaddress_eth0 fact
    }
\e[0m"

echo -e"\nThen hit http://YourServerIP in browser, the site should be accessible"
