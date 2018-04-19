#!/bin/bash

askuser()
{
echo -e "Warning: \e[31mThis will override your existing paths\e[0m"
echo -e "\nWhich path would you like to setup?\n1.Java path\n2.Maven path\n3.Both\n4.None\n"

read -p "Press option : " ans
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

export PATH JAVA_HOME MAVEN_HOME
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
JAVA_HOME=$jdk_path
PATH=$jdk_path/bin:\$PATH

PATH=\$PATH:\$HOME/bin

export PATH JAVA_HOME
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
MAVEN_HOME=$mvn_path
PATH=$mvn_path/bin:\$PATH

PATH=\$PATH:\$HOME/bin

export PATH MAVEN_HOME
" > ~/.bash_profile
}

source_path()
{
source ~/.bash_profile
echo "Done!"
}

askuser


case $ans in
1 )
read -p "Enter Java install path.. i.e. /data/jdk1.8 --> " jdk_path
java_path
echo -e "\nLogout and Login again or execute 'source ~/.bash_profile' command once.\n"
;;

2 )
read -p "Enter Maven install path.. i.e. /data/maven --> " mvn_path
maven_path
echo -e "\nLogout and Login again or execute 'source ~/.bash_profile' command once.\n"
;;

3 )
read -p "Enter Java install path.. i.e. /data/jdk1.8 --> " jdk_path
read -p "Enter Maven install path.. i.e. /data/maven --> " mvn_path
java_path
maven_path
echo -e "\nLogout and Login again or execute 'source ~/.bash_profile' command once.\n"
;;

4 )
echo -e "\eselected None"
exit 1
;;

* )
askuser
;;
esac 
