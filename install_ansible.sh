#!/bin/bash

yum install epel-release -y
yum install ansible -y


echo -e "\e[32m

-> Make below entry in /etc/ansible/hosts on client machine(Ansible Tower)

[servers]
server01 ansible_ssh_host=172.31.30.44

Note: Replace IP Address with your server machine private IP

-> Execute 'useradd ansible' on server01.

-> Execute 'visudo' on server machine and add 'ansible ALL=(ALL)       NOPASSWD:ALL' in last line.

-> Execute 'useradd ansible' on client machine.

-> Execute 'su - ansible' then 'ssh-keygen'  on client machine, press blank enter until you get shell prompt.

-> Type 'exit'

-> Execute 'passwd ansible' on both client and server and set password 'ansible'.

-> Execute  'ssh-copy-id ansible@172.31.30.44' on your client machine. Replace IP with your server private IP address. Enter password 'ansible' (step 8).

-> Execute  'ansible all -m ping' and 'ansible -m shell -a 'free -m' 'server01' and 'ansible -m ping server01' on your client machine.

-> Now create a file 'vim nginx_install.yml' and copy contents below


---
- hosts: server01
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


Note: Execute 'yum install epel-release -y' on 'server01' if the above is failed.

-> And your first playbook 'ansible-playbook nginx_install.yml' on client machine.

-> Now go to server machine and see process is running or not 'ps -ef | grep nginx'.

-> If the process is running hit your IP address in brower and see nginx default page 'http://YourServerPublicIP'.

-> Create another yaml to start Nginx service in client machine\(Ansible Tower\) 'vim nginx_start.yml'. Jump to \(step 16\) if process Nginx is already running.

---
- hosts: server01
  tasks:
    - name: Start NGiNX
      service: name=nginx state=started
      name: nginx
      state: started
      become: yes
      become_method: sudo
      become_user: root

-> Now execute if the Nginx service is not running 'ansible-playbook nginx_start.yml'

-> Create another yaml to create a user, install package, create a file 'vim user_create.yml'.

---
- hosts: server01
  tasks:
      - name: Create file
        file:
            path: /tmp/etlhive.txt
            state: touch

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


-> And execute 'ansible-playbook user_create.yml'. Use 'ansible-playbook -vvv user_create.yml' to execute in debug mode.

-> Create a yaml to copy file 'vim file_copy.yml' and execute.

---
- hosts: server01
  tasks:
      - name: Nginx default home page
        become: yes
        become_method: sudo
        become_user: root
        template:
            src:  /data/myscripts/index_html_nginx
            dest: /usr/share/nginx/html/index.html

-> Now see nginx page 'http://YourServerPublicIP'.

-> Create a yaml to edit file 'vim file_edit.yml' and execute.

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


-> Now you should see variable changes on 'http://YourServerPublicIP'.

\e[0m\n"
