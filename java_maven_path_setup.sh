#!/bin/bash

askuser()
{
echo -e "\e Warning:[101mThis will override your existing paths"echo -e "\e[31mHello World\e[0m"

read -p "\e Which path would you like to setup?\e1.Java path\e2.Maven path\e3.Both\e4.None\e\ePress option : " ans
}

both_path()
{
echo "# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs
JAVA_HOME=$java_path
MAVEN_HOME=/data/maven
PATH=\$JAVA_HOME/bin:\$MAVEN_HOME/bin:\$PATH

PATH=\$PATH:\$HOME/bin

export PATH
" > ~/.bash_profile
}

java_path()
{
echo "# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs
JAVA_HOME=$java_path
PATH=\$JAVA_HOME/bin:\$PATH

PATH=\$PATH:\$HOME/bin

export PATH
" > ~/.bash_profile
}

maven_path()
{
echo "# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs
MAVEN_HOME=/data/maven
PATH=\$MAVEN_HOME/bin:\$PATH

PATH=\$PATH:\$HOME/bin

export PATH
" > ~/.bash_profile
}

askuser

source_path(){
source ~/.bash_profile
}

case $ans in
1)
java_path
source_path
;;

2)
maven_path
source_path
;;
3)
java_path
source_path
;;
4)
echo -e "\eselected None"
;;
*)
askuser
;;
esac 
