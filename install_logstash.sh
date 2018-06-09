#!/bin/bash

echo -e "[logstash-5.x]
name=Elastic repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md" > /etc/yum.repos.d/logstash.repo

yum install logstash -y

MYIP=`ip a | grep eth0 | tail -1 | awk '{print $2}' | awk -F "/" '{print $1}'`
sed -i "227isubjectAltName = IP: $MYIP" /etc/pki/tls/openssl.cnf

cd /etc/pki/tls
openssl req -config /etc/pki/tls/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt

echo -e "input {
    beats {
        port => 5044
        ssl => true
        ssl_certificate => "/etc/pki/tls/certs/logstash-forwarder.crt"
        ssl_key => "/etc/pki/tls/private/logstash-forwarder.key"
    }
}" > /etc/logstash/conf.d/input.conf

echo -e "output {
     elasticsearch {
         hosts => ["localhost:9200"]
         sniffing => true
         manage_template => false
         index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
         document_type => "%{[@metadata][type]}"
     }
}" > /etc/logstash/conf.d/output.conf

echo -e "filter {
    if [type] == "syslog" {
        grok {
            match => { "message" => "%{SYSLOGLINE}" }
        }
        date {
            match => [ "timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
        }
    }
}" > /etc/logstash/conf.d/filter.conf

sed -i 's/-Xms256m/-Xms128m/g' /etc/logstash/jvm.options
sed -i 's/-Xmx1g/-Xmx128m/g' /etc/logstash/jvm.options

systemctl daemon-reload
systemctl enable logstash
systemctl start logstash

firewall-cmd --add-port=5044/tcp
firewall-cmd --add-port=5044/tcp --permanent
