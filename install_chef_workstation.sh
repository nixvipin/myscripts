#!/bin/bash
read -p "Have you taken snapshop of your VM (y/n) > " ans

if [ $ans = y ]
then
echo "Starting Installation.. "
sleep 5
else
echo -e "\n\e[32mPlease take VM snapshot and come again..\e[0m\n"
exit 1
fi

systemctl stop firewalld
systemctl disable firewalld

read -p "Enter your Chef Server IP Address > " CHEF_SERVIP
read -p "Enter your workstation IP Address > " WSIP
read -p "Enter your agent-node IP Address > " AGENT_NODE
read -p "Enter your agent-node hostname > " AGENT_HOST
read -p "Enter your agent-node username > " AGENT_USER
read -p "Enter your agent-node password > " AGENT_PASSWORD

sh install_initial.sh
yum install vim tree ntpdate unzip -y

ntpdate 1.ro.pool.ntp.org

rm -f chef-server-core-12.15.8-1.el7.x86_64.rpm
wget https://packages.chef.io/stable/el/7/chefdk-0.14.25-1.el7.x86_64.rpm
rpm -ivh chefdk-0.14.25-1.el7.x86_64.rpm
IPADDRESS=`ip a | grep -v docker | grep inet -w | tail -1 | awk '{print $2}' | awk -F '/' '{print $1}'`

echo -e "\n\e[32m

Add below line in /etc/hosts file, ignore if already present.

192.168.56.102  server01
192.168.56.101  client01

#Replace the IP or Hostname as per your environment.

\e[0m\n"

echo -e "Follow Below steps to setup chef knife and chef slave node."

echo -e "\n\e[32m

1. Extract start kit and setup knife node.

#cd /root/
#unzip chef-starter.zip
#cd chef-repo
#tree
#cd /root/chef-repo/cookbooks

2. Validate connectivity b/w chef knife and chef manage.
#cat /root/chef-repo/.chef/knife.rb
#knife client list
#knife ssl fetch
#ls -l /root/chef-repo/.chef/trusted_certs
#knife ssl check
#knife client list
#knife user list

3. Downlaod a reciepe from https://chef.io

#knife cookbook site download learn_chef_httpd
#tar -xvf learn_chef_httpd-0.2.0.tar.gz
#tree learn_chef_httpd
#cat learn_chef_httpd/recipes/default.rb
#knife cookbook upload learn_chef_httpd

4. Adding a agent node.

#knife node list
#knife bootstrap $AGENT_NODE --ssh-user $AGENT_USER --ssh-password $AGENT_PASSWORD --node-name $AGENT_HOST
#knife node list
#knife node show $AGENT_HOST

5. Assign "learn_chef_httpd" recipe to the agent node

-> Go to Chef Manage UI > Nodes > Action settings Icon > Edit Runlist.
-> Drag and drop "learn_chef_httpd" recipe from "Available run list" to "Current run list".
-> On agent node(server01) execute the below command.

#chef-client
#curl http://$WSIP

6. Assign another recipes to the chef agent.

#cd /root/chef-repo/cookbooks
#knife recipe list
#knife cookbook create file_create
#cd file_create/recipes/
#vim default.rb

file '/tmp/i_m_chef.txt' do
   mode '0600'
      owner 'root'
      end

#knife cookbook upload file_create
-> Drag and drop "file_create" reciepe from the available packages to the current run list and save from Chef Manage UI.
#Execute 'chef-client' on chef agent machine($WSIP).
#ls -l /tmp/i_m_chef.txt

7. Create new reciepe to create a user.

#cd /root/chef-repo/cookbooks
#knife recipe list
#knife cookbook create user_create
#vim user_create/recipes/default.rb

user 'tcruise' do
  comment 'Tom Cruise'
  home '/home/tcruise'
  shell '/bin/bash'
  password 'redhat'
end

#knife cookbook upload user_create
-> Drag and drop "user_create" reciepe.
#chef-client
#grep -i tom /etc/passwd

8. Create new reciepe to copy a file.

#cd /root/chef-repo/cookbooks
#knife cookbook create filecopy
#echo -e "My current time is: " > filecopy/templates/default/current_time.txt
#vim filecopy/recipes/default.rb

execute 'date_cmd' do
  command 'echo `date` >> /tmp/current_time.txt'
end

template '/tmp/current_time.txt' do
  source 'current_time.txt'
  notifies :run, 'execute[date_cmd]', :delayed
end


#knife cookbook upload filecopy
-> Drag and drop from Chef Manage UI
#chef-client
#cat /tmp/current_time.txt

9. Create new reciepe to copy template file and start service.

#cd /root/chef-repo/cookbooks/
#chef generate cookbook httpd_deploy
#chef generate template httpd_deploy index.html
#echo -e "\nWelcome to Chef Apache Deployment\n" > ./httpd_deploy/templates/default/index.html.erb
#cd  /root/chef-repo/cookbooks/httpd_deploy/recipes
#vim default.rb

package 'httpd'
service 'httpd' do
action [:enable, :start] end

template '/var/www/html/index.html' do
source 'index.html.erb'
end

#knife cookbook upload httpd_deploy
-> Drag and Drop from UI.
#chef-client --runlist 'recipe[httpd_deploy]'
#curl http://192.168.56.102
-> In web brower type "http://192.168.56.102/"

\e[0m\n"
