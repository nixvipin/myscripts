#!/bin/bash

build_setup()
{
rm -rf ~/.jenkins/jobs/myproject_build
unzip myproject_build.zip -d ~/.jenkins/jobs/myproject_build
}

deploy_Setup()
{
rm -rf ~/.jenkins/jobs/myproject_deploy
unzip myproject_deply.zip -d ~/.jenkins/jobs/myproject_deploy
}

restart_jenkins()
{
cd /data/jenkins/bin
./shutdown.sh
./startup.sh
}

read -p "\1. Build Job setup\2.Deploy Job setup\3.Both Build and Deploy Job setup\4.Exit" INPUT

case $INPUT in
	1)
		build_setup
		restart_jenkins
		;;
	2)
		deploy_Setup
		restart_jenkins
		break
		;;
	3)
		build_setup		
		deploy_Setup
		restart_jenkins	
		;;
	4)	echo "See you next time!"
		exit 1
		;;
	*)	echo "Sorry! Invalid input"
		exit 1
		;;
esac

