#!/bin/bash

cd /data
wget http://redrockdigimark.com/apachemirror/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz
tar -xzf apache-maven-3.5.3-bin.tar.gz
mv apache-maven-3.5.3 maven
rm apache-maven-3.5.3-bin.tar.gz
