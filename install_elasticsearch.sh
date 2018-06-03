#!/bin/bash
rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch

echo -e "[elasticsearch-5.x]
name=Elasticsearch repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md" > /etc/yum.repos.d/elasticsearch.repo

yum install elasticsearch -y

sed -i 's/-Xms2g/-Xms128m/g' /etc/elasticsearch/jvm.options
sed -i 's/-Xmx2g/-Xmx512m/g' /etc/elasticsearch/jvm.options

systemctl daemon-reload
systemctl enable elasticsearch
systemctl start elasticsearch
