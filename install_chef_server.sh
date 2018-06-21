#!/bin/bash

IPADDRESS=`ip a | grep inet -w | tail -1 | awk '{print $2}' | awk -F '/' '{print $1}'`

read -p "Have you taken snapshop of your VM (y/n) > " ans

if [ $ans = y ]
then
echo "\n\e[32mStarting Installtion.. \e[0m\n"
sleep 5
else
echo "\n\e[32mPlease take VM snapshot and come again..\e[0m\n"
exit 1
fi

read -p "Enter your mail id > " MAIL_ID
read -p "Enter your Chef Server IP Address > " CHEF_SERVIP
read -p "Enter your workstation/Node IP Address. > " WSIP

yum  install ntpdate -y; ntpdate 1.ro.pool.ntp.org

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
echo -e "\n\e[32mEnter below workstation root password..Type "yes" (if asked) \e[0m\n" 
ssh $WSIP 'mkdir -p /root/chef-repo/.chef/'
echo -e "\n\e[32mAgain enter below workstation root password..\e[0m\n"
scp /root/.chef/chefadmin.pem /root/.chef/chefvalidator.pem root@$WSIP:/root/chef-repo/.chef/

echo -e "\n\e[32m

Add below line in /etc/hosts and start from step 1 below.

$IPADDRESS `hostname`

1. Now login to our Management console for our Chef server with the user/password  "chefadmin" created and password redhat --  http://$IPADDRESS

2. Download the Starter Kit for WorkStation. Administration > Choose Organization > Click Settings Icon > Download Starter Kit

3. After downloading this kit on Desktop. Use WinSCP and copy this Kit to your Workstation($WSIP) /root folder and extract. This provides you with a default Starter Kit to start up with your Chef server. It includes a chef-repo.

4. mv /root/chef-repo /root/chef-repo_bak; yum install unzip -y; cd ~; unzip chef-starter.zip; cd chef-repo

5. tree

6. This is the file structure for the downloaded Chef repository. It contains all the required file structures to start with.

7. cd /root/chef-repo/cookbooks; knife cookbook site download learn_chef_httpd

8. tar -xvf learn_chef_httpd-0.2.0.tar.gz

9. All the required files are automatically created under this cookbook. We didn't require to make any modifications. Let's check our recipe description inside our recipe folder.

10. cat learn_chef_httpd/recipes/default.rb

11. Validating the Connection b/w Server and Workstation. Before uploading the cookbook, we need to check and confirm the connection between our Chef server and Workstation. First of all, make sure you've proper Knife configuration file.

12. cat /root/chef-repo/.chef/knife.rb

13. knife client list

14. knife ssl fetch

15. ls -l /root/chef-repo/.chef/trusted_certs

16. knife ssl check

17. knife client list

18. knife user list

19. knife cookbook upload learn_chef_httpd.

20. Verify the cookbook from the Chef Server Management console. Chef Manage > Policy.

21. Now let's Add a Node. Execute below commands on Workstation.

22. knife bootstrap 192.168.56.102 --ssh-user root --ssh-password redhat --node-name devopsclient

23. knife node list

24. knife node show devopsclient

25. Now verify it from the Management console "Nodes". Chef Manage > Nodes.

26. You can get more information regarding the added node by selecting the node and viewing the Attributes section.

27. Now add a cookbook to the node and manage its runlist from the Chef server. Chef Manage > Nodes > Action settings Icon > Edit Runlist. In the Available Recipes,  you can see our learn_chef_httpd recipe, you can drag that from the available packages to the current run list and save the runlist.

28. Now login to your node and just run the command 'chef-client' to execute your runlist.

29. You should be able to see your Node IP runnig a webserver. http://$WSIP/.
 - Similarly, later on you can add any number of nodes to your Chef Server depending on its configuration and hardware.

30. Now let's add some Recipes. Execute below on Workstation

31. cd /root/chef-repo/cookbooks; knife recipe list

32. knife cookbook create file_create

33. cd file_create/recipes/

34. vim default.rb

file '/tmp/i_m_chef.txt' do
   mode '0600'
      owner 'root'
      end

35. knife cookbook upload file_create

36. Drag that from the available packages to the current run list and save the runlist in Chef Manage.

37. Execute 'chef-client' on Node machine (In you case workstation).

38. cd /root/chef-repo/cookbooks; knife recipe list

39. knife cookbook create user_create

40. vim user_create/recipes/default.rb

user 'tcruise' do
  comment 'Tom Cruise'
  home '/home/tcruise'
  shell '/bin/bash'
  password 'redhat'
end

41. knife cookbook upload user_create

42. Drag that from the available packages to the current run list and save the runlist in Chef Manage.

43. chef-client

44. knife cookbook create filecopy

45. echo -e "My current time is: " > filecopy/templates/default/current_time.txt

46. vim filecopy/recipes/default.rb

execute 'date_cmd' do
  command 'echo `date` >> /tmp/current_time.txt'
end

template '/tmp/current_time.txt' do
  source 'current_time.txt'
  notifies :run, 'execute[date_cmd]', :delayed
end


47. knife cookbook upload filecopy

48. Drag that from the available packages to the current run list and save the runlist in Chef Manage.

49. chef-client

50. There are many resource example avaialble at https://docs.chef.io/

\e[0m\n"
