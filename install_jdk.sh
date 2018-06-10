#!/bin/bash
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2F%www.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm"

rpm -ivh jdk-8u131-linux-x64.rpm
