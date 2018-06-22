#!/bin/bash
yum remove salt-minion -y
rm /etc/salt/minion
rpm -e epel-release-7-11.noarch
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
yum clean expire-cache -y 
yum install salt-minion -y

read -p "Please enter your salt master IP Address: > " saltmas_ip
read -p "Please enter your name: > " MYNAME
NEWUSER=`echo $MYNAME | tr '[A-Z]' '[a-z]'`

SERVHOST=`hostname`

echo -e "\n
master: $saltmas_ip
hash_type: sha256
" >> /etc/salt/minion

systemctl start salt-minion.service
systemctl enable salt-minion.service

echo -e "\n\e[32mNow execute below on Salt Master Server..

1. salt-key -L
2. salt-key --accept=$SERVHOST
3. salt $SERVHOST* test.ping
4. salt $SERVHOST* cmd.run pwd
5. salt $SERVHOST* cmd.run \"ls -l\"
6. salt $SERVHOST* disk.usage
7. salt $SERVHOST* pkg.install banner
8. salt $SERVHOST* cmd.run \"banner HELLO $MYNAME\"
9. vim /srv/salt/somepkg.sls

elinks:
  pkg.installed: []
  
10. salt $SERVHOST* state.apply somepkg
11. echo \"Hi $MYNAME, This is a test file\" > imtestfile.txt
12. vim /srv/salt/filecopy.sls

/tmp/testfile:
  file.managed:
    - source: salt://imtestfile.txt
    - mode: 644
    - user: root
    - group: root
  
13. salt $SERVHOST* state.apply filecopy

14. salt $SERVHOST* service.stop httpd

15. vim /srv/salt/nginx_pkg.sls

nginx:
  pkg.installed: []
  service.running:
    - require:
      - pkg: nginx

16. salt $SERVHOST* state.apply nginx_pkg

\e[0m\e"
