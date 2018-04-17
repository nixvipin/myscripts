#!/bin/bash


read -p "Would you like to setup Java & Maven  path.. (y/n)" ans

if [ $ans = y ]
then
  if [ -d /data/jdk1.8 ]
  then
  echo -e "Setting up the path.. \e"

   echo "

# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs
JAVA_HOME=/data/jdk1.8
MAVEN_HOME=/data/maven
PATH=\$JAVA_HOME/bin:\$MAVEN_HOME/bin:\$PATH

PATH=\$PATH:\$HOME/bin

export PATH
" > ~/tmp_bash_profile

   else
   echo "Directory not found.. Install Java(/data/jdk1.8) or  maven(/data/maven) & try it again"
   fi
else
echo "ok go home.. "
fi
