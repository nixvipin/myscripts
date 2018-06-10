#!/bin/bash

#read -p "Please enter your Elasticsearch(client01) server private IP address > " ela_ser_ip 

rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch

echo -e "[filebeat]
name=Filebeat for ELK clients
baseurl=https://packages.elastic.co/beats/yum/el/\$basearch
enabled=1
gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
gpgcheck=1" > /etc/yum.repos.d/filebeat.repo

yum remove filebeat -y; rm -rf /etc/filebeat
yum -y  install filebeat

sed -i "22i - /data/apache-tomcat/logs/*.log" /etc/filebeat/filebeat.yml
sed -i "23i - /data/apache-tomcat/logs/*.txt" /etc/filebeat/filebeat.yml
sed -i '24d' /etc/filebeat/filebeat.yml
sed -i "83ihosts: [\"127.0.0.1:9200\"]" /etc/filebeat/filebeat.yml
sed -i '/localhost/d' /etc/filebeat/filebeat.yml
systemctl enable filebeat
systemctl start filebeat

echo -e "\n\e[32m..Done..\e[0m\n"
