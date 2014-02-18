---
layout: page
title: "CentOs安装后配置指南"
description: "CentOS Post Install Configuration"
---
{% include JB/setup %}

本文档主要用于安装好CentOS后，根据不同的需求，对服务器进行特定的配置。

## General Post Configuration

### Basic

1. Change the default root password to secure the system
2. Checking the status of SeLinux
3. [Setup the hostname](/linux/how-to-change-the-server-hostname-on-centos/)
4. [Howto configure sudo on CentOS](/linux/howto-configure-sudo-on-centos/)
5. [Harden SSH access](/linux/harden-ssh-access-on-centos/)
6. [Installing and Configuring Logwatch](/linux/how-to-installing-and-configuring-logwatch-on-linux/)

### Mail

- [Install and setup postifx](/Linux/how-to-setup-postfix-on-centos/)

### Networking

1. Check /etc/sysconfig/network-scripts/
2. Check /etc/sysconfig/network
3. Check /etc/resolv.conf, use google’s dns servers 8.8.8.8 and 8.8.4.4
4. Check /etc/hosts


### Security

- [Setup iptables](/linux/iptables-init-script/)
- [Install DenyHosts](/linux/how-to-install-denyhosts-on-linux/)
- [Install and setup ClamAV](/linux/how-to-setup-clamav-on-linux/)
- [Use rkhunter to protect the server](/linux/howto-use-rkhunter-to-protect-the-server/)
- [Use chkrootkit to protect the server](/linux/howto-use-chkrootkit-to-protect-the-server/)
- [PHP security configuration on CentOs](/php/php-security-configuration-on-server/)
- [Secure your Apache Configuration](/linux/secure-your-apache-configuration/)

## Optional configtuation

### For Web Server

- [Manually Installing Zend Server](/linux/manually-installing-zend-server/)
- [Install Apache PHP stack on CentOS 6](/linux/how-to-install--apache-php-stack-on-centos-6/)

### For data Server

- [Install MySQL server and post configuration](/mysql/how-to-install-mysql-on-linux/)

### For File Server

- [Install and configure vsftp](/mysql/how-to-install-and-configure-vsftp-on-centos/)

### For Subversion

- [Install and setup svn on CentOs](/msyql/howto-install-and-setup-svn-on-centos/)

## YUM

Clear yum packages

	yum clean all
