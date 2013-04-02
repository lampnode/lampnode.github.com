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
3. [Setup the hostname](/Linux/how-to-change-the-server-hostname-on-centos/)
4. [Harden SSH access](/Linux/harden-ssh-access-on-centos/)
5. [Installing and Configuring Logwatch](/Linux/how-to-installing-and-configuring-logwatch-on-linux/)

### Mail

- [Install and setup postifx](/Linux/how-to-setup-postfix-on-centos/)

### Networking

1. Check /etc/sysconfig/network-scripts/
2. Check /etc/sysconfig/network
3. Check /etc/resolv.conf, use google’s dns servers 8.8.8.8 and 8.8.4.4
4. Check /etc/hosts


### Security

- [Setup iptables](/Linux/iptables-init-script/)
- [Install DenyHosts](/Linux/how-to-install-denyhosts-on-linux/)
- [Install and setup ClamAV](/Linux/how-to-setup-clamav-on-linux/)
- [Use rkhunter to protect the server](/Linux/howto-use-rkhunter-to-protect-the-server/)
- [Use chkrootkit to protect the server](/Linux/howto-use-chkrootkit-to-protect-the-server/)

## Optional configtuation

### For Web Server

- [Manually Installing Zend Server](/Linux/manually-installing-zend-server/)

### For data Server

- [Install MySQL server and post configuration](/MySQL/how-to-install-mysql-on-linux/)

### For File Server

- [Install and configure vsftp](/Linux/how-to-install-and-configure-vsftp-on-centos/)

## YUM

Clear yum packages

	yum clean all
