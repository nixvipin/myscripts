#!/bin/bash
systemctl stop httpd puppet puppetserver mysqld nagios kibana
pkill -9 java
