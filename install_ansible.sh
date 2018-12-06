#!/bin/bash

yum install epel-release -y
yum install ansible -y


echo -e "\e[32m

-> Login to client01 machine 

-> Execute below commands

# cd /data
# mkdir ansible
# cd ansible
#vim hosts

[servers]
server01 ansible_ssh_host=<REPLACE_SERVER_PRIVATE_IP> ansible_ssh_user=centos ansible_ssh_pass=<REPLACE_CENTOSUSER_SERVER01_PASSWORD>

#ansible servers -m ping -i hosts
#ansible -m shell -a 'free -m' 'server01'
#'ansible -m ping server01'

-> Now install Nginx on server01 using ansible

#vim nginx_install.yml


---
- hosts: servers
  tasks:
    - name: Install YUM repo
      command: yum install epel-release
      
    - name: Installs nginx web server
      yum: pkg=nginx state=installed update_cache=true
      become: yes
      become_method: sudo
      become_user: root
      notify:
       - start nginx

  handlers:
    - name: start nginx
      service: name=nginx state=started
      become: yes
      become_method: sudo
      become_user: root


#ansible-playbook nginx_install.yml
#curl http://<REPLACE_SERVER01_PRIVATE_IP>

-> Create another yaml to create a file

#vim create_file.yml

---
- hosts: servers
  tasks:
      - name: Create file
        file:
            path: /tmp/etlhive.txt
            state: touch

#ansible-playbook -i hosts create_file.yml -v

-> Create another yaml to create a user and install package in once.

#vim create_user.yml

- hosts: server01
  tasks:
      - name: Create user
        user:
            name: etlhive
            shell: /sbin/nologin

      - name: Install zlib
        yum:
            name: zlib
            state: latest

#ansible-playbook -i hosts user_create.yml -vv

-> Create a yaml to copy file.

#echo "Hello, this is a test page." > /tmp/index.html
#vim copy_file.yml

---
- hosts: server01
  tasks:
      - name: Nginx default home page
        become: yes
        become_method: sudo
        become_user: root
        template:
            src:  /tmp/index.html
            dest: /usr/share/nginx/html/index.html

#ansible-playbook -i hosts copy_file.yml -vv
#curl http://<REPLACE_SERVER01_PRIVATE_IP>

-> Create a yaml to edit file

#vim file_edit.yml

---
- hosts: server01
  tasks:
      - lineinfile:
                    dest: /usr/share/nginx/html/index.html
                    regexp: '^NAME='
                    line: 'NAME=eth1'
        become: yes
        become_method: sudo
        become_user: root
      - lineinfile:
                    dest: /usr/share/nginx/html/index.html
                    regexp: '^IPADDR='
                    line: 'IPADDR=8.8.8.8'
        become: yes
        become_method: sudo
        become_user: root


#ansible-playbook -i file_edit.yml -vvv
#curl http://<REPLACE_SERVER01_PRIVATE_IP>

\e[0m\n"
