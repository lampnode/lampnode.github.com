---
layout: post
title: "Howto install and setup Cacti on Ubuntu 14.04"
tagline: "Howto install and setup Cacti on Ubuntu 14.04"
description: ""
category: Linux 
tags: [ Linux, Ubuntu, SNMP ]
---
{% include JB/setup %}

The purpose of this section is to guide you how to install and setup Cacti on Ubuntu 14.04.



## Installation
Cacti and all of its dependencies can by installed through apt-get on Ubuntu 12.04 or later. 

### Lamp-server

If you have not set up lamp server, you need install them:

	sudo apt-get install lamp-server^

### RDDTool

	$sudo apt-get -y install rrdtool

### SNMP and mysql

The snmpd service should be installed and configured on the servers you would like to graph. In this guide, we will only be graphing 
the localhost where cacti is installed.

	$sudo apt-get -y install snmp snmpd

### Cacti and spine

	$sudo apt-get -y install cacti

We will also install cacti-spine, which is a faster way to poll servers for information than the default php script.

	$sudo apt-get -y install cacti-spine


You can access http://ip/cacti after installation, the first login, 
the default account and password are "admin".

## Setup

### SNMPD Configuration

The snmpd daemon must be configured to work with Cacti. The configuration file is located at "/etc/snmp/snmpd.conf". 
Make sure you are editing the snmpd.conf file and not the snmp.conf file.

	$sudo vim /etc/snmp/snmpd.conf
	
#### Edit the Agent Behavior

Comment out the line for "connections from the local system only" and uncomment the line for 
listening for "connections on all interfaces".

	#  Listen for connections from the local system only
	#agentAddress  udp:127.0.0.1:161
	#  Listen for connections on all interfaces (both IPv4 *and* IPv6)
	agentAddress udp:161,udp6:[::1]:161

#### ACCESS CONTROL

Uncomment and edit the line for "rocommunity secret 10.0.0.0/16". We will be changing this to reference our specific Cacti server(192.168.0.16). 
	
	rocommunity secret 192.168.0.16

#### SYSTEM INFORMATION

You can add the physical location of your server and a contact email. These may be helpful for distinguishing machines if you are monitoring a large number of cloud servers.

	sysLocation    Your System Location
	sysContact     contact@email.com	

After you are done with your modifications, save the file, exit and restart the snmpd service.
	
	$sudo service snmpd restart

### Web configuration

#### SNMP Version

In the General tab, we want to change some parameters. Change these settings to match what is shown here. Click "Save" when finished.

	SNMP Version: Version 2
	SNMP Community: secret	

#### Setup spine

In Console->Cacti Settings->Poller, Change the poller Type from comd.php to spine.

#### Rebuild Poller Cache

Whenever the Poller Interval is changed, the cache must be emptied. To do this, click "System Utilities" under 
the Utilities heading on the left-hand navigation panel.Click on "Rebuild Poller Cache" to empty the cache.

### MIBs

For Ubuntu 12.04 or later, the default MIBs is not enabled, you will need to install MIBs.	

	$snmpwalk -On -c public -v 2c localhost HOST-RESOURCES-MIB::hrSystemProcesses.0
	MIB search path: /home/edwin/.snmp/mibs:/usr/share/snmp/mibs:/usr/share/snmp/mibs/iana:/usr/share/snmp/mibs/ietf:/usr/share/mibs/site:/usr/share/snmp/mibs:/usr/share/mibs/iana:/usr/share/mibs/ietf:/usr/share/mibs/netsnmp
	Cannot find module (HOST-RESOURCES-MIB): At line 1 in (none)
	HOST-RESOURCES-MIB::hrSystemProcesses.0: Unknown Object Identifier

So, run the following:

	$sudo apt-get install snmp-mibs-downloader

Edit the /etc/snmp/snmp.conf (Not snmpd.conf), Comment out the following line:

	#mibs :

Reboot snmp and test it:

	$sudo /etc/init.d/snmpd restart
	$snmpwalk -On -c public -v 2c localhost HOST-RESOURCES-MIB::hrSystemProcesses.0
	.1.3.6.1.2.1.25.1.6.0 = Gauge32: 130
