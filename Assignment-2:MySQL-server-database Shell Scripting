#UNDERDEVELOPMENT
#!/bin/bash
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
#CHECKING MYSQL-SERVER PACKAGES/DEPENDENCIES/INSTALLING
ee_echo "Checking if you have MYSQL installed or not"
dpkg -s mysql-server &>> /dev/null
if [ $? -ne 0 ]; then
	ee_fail "I need to install mysql-server, please wait..."
	/usr/bin/apt-get -y install mysql-server-5.5 mysql-server &>> /dev/null
	cat <<EOF | debconf-set-selections
	mysql-server-5.5 mysql-server/root_password password vipullinux
	mysql-server-5.5 mysql-server/root_password_again password vipullinux
	mysql-server-5.5 mysql-server/root_password seen true
	mysql-server-5.5 mysql-server/root_password_again seen true
EOF
#OR
#sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $1"
#sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $1"
OR
#package manager non-interactive mode

/usr/bin/apt-get -y install mysql-server-5.5 mysql-server &>> /dev/null
else
	ee_info "Dam!! MYSQL is already installed"
fi
#ASKING USER FOR DOMAIN NAME

read -p "Enter the domain name (eg.vipullinux.wordpress.com): " example_com 



#CREATING A NEW MYSQL-DATABASE FOR WORDPRESS,ADDRESS NAME MUST BE EXAMPLE_COM_DB
	db_name="_db"
	db_root_passwd="vipullinux"
mysql -u root -p$db_root_passwd << EOF
CREATE DATABASE ${example_com//./_}$db_name;
CREATE USER ${example_com//./_}@localhost;
SET PASSWORD FOR ${example_com//./_}@localhost=PASSWORD("password");
GRANT ALL PRIVILEGES ON ${example_com//./_}$db_name.* TO ${example_com//./_}@localhost IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
#exit;
EOF

	if [ $? -eq 0 ]; then
	ee_info "FINALLY YOUR DATABASE SETTING HAS BEEN SETUP"
	ee_info "Your database name assumed to be ${example_com//./_}$db_name "
 	ee_info "And Database password: password "
 else
	ee_fail "Ops!! something goes wrong, CONTACT sir.isac@gmail.com"
fi
#UNDERDEVELOPMENT

