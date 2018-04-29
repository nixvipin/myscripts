#!/bin/bash

yum install haproxy -y

echo -e "\n\e[32mEdit below configuration in /etc/haproxy/haproxy.cfg\e[0m


#---------------------------------------------------------------------
# main frontend which proxys to the backends
#---------------------------------------------------------------------
frontend  main *:80
    mode                http
    acl url_static       path_beg       -i /static /images /javascript /stylesheets
    acl url_static       path_end       -i .jpg .gif .js

    use_backend static          if url_static
    default_backend             myproject

	
Add below configuration in /etc/haproxy/haproxy.cfg


backend myproject
    balance roundrobin
    server web1 127.0.0.1:8001 check

\n\e[32mRestart HAProxy service 'systemctl restart haproxy'\e[0m\n"

