#!/bin/bash
#This program is free software: you can redistribute it and/or modify it
#under the terms of the GNU General Public License as published by the
#Free Software Foundation, either version 2 of the License, or (at your option)
#any later version.
#
#This program is distributed in the hope that it will be useful, but WITHOUT ANY
#WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#See the GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License along with this program.
#If not, see http://www.gnu.org/licenses/.
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
			ee_echo "The Magic  begins"
#Checking User Authentication
	if [[ $EUID -eq 0 ]]; then
		ee_info "Thank you for giving me a SUDO user privilege"
	else
		ee_fail "I need a SUDO privilage !! :( "
		ee_fail "Use: sudo bash Ipmnw.sh"
	exit 1
	fi

ee_info "OH!! You have passed the Authentication part."

#UPDATING UBUNTU
ee_echo "Let me Update your System. Please wait..."
	apt-get update &>> /dev/null
ee_info "Finally this system is ready for installing PHP,MYSQL,NGINX $ WORDPRESS"
#CHECKING DPKG PACKAGE IS INSTALLED OR NOT
		ee_echo "Checking whether you have dpkg installed or not"
	if [[ ! -x /usr/bin/dpkg ]]; then
		ee_echo "Oh noo!! you don't have dpkg package. Let me install it for you, please wait.."
	apt-get -y install dpkg &>> /dev/null
	else
		ee_info "OH!! you already have dpkg installed"	
fi
#CHEKING WGET PACKAGE IS INSTALLED OR NOT
		ee_echo "Checking whether you have wget package is installed or not"
	if [[ ! -x /usr/bin/wget ]]; then
		ee_fail "SORRY! You don't have wget package installed."
		ee_echo "Let me install the wget packages on your system."
	apt-get -y install wget &>> /dev/null
	else
		ee_info "OH!! You already have wget installed."
	fi
#CHEKING TAR PACKAGE IS INSTALLED OR NOT
		ee_echo "Checking whether you have tar packages is installed or not."
	if [[ ! -x /usr/bin/tar ]]; then
		ee_fail "SORRY! You don't have tar package installed."
		ee_echo "Let me install the tar packages on your system."
	apt-get -y install tar &>> /dev/null
	else
		ee_info "OH!! You already have tar installed."
	fi
#CHECKING PHP5 PACKAGES/DEPENDENCIES/INSTALLING
		ee_echo "Checking whether you have PHP and it's dependencies installed or not"
	dpkg -s php5 &>> /dev/null && dpkg -s php5-fpm &>> /dev/null dpkg -s php5-mysql &>> /dev/null
	if [ $? -ne 0 ]; then
	        ee_fail "I need to install php5 with it's dependencies, please wait.."
	apt-get -y install php5 &>> /dev/null && apt-get -y install php5-fpm &>> /dev/null && apt-get -y install php5-mysql &>> /dev/null
		if [ $? -ne 0 ]; then
		ee_fail "Something is wrong in PHP configuration please check the dpendencies"
		fi
	else
		ee_info "OH!! you have PHP and it's dependencies already installed"
	fi
#CHECKING MYSQL-SERVER PACKAGES/DEPENDENCIES/INSTALLING
		ee_echo "Checking whether you have MYSQL installed or not"
	dpkg -s mysql-server &>> /dev/null
	if [ $? -ne 0 ]; then
		ee_fail "I need to install mysql-server, please wait..."
	#GENERATING MY-SQL-ROOT PASSWORD
	password=$(date | md5sum | head -c 9)
	echo mysql-server mysql-server/root_password password $password | sudo debconf-set-selections
	echo mysql-server mysql-server/root_password_again password $password | sudo debconf-set-selections
	apt-get install -y mysql-server &>> /dev/null
		ee_fail " Your MySQL PASSWORD is = $password "
	else
		ee_info "Dam!! MYSQL is already installed"
	fi
#CHECKING NGINX PACKAGES/DEPENDENCIES/INSTALLATION
		ee_echo "Checking whether you have NGINX installed or not"
	dpkg -s nginx &>> /dev/null
	if [ $? -ne 0 ]; then
		ee_fail "I need to install nginx ,please wait.."
		apt-get install -y nginx &>> /dev/null
	else
		ee_info " OH!! Nginx is already installed"
	fi
#ASKING USER FOR DOMAIN NAME
	read -p "Enter the domain name (eg.vipullinux.wordpress.com): " example_com
#CHECKING THE DOMAIN IS ALREADY BEEN PRESENT OR NOT 
	grep $example_com /etc/hosts &>> /dev/null
	if [ $? -eq 0 ]; then
	ee_fail "SORRY This Domain name is already been taken"
	read -p "Please enter the domain name again: " example_com 
	fi
	ee_info "So the final domain name is $example_com "	
	
	if [ ! -d "/var/www/$example_com" ]; then
		mkdir -p /var/www/$example_com
	fi
	echo "127.0.0.1 $example_com" | sudo tee -a /etc/hosts &>> /dev/null 
