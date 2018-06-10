#!/bin/bash


read -p "Please enter your Elasticsearch(client01) server private IP address > " ela_ser_ip 

rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch

echo -e "[filebeat]
name=Filebeat for ELK clients
baseurl=https://packages.elastic.co/beats/yum/el/$basearch
enabled=1
gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
gpgcheck=1" > /etc/yum.repos.d/filebeat.repo

yum -y  install filebeat

#sed -i "22i - /data/apache-tomcat/logs/*.log" /etc/filebeat/filebeat.yml
#sed -i '23d' /etc/filebeat/filebeat.yml
#sed -i "83ihosts: ["$ela_ser_ip:9200"]" /etc/filebeat/filebeat.yml
systemctl enable filebeat

echo -e "\n\e[32mFollow steps below

1. Copy contents of /etc/pki/tls/certs/logstash-forwarder.crt from client01 file and paste into /etc/pki/tls/certs/logstash-forwarder.crt on this machine(server01)

2. Execute 'systemctl start filebeat' on server01

\e[0m\n"
