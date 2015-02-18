#UNDERDEVELOPMENT
!/bin/bash
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


#CHECKING NGINX PACKAGES/DEPENDENCIES/INSTALLATION
		ee_echo "Checking if you have NGINX installed or not"
		dpkg -s nginx &>> /dev/null
	if [ $? -ne 0 ]; then
		ee_fail "I need to install nginx ,please wait.."
		apt-get install -y nginx &>> /dev/null
	else
		ee_info " Dam!! Nginx is already installed"
	fi
		ee_info "I have finished my first level"

#ASKING USER FOR DOMAIN NAME

read -p "Enter the domain name (eg.vipullinux.wordpress.com): " example_com 

	if [ ! -d "/var/www/$example_com" ]; then
		mkdir -p /var/www/$example_com
	fi
echo "127.0.0.1 $example_com" | sudo tee -a /etc/hosts &>> /dev/null 

#CREATING NGINX CONFIG FILES FOR EXAMPLE.COM
sudo tee /etc/nginx/sites-available/$example_com << EOF
server {
        listen   80;


        root /var/www;
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

#sed -i "s/\(.*server_name\)\(.*\)/\1 ${example_com};/" /etc/nginx/sites-available/$example_com
ln -sF /etc/nginx/sites-available/$example_com /etc/nginx/sites-enabled/$example_com
service nginx restart >> $TEMP 2>&1
service php5-fpm restart >> $TEMP 2>&1
ee_fail "CHILL !! EVERY THINGS IS ALL RIGHT, IT WAS JUST A CONFIG FILE,I DON'T KNOW HOW TO PUT THIS IN BLACKHOLE[/DEV/NULL]"
#UNDERDEVELOPMENT