#CREATING NGINX CONFIG FILES FOR EXAMPLE.COM
	sudo tee /etc/nginx/sites-available/$example_com << EOF
server {
        listen   80;


        root /var/www/$example_com;
        index index.php index.html index.htm;

        server_name $example_com;

        location / {
                try_files \$uri \$uri/ /index.php?q=\$uri&\$args;
        }

        error_page 404 /404.html;

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
              root /usr/share/nginx/www;
        }

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        location ~ \.php\$ {
                try_files \$uri =404;
                #fastcgi_pass 127.0.0.1:9000;
                # With php5-fpm:
                fastcgi_pass unix:/var/run/php5-fpm.sock;
                fastcgi_index index.php;
                include fastcgi_params;
                 }
   }
EOF
	ln -sF /etc/nginx/sites-available/$example_com /etc/nginx/sites-enabled/$example_com
	rm -rf /etc/nginx/sites-available/default &>> /dev/null
	service nginx restart >> $TEMP 2>&1
	if [ $? -eq 0 ]; then
		ee_info "Nginx is successfull installed"
	else
		ee_fail "ERROR! Use:>>>sudo nginx -t<<<< in Terminal"
	fi	
	service php5-fpm restart >> $TEMP 2>&1
	ee_fail "CHILL !! EVERY THINGS IS ALL RIGHT, IT WAS JUST A CONFIG FILE,I DON'T KNOW HOW TO PUT THIS IN BLACKHOLE[/DEV/NULL]"
#DOWNLOADING LATEST VERSION FROM WORDPRESS.ORG THEN UNZIP IT LOCALLY IN EXAMPLE COM/ DOCUMENT ROOM.
		ee_echo " I am going to download wordpress from http://wordpress.org/latest.tar.gip please wait.."
	 cd ~ && wget http://wordpress.org/latest.tar.gz >> $TEMP 2>&1
        if [ $? -eq 0 ]; then
	 	ee_info "Done!! latest wordpress has been downloaded Successfully"
	else
		ee_fail "ERROR:Failed to get latest tar file, Please check log files $TEMP" 1>&2
	fi
#EXTRACTING THE LATEST TAR FILES
		ee_echo "Let me extract the tar file"
	cd ~ && tar xzvf latest.tar.gz &>> /dev/null && mv wordpress $example_com &>> /dev/null
	if [ $? -eq 0 ]; then
		ee_info "Your file has been rename and extracted Successfully"
	cp -rf $example_com /var/www/
	fi 
	rm -rf latest.tar.gz &>> /dev/null
#CREATING A NEW MYSQL-DATABASE FOR WORDPRESS,ADDRESS NAME MUST BE EXAMPLE_COM_DB
	db_name="_db"
	db_root_passwd="$password"
	echo "$db_root_passwd"
	mysql -u root -p$db_root_passwd << EOF
	CREATE DATABASE ${example_com//./_}$db_name;
	CREATE USER ${example_com//./_}@localhost;
	SET PASSWORD FOR ${example_com//./_}@localhost=PASSWORD("$password");
	GRANT ALL PRIVILEGES ON ${example_com//./_}$db_name.* TO ${example_com//./_}@localhost IDENTIFIED BY '$password';
	FLUSH PRIVILEGES;
	#exit;
EOF
	if [ $? -eq 0 ]; then
		ee_info "FINALLY YOUR DATABASE SETTING HAS BEEN SETUP"
		ee_info "Your database name assumed to be = ${example_com//./_}$db_name "
 		ee_info "And Database password = $password"
		ee_fail "Kindly please note it down your MYSQL-ROOT password = $db_root_passwd "
	else
		ee_fail "Ops!! something goes wrong, CONTACT sir.isac@gmail.com"
	fi
#CREATING WP-CONFIG.PHP WITH PROPER DB CONFIGURATION.
	cp /var/www/$example_com/wp-config-sample.php /var/www/$example_com/wp-config.php
	sed -i "s/\(.*'DB_NAME',\)\(.*\)/\1'${example_com//./_}$db_name');/" /var/www/$example_com/wp-config.php
	sed -i "s/\(.*'DB_USER',\)\(.*\)/\1'${example_com//./_}');/" /var/www/$example_com/wp-config.php
	sed -i "s/\(.*'DB_PASSWORD',\)\(.*\)/\1'$password');/" /var/www/$example_com/wp-config.php
#ASSIGNING PERMISSION TO DIRECTORY
	chown www-data:www-data * -R /var/www/
	chmod -R 755 /var/www
	service nginx restart >> $TEMP 2>&1
	if [ $? -eq 0 ]; then
		ee_info "Nginx is successfull installed"
	else
		ee_fail "ERROR! Use:>>>sudo nginx -t<<<< in Terminal"
	fi	
	service php5-fpm restart >> $TEMP 2>&1

ee_info "Kindly open your browser with following link,and do rest of the configuration part  http://$example_com "
