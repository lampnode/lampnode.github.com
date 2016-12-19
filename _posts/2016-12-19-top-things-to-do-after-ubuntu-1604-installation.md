---
layout: post
title: "Top Things to do after Ubuntu 16.04 Installation"
tagline: "Top Things to do after Ubuntu 16.04 Installation"
description: ""
category: 
tags: [ Ubuntu ]
---
{% include JB/setup %}

This technical article will cover about some import things we need to do after installing Ubuntu 16.04 LTS.

## Anti-virus

    sudo apt-get install clamav clamav-daemon

Now, we need to update the virus definition database or virus signature for Clam Anti Virus. 

    sudo freshclam

Now scan your system with Clam Anti Virus with below commands.

    sudo  clamscan -r /home

Here /home is a folder directory path name. Or

    sudo clamscan -r /

    sudo clamscan -r --bell -i /

Here bell parameter is used to make a sound if any infected files are found.


## Disable Guest Account

It is highly recommended that you disable the guest session login. Open the following file with your favorite file editor to edit the file:

    sudo vim /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf

Just add the following line in the file.

    allow-guest=false

Save & exit from the file /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf. Now restart the lightdm daemon with the below command.

    sudo /etc/init.d/lightdm restart

Now, logout from your Ubuntu Unity desktop interface and you will see that guest session / account is not there.

## Setup SSH

## Add openssh-server 

    sudo apt install openssh-server

## Change SSH Default Port

Open the following file with your favourite file editor and make the following changes

    sudo vim /etc/ssh/sshd_config

Look for the text “Port 22” and change the numeric value of 22 to your desired port. 

## Install fail2ban     

Open a Terminal and enter the following :

    sudo apt-get install fail2ban

After installation edit the configuration file /etc/fail2ban/jail.local  and create the filter rules as required. To edit the settings open a terminal window and enter:

    sudo vi /etc/fail2ban/jail.conf

Activate all the services you would like fail2ban to monitor by changing enabled = false to enabled = true

## Setup UFW

By default ufw is inactive status i.e. no firewall rules are configured and all traffic is allowed. To see status, enter:

    sudo ufw status

### Enable the UFW based firewall

Now you have default policy and ssh port allowed. It is safe to start enable the firewall, enter:

    sudo ufw enable

### Disable IPv6 support

If you use IPv6 on your VPS, you need to ensure that IPv6 support is enabled in UFW. To do so, open the config file in a text editor.

    sudo nano /etc/default/ufw

Once opened, make sure that IPV6 is set to "yes":

    IPV6=yes

### Disable IpV6

To disable ipv6, you have to open /etc/sysctl.conf using any text editor and insert the following lines at the end:

    net.ipv6.conf.all.disable_ipv6 = 1
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1

If ipv6 is still not disabled, then the problem is that sysctl.conf is still not activated. To solve this, open a terminal(Ctrl+Alt+T) and type the command,

    sudo sysctl -p


## Harden network with sysctl settings.

The /etc/sysctl.conf file contain all the sysctl settings.
Prevent source routing of incoming packets and log malformed IP's enter the following in a terminal window:

    sudo vi /etc/sysctl.conf

Edit the /etc/sysctl.conf file and un-comment or add the following lines :

    # IP Spoofing protection
    net.ipv4.conf.all.rp_filter = 1
    net.ipv4.conf.default.rp_filter = 1

    # Ignore ICMP broadcast requests
    net.ipv4.icmp_echo_ignore_broadcasts = 1

    # Disable source packet routing
    net.ipv4.conf.all.accept_source_route = 0
    net.ipv6.conf.all.accept_source_route = 0 
    net.ipv4.conf.default.accept_source_route = 0
    net.ipv6.conf.default.accept_source_route = 0

    # Ignore send redirects
    net.ipv4.conf.all.send_redirects = 0
    net.ipv4.conf.default.send_redirects = 0

    # Block SYN attacks
    net.ipv4.tcp_syncookies = 1
    net.ipv4.tcp_max_syn_backlog = 2048
    net.ipv4.tcp_synack_retries = 2
    net.ipv4.tcp_syn_retries = 5

    # Log Martians
    net.ipv4.conf.all.log_martians = 1
    net.ipv4.icmp_ignore_bogus_error_responses = 1

    # Ignore ICMP redirects
    net.ipv4.conf.all.accept_redirects = 0
    net.ipv6.conf.all.accept_redirects = 0
    net.ipv4.conf.default.accept_redirects = 0 
    net.ipv6.conf.default.accept_redirects = 0

    # Ignore Directed pings
    net.ipv4.icmp_echo_ignore_all = 1

To reload sysctl with the latest changes, enter:

    sudo sysctl -p

## Install JAVA

if you want to install Oracle Java then you need to add the JAVA PPA or you need to download the binary file from the Oracle website. To add the PPA and installing it, just follow the below commands:

    sudo apt-add-repository ppa:webupd8team/java 
    sudo apt-get update 
    sudo apt-get install oracle-java8-installer

##  Install Adobe Flash

To install Adobe Flash, just issue the below command.

    sudo apt-get install flashplugin-installer


## Options

### Install A Download Manager

To install uGet, just issue the below command or you can download from here as per your Linux distribution. Add the PPA repository first.

    sudo add-apt-repository ppa:plushuang-tw/uget-stable

And then as usual update your system and install the uGet package accordingly.

    sudo apt-get update
    sudo apt-get install uget

### Install A FTP Client

To install Filezilla,

    sudo apt-get install filezilla




