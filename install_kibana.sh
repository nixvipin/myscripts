#!/bin/bash

echo -e "[logstash-5.x]
name=Elastic repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md" > /etc/yum.repos.d/kibana.repo

yum install kibana -y

systemctl daemon-reload
systemctl enable kibana
systemctl start kibana

firewall-cmd --add-port=5601/tcp
firewall-cmd --add-port=5601/tcp --permanent

echo -e "\n\e[32mLaunch Kibana (http://ClientPublicIP:5601) to verify that you can access the web interface\e[0m\n" 
