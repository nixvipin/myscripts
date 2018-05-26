#!/bin/bash
rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install nagios-plugins-nrpe

echo -e "\n"
read -p "Enter server private IP Address >" SERVERPRIVATE_IP
echo -e "\n"

mkdir /usr/local/nagios/etc/servers

echo -e "\n1.\e[32mEdit the Nagios configuration file to include all “*.cfg” files inside the “/usr/local/nagios/etc/servers” directory.

Add or uncomment the following line 'vim /usr/local/nagios/etc/nagios.cfg (line 51)'

cfg_dir=/usr/local/nagios/etc/servers


2. Now configure the Nagios server to monitor the remote client machine, open the “commands.cfg” file…. 'vim /usr/local/nagios/etc/objects/commands.cfg'

Add the following Nagios command definition to the file in last.

# .check_nrpe. command definition
define command{
command_name check_nrpe
command_line /usr/lib64/nagios/plugins/check_nrpe -H \$HOSTADDRESS$ -t 30 -c \$ARG1$
}



3. Now create a client configuration file (/usr/local/nagios/etc/servers/server01.cfg) to define the host and service definitions of remote Linux host.

define host{

            use                     linux-server

            host_name               server01

            alias                   server01

            address                 $SERVERPRIVATE_IP

}

define hostgroup{

            hostgroup_name  linux-server

            alias           Linux Servers

            members         server01
}

define service{

            use                             local-service

            host_name                       server01

            service_description             SWAP Uasge

            check_command                   check_nrpe!check_swap

}

define service{

            use                             local-service

            host_name                       server01

            service_description             Root / Partition

            check_command                   check_nrpe!check_root

}

define service{

            use                             local-service

            host_name                       server01

            service_description             Current Users

            check_command                   check_nrpe!check_users

}

define service{

            use                             local-service

            host_name                       server01

            service_description             Total Processes

            check_command                   check_nrpe!check_total_procs

}

define service{

            use                             local-service

            host_name                       server01

            service_description             Current Load

            check_command                   check_nrpe!check_load

}


4. Now Verify Nagios for any errors.

/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

5. Now execute 'service nagios restart' to take changes effect.

6. Now check the Nagios GUI console to view the new services we added just now.
\e[0m\n
"
