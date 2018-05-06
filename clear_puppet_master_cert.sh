rm -rf /etc/puppetlabs/puppet/ssl
/opt/puppetlabs/puppet/bin/puppet resource service puppetserver
puppet cert list -a
puppet master --no-daemonize --verbose
puppet resource service puppetserver ensure=running

echo -e "\nExecute below on Puppet agent node

puppet resource service puppet ensure=stopped
puppet resource service puppet ensure=running

"

echo -e "\nThen sign the agent request certificate on puppet master.

/opt/puppetlabs/bin/puppet cert list --all
/opt/puppetlabs/bin/puppet cert sign client01.us-west-2.compute.internal

"
