# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

JAVA_HOME=/data/jdk1.8.0_161
MAVEN_HOME=/data/apache-maven-3.5.3
PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH

PATH=$PATH:$HOME/bin

export PATH MAVEN_HOME
