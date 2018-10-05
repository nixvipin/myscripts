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

Add below line in /etc/hosts file.

$IPADDRESS `hostname`

\e[0m\n"

echo -e "Follow Below steps to setup chef knife and chef slave node."

echo -e "\n\e[32m

1. cd /root/; unzip chef-starter.zip; cd chef-repo

2. tree

3. cd /root/chef-repo/cookbooks; knife cookbook site download learn_chef_httpd

4. tar -xvf learn_chef_httpd-0.2.0.tar.gz

5. All the required files are automatically created under this cookbook. We didn't require to make any modifications. Let's check our recipe description inside our recipe folder.

6. cat learn_chef_httpd/recipes/default.rb

7. Validating the Connection b/w Server and Workstation. Before uploading the cookbook, we need to check and confirm the connection between our Chef server and Workstation. First of all, make sure you've proper Knife configuration file.

8. cat /root/chef-repo/.chef/knife.rb

9. knife client list

10. knife ssl fetch

11. ls -l /root/chef-repo/.chef/trusted_certs

12. knife ssl check

13. knife client list

14. knife user list

15. knife cookbook upload learn_chef_httpd.

16. Verify the cookbook from the Chef Server Management console. Chef Manage > Policy.

17. Now let's Add a Node. Execute below commands on Workstation.

18. knife bootstrap $AGENT_NODE --ssh-user $AGENT_USER --ssh-password $AGENT_PASSWORD --node-name $AGENT_HOST

19. knife node list

20. knife node show $AGENT_HOST

21. Now verify it from the Management console "Nodes". Chef Manage > Nodes.

22. You can get more information regarding the added node by selecting the node and viewing the Attributes section.

23. Now add a cookbook to the node and manage its runlist from the Chef server. Chef Manage > Nodes > Action settings Icon > Edit Runlist. In the Available Recipes,  you can see our learn_chef_httpd recipe, you can drag that from the available packages to the current run list and save the runlist.

24. Now login to your node and just run the command 'chef-client' to execute your runlist.

25. You should be able to see your Node IP runnig a webserver. http://$WSIP/.

26. Similarly, there you can add any number of nodes to your Chef Server depending on its configuration and hardware.

27. Now let's add some Recipes. Execute below on Workstation

28. cd /root/chef-repo/cookbooks; knife recipe list

29. knife cookbook create file_create

30. cd file_create/recipes/

31. vim default.rb

file '/tmp/i_m_chef.txt' do
   mode '0600'
      owner 'root'
      end

32. knife cookbook upload file_create

33. Drag that from the available packages to the current run list and save the runlist in Chef Manage.

34. Execute 'chef-client' on Node machine (In you case workstation).

35. cd /root/chef-repo/cookbooks; knife recipe list

36. knife cookbook create user_create

37. vim user_create/recipes/default.rb

user 'tcruise' do
  comment 'Tom Cruise'
  home '/home/tcruise'
  shell '/bin/bash'
  password 'redhat'
end

38. knife cookbook upload user_create

39. Drag that from the available packages to the current run list and save the runlist in Chef Manage.

40. chef-client

41. knife cookbook create filecopy

42. echo -e "My current time is: " > filecopy/templates/default/current_time.txt

43. vim filecopy/recipes/default.rb

execute 'date_cmd' do
  command 'echo `date` >> /tmp/current_time.txt'
end

template '/tmp/current_time.txt' do
  source 'current_time.txt'
  notifies :run, 'execute[date_cmd]', :delayed
end


44. knife cookbook upload filecopy

45. Drag that from the available packages to the current run list and save the runlist in Chef Manage.

46. chef-client

47. There are many resource example avaialble at https://docs.chef.io/

48. cd /root/chef-repo

49. Execute below.

vim hello.rb

echo -e "package 'httpd'
service 'httpd' do
action [:enable, :start] end

file '/var/www/html/index.html' do
content 'Welcome to Apache in Chef'
end"

50. chef-apply hello.rb

echo -e "\n\e[32mwe can verify it by running the server IP in the browser..\e[0m\n"

51. cd cd /root/chef-repo/cookbooks/

52. chef generate cookbook httpd_deploy

53. chef generate template httpd_deploy index.html


echo -e "\nWelcome to Chef Apache Deployment\n" > ./httpd_deploy/templates/default/index.html.erb

54. cd  /root/chef-repo/cookbooks/httpd_deploy/recipes

vim default.rb

#
# Cookbook Name:: httpd_deploy
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
package 'httpd'
service 'httpd' do
action [:enable, :start] end

template '/var/www/html/index.html' do
source 'index.html.erb'
end"

55. cd /root/chef-repo

56. chef-client --local-mode --runlist 'recipe[httpd_deploy]'

57. cat /var/www/html/index.html

\e[0m\n"
