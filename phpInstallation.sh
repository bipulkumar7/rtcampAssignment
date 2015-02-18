#!/bin/bash
#defining TEMP
TEMP="`mktemp`"
#Defining echo function
#defining white color for Success.
function ee_info()
{
	echo $(tput setaf 7)$@$(tput sgr0)
}

#defining blue color for Running.
function ee_echo()
{
	echo $(tput setaf 4)$@$(tput sgr0)
}

#Defining red color for Error
function ee_fail()
{
	echo $(tput setaf 1)$@$(tput sgr0)
}
clear

#CHECKING PHP5 PACKAGES/DEPENDENCIES/INSTALLING
	ee_echo "CheckING if you have PHP installed or not"
	dpkg -s php5 &>> /dev/null && dpkg -s php5-fpm &>> /dev/null && dpkg -s php5-mysql &>> /dev/null

	if [ $? -ne 0 ]; then
	        ee_fail "I need to install php5 with it's dependencies, please wait.."
		 apt-get -y install php5 &>> /dev/null && apt-get -y install php5-fpm &>> /dev/null && apt-get -y install php5-mysql &>> /dev/null
	else
		ee_info "Dam !! you have PHP already installed"
	fi
