#!/bin/bash

read -p "You existing jobs will be wiped-out.. continue..?(y/n) " ans

if [ $ans = y ]
then
cp -rfa ~/.jenkins/jobs ~/.jenkins/jobs_bak
rm -rf  ~/.jenkins/jobs/myproject_build ~/.jenkins/jobs/myproject_deploy
elif [ $ans = n ]
then
echo -e "\nSee you next time..\n"
exit 1
else
echo -e "\nSupported inputs only y/n..\n"
exit 1
fi

build_setup()
{
unzip -j myproject_build.zip -d ~/.jenkins/jobs/myproject_build
}

deploy_Setup()
{
unzip -j myproject_deploy.zip -d ~/.jenkins/jobs/myproject_deploy
}

restart_jenkins()
{
cd /data/jenkins/bin
./shutdown.sh
sleep 10
./startup.sh
}

echo -e "\n1.Build Job setup\n2.Deploy Job setup\n3.Both Build and Deploy Job setup\n4.Exit\n"
read -p "SELECT: " INPUT

case $INPUT in
	1)
		build_setup
		restart_jenkins
		echo -e "\n\e[32mJenkins job setup is complete - http://Client_PublicIP:8080/jenkins\e[0m\n"
		;;
	2)
		deploy_Setup
		restart_jenkins
		echo -e "\n\e[32mJenkins job setup is complete - http://Client_PublicIP:8080/jenkins\e[0m\n"
		;;
	3)
		build_setup		
		deploy_Setup
		restart_jenkins	
		echo -e "\n\e[32mJenkins job setup is complete - http://Client_PublicIP:8080/jenkins\e[0m\n"
		;;
	4)	echo "See you next time!"
		exit 1
		;;
	*)	echo "Sorry! Invalid input"
		exit 1
		;;
esac

