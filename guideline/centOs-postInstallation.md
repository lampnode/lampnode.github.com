---
layout: page
title: "CentOS Post Install Configuration Guide"
description: "CentOS Post Install Configuration"
---
{% include JB/setup %}

The purpose of this document is to guide you how to post confiuration for CentOS, depending on the needs of the server-specific configuration.

## General Post Configuration

### Basic

1. Change the default root password to secure the system
2. Checking the status of SeLinux
3. [Setup the hostname](/linux/how-to-change-the-server-hostname-on-centos.html)
4. [Howto configure sudo on CentOS](/linux/howto-configure-sudo-on-centos.html)
5. [Harden SSH access](/linux/harden-ssh-access-on-centos.html)
6. [Installing and Configuring Logwatch](/linux/how-to-installing-and-configuring-logwatch-on-linux.html)

### Mail

- [Install and setup postifx](/linux/how-to-setup-postfix-on-centos.html)

### Networking

1. Check /etc/sysconfig/network-scripts/
2. Check /etc/sysconfig/network
3. Check /etc/resolv.conf, use google’s dns servers 8.8.8.8 and 8.8.4.4
4. Check /etc/hosts


### Security

- [Setup iptables](/linux/iptables-init-script.html)
- [Install DenyHosts](/linux/how-to-install-denyhosts-on-linux.html)
- [Install and setup ClamAV](/linux/how-to-setup-clamav-on-linux.html)
- [Use rkhunter to protect the server](/linux/howto-use-rkhunter-to-protect-the-server.html)
- [Use chkrootkit to protect the server](/linux/howto-use-chkrootkit-to-protect-the-server.html)
- [PHP security configuration on CentOs](/php/php-security-configuration-on-server.html)
- [Secure your Apache Configuration](/linux/secure-your-apache-configuration.html)

## Optional configtuation

### For Web Server

- [Manually Installing Zend Server](/linux/manually-installing-zend-server.html)
- [Install Apache PHP stack on CentOS 6](/linux/how-to-install--apache-php-stack-on-centos-6.html)

### For data Server

- [Install MySQL server and post configuration](/mysql/how-to-install-mysql-on-linux.html)

### For File Server

- [Install and configure vsftp](/linux/how-to-install-and-configure-vsftp-on-centos.html)

### For Subversion

- [Install and setup svn on CentOs](/linux/howto-install-and-setup-svn-on-centos.html)

## YUM

Clear yum packages

	yum clean all
