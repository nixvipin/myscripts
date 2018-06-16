#!/bin/bash
read -p "Have you taken snapshop of your VM (y/n) > " ans

if [ $ans = y ]
then
echo "Starting Installtion.. "
sleep 5
else
echo "Please take VM snapshot and come again.. "
exit 1
fi

read -p "Enter your first name > " FIRSTNAME
read -p "Enter your last name > " LASTNAME
read -p "Enter your mail id > " MAIL_ID
read -p "Enter new admin username > " USERADMIN
read -p "Enter new admnin password > " PASSWORD

wget https://packages.chef.io/files/stable/chef-server/12.15.8/el/7/chef-server-core-12.15.8-1.el7.x86_64.rpm

rpm -ivh chef-server-core-12.15.8-1.el7.x86_64.rpm

chmod 600 ~/.netrc

chef-server-ctl reconfigure
chef-server-ctl status
chef-server-ctl install chef-manage
opscode-manage-ctl reconfigure
chef-server-ctl reconfigure
mkdir ~/.chef
chef-server-ctl user-create $USERADMIN $FIRSTNAME $LASTNAME $MAIL_ID $PASSWORD --filename /root/.chef/chefadmin.pem
chef-server-ctl org-create chef-organization 'Chef Oraganization' --association_user $USERADMIN --filename /root/.chef/chefvalidator.pem
ssh 192.168.56.102 'mkdir -p /root/chef-repo/.chef/'
scp /root/.chef/chefadmin.pem /root/.chef/chefvalidator.pem root@192.168.56.102:/root/chef-repo/.chef/

echo -e "\n

1. Now login to our Management console for our Chef server with the user/password  "chefadmin" created and password $PASSWORD --  http://192.168.56.101

2. It'll ask to create an organization from the Panel on Sign up. Just create a different one.

3. Download the Starter Kit for WorkStation. Administration > Choose Organization > Click Settings Icon > Download Starter Kit

4. After downloading this kit. Move it your Workstation /root folder and extract. This provides you with a default Starter Kit to start up with your Chef server. It includes a chef-repo.

5. unzip chef-starter.zip

6. cd chef-repo

7. tree

8. This is the file structure for the downloaded Chef repository. It contains all the required file structures to start with.

9. knife cookbook site download learn_chef_httpd

10. tar -xvf learn_chef_httpd-0.2.0.tar.gz

11. All the required files are automatically created under this cookbook. We didn't require to make any modifications. Let's check our recipe description inside our recipe folder.

12. cat  /root/chef-repo/cookbooks/learn_chef_httpd/recipes/default.rb

13. Validating the Connection b/w Server and Workstation. Before uploading the cookbook, we need to check and confirm the connection between our Chef server and Workstation. First of all, make sure you've proper Knife configuration file.

14. First of all, make sure you've proper Knife configuration file.

15. cat /root/chef-repo/.chef/knife.rb

16. knife client list

17. knife ssl fetch

18. ls -l /root/chef-repo/.chef/trusted_certs

19. knife ssl check

20. knife client list

21. knife user list

22. knife cookbook upload learn_chef_httpd

23. Verify the cookbook from the Chef Server Management console.

24. Now Adding a Node

25. knife bootstrap 192.168.56.102 --ssh-user root --ssh-password $ROOT_PASSWORD --node-name devopsclient

26. knife node list

27. knife node show $NODE_NAME

28. Verifying it from the Management console \"Nodes\".

29. We can get more information regarding the added node by selecting the node and viewing the Attributes section.

30. Add Reciepe for new node.

31. Now login to your node and just run the command 'chef-client' to execute your runlist.

32. Similarly, we can add any number of nodes to your Chef Server depending on its configuration and hardware"
