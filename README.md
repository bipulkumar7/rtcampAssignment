RTcampAssignment
==================

## Introduction

**This is a assignment for rtcamp Linux/Server/Network Admin. Which is right now underdevelopment phase.**
**This Script will install Nginx, MySQL-Server and PHP5 on your Ubuntu System and also configure latest Wordpress.** 


![Logo](http://i59.tinypic.com/ogevzb.png)


# Prerequisite.

**If you are running any other webserver apart Nginx. Then Please remove it.**
```
sudo apt-get remove --purge <!Nginx||WebServerPackageName>
sudo apt-get autoremove
sudo apt-get autoclean
```
**Mysql-server must not installed**
```
sudo apt-get remove --purge mysql-server
sudo apt-get autoremove
sudo apt-get autoclean
```

# Quick Start Installation.
```bash
git https://github.com/vipullinux/rtcampAssignment.git		              #To clone the code 
chmod +x RTcamAssign2.sh                                              #Set Executable Permission
sudo ./RTcamAssign2.sh                                                #To run the script
```

## Compatibiltiy

**Ubuntu 14.04 (Trusty) Server.**

**Ubuntu 14.04 (Trusty) Desktop.**

# Contributor
[Bipul](https://wiki.ubuntu.com/Bipul)
[Gaurav Ashtikar](https://github.com/gau1991)
