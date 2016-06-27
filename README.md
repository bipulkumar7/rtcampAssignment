RTcampAssignment / Installing Wordpress on Nginx Server with MySQL server and PHP-5.
==================

## Introduction

**This is a assignment for rtcamp Linux/Server/Network Admin.**
**This Script will install Nginx, MySQL-Server and PHP5 on your Ubuntu System and also configure latest Wordpress.** 


![Logo](http://i59.tinypic.com/ogevzb.png)


# Prerequisite.

**If you are running any other webserver apart Nginx. Then Please remove it.**
```
sudo apt-get remove --purge <!Nginx||WebServerPackageName>
sudo apt-get autoremove
sudo apt-get autoclean
```
**Mysql-server must not installed for old RTcamAssign2.sh**
```
sudo apt-get remove --purge mysql-server 
sudo apt-get autoremove
sudo apt-get autoclean
```

# Quick Start Installation.
```bash
git https://github.com/vipullinux/rtcampAssignment.git		              #To clone the code 
chmod +x RTcamAssign2.sh |$ chmod +x RTCAMP                                              #Set Executable Permission
sudo ./RTcamAssign2.sh  | $ sudo ./RTCAMP                                              #To run the script
```

## Compatibiltiy for old script RTcamAssign2.sh 				Compatibiltiy for RTCAMP
			
**Ubuntu 14.04 (Trusty) Server.**						Testing Ubuntu Ubuntu 16.04 LTS
										Code name xenial
**Ubuntu 14.04 (Trusty) Desktop.**						Feel free to submitte the error !
								
# Contributor									# Contributor
* [Bipul](https://wiki.ubuntu.com/Bipul)					 Bipul kumar

* [Gaurav Ashtikar](https://github.com/gau1991)
