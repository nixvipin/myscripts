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

#sed -i 's/-Xms2g/-Xms384m/g' /etc/elasticsearch/jvm.options
#sed -i 's/-Xmx2g/-Xmx384m/g' /etc/elasticsearch/jvm.options

sed -i '/cluster.name/s/^#//g' /etc/elasticsearch/elasticsearch.yml
sed -i '/node.name/s/^#//g' /etc/elasticsearch/elasticsearch.yml
sed -i '/network.host/s/^#//g' /etc/elasticsearch/elasticsearch.yml
sed -i '/http.port/s/^#//g' /etc/elasticsearch/elasticsearch.yml
sed -i '/path.data/s/^#//g' /etc/elasticsearch/elasticsearch.yml
sed -i '/path.logs/s/^#//g' /etc/elasticsearch/elasticsearch.yml
sed -i '/discovery.zen.minimum_master_nodes/s/^#//g' /etc/elasticsearch/elasticsearch.yml

sed -i -e "s/^\(node\.name\s*:\s*\).*\$/\1client01/" /etc/elasticsearch/elasticsearch.yml
sed -i -e "s/^\(network\.host\s*:\s*\).*\$/\10\.0\.0\.0/" /etc/elasticsearch/elasticsearch.yml
sed -i -e "s/^\(http\.port\s*:\s*\).*\$/\19200/" /etc/elasticsearch/elasticsearch.yml
sed -i -e "s/^\(path\.data\s*:\s*\).*\$/\1\/data\/elasticsearch\/data/" /etc/elasticsearch/elasticsearch.yml
sed -i -e "s/^\(path\.logs\s*:\s*\).*\$/\1\/data\/elasticsearch\/logs/" /etc/elasticsearch/elasticsearch.yml
sed -i -e "s/^\(discovery\.zen\.minimum_master_nodes\s*:\s*\).*\$/\11/" /etc/elasticsearch/elasticsearch.yml


mkdir -p /data/elasticsearch/{data,logs} -p
chown -R elasticsearch. /data/elasticsearch/
usermod -s /usr/bin/bash elasticsearch
mkdir -p /home/elasticsearch
cd /etc/skel
cp -a .bash* /home/elasticsearch/
chown -R elasticsearch. /home/elasticsearch

sed -i '/elasticsearch/d' /etc/security/limits.conf
echo -e "elasticsearch soft nofile 65536
elasticsearch hard nofile 65536" >> /etc/security/limits.conf

systemctl daemon-reload
systemctl enable elasticsearch
systemctl restart elasticsearch

#yum install firewalld -y
#systemctl start firewalld
#systemctl enable firewalld

#firewall-cmd --add-port=9200/tcp
#firewall-cmd --add-port=9200/tcp --permanent


echo -e "\n\e[32m ...Done... \e[0m\n"
