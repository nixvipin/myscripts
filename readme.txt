
C - Client
S - Server
J - Jenkins

# myscripts

A. Clone Myscript 

  1. mkdir /data (CS)

  2. cd /data (CS)

  3. yum install git -y (CS)

  4. git clone https://github.com/nixvipin/myscripts.git (CS)

  5. cd myscripts (CS)


==========Module 1==========

B. Execute scripts

  1. run "sh install_initial.sh" (CS)

  2. run "sh install_maven.sh" (S)

  3. WinSCP Java to /data/jdk1.8 from your windows machine (CS) 

  4. run "sh java_maven_path_setup.sh"

  5  run "sh install_mysql.sh" (C)

==========Module 2==========


C. Execute script

  1. run "sh install_jenkins.sh" (S)

  2. run "sh install_tomcat.sh" (C)

  3. run "sh build_code.sh" (J)

  4. run "sh deploy_code.sh" (J)

  5. run "sh install_apache.sh" (C)

  6. run "sh install_nginx.sh" (C)

==========Module 3==========

D. Execute script

 1. run "sh install_haproxy.sh" (S)

 2. run "sh install_puppet_server.sh" (S)

 3. run "sh install_puppet_client.sh" (C)


==========Module 4==========

 1. run "sh install_ansible_server.sh" (S)

 2. run "sh install_ansible_client.sh" (C)

 3. run "sh install_chef_server.sh" (S)

 4. run "sh install_chef_client.sh" (C)


