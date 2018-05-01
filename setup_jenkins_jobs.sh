#!/bin/bash

rm -rf /tmp/Deploy_Project_Main_duplicate /tmp/My_Project_Main_duplicate

cd /data/jenkins/bin
./shutdown.sh
cp  /data/myscripts/jenkins_jobs.zip /tmp/
cd /tmp
yum install unzip  -y
unzip jenkins_jobs.zip

if [ -d ~/.jenkins/jobs/My_Project_Main ]
then
mv ~/.jenkins/jobs/My_Project_Main /tmp/My_Project_Main_duplicate
cp -rf /tmp/jenkins_jobs/My_Project_Main ~/.jenkins/jobs/
else
cp -rf jenkins_jobs/My_Project_Main ~/.jenkins/jobs/
fi

if [ -d ~/.jenkins/jobs/Deploy_Project_Main ]
then
mv ~/.jenkins/jobs/Deploy_Project_Main /tmp/Deploy_Project_Main_duplicate
cd /tmp
cp -rf jenkins_jobs/Deploy_Project_Main ~/.jenkins/jobs/
else
cp -rf jenkins_jobs/Deploy_Project_Main ~/.jenkins/jobs/
fi


rm -rf /tmp/jenkins_jobs
rm /tmp/jenkins_jobs.zip

cd /data/jenkins/bin/
./startup.sh

echo -e "\nJenkins jobs are loaded successfully\n
