---
layout: post
title: "Howto setup NET SNMP on CentOS 6"
tagline: "Howto setup NET SNMP on CentOS 6"
description: ""
category: Linux 
tags: [Linux, CentOS, SNMP ]
---
{% include JB/setup %}

The purpose of this document is guide you how to install and setup snmp(snmpwalk) on CentOS 6.

## System Requirement

	OS: CentOs 5.3 or later

## Installation

	$ yum install net-snmp net-snmp-devel net-snmp-utils

## Setup

### SNMP Versions

#### SNMPv2(v2c)

We need to create a read-only account(lampnode), also known as read-only community:

	$service snmpd stop
	$vim /etc/snmp/snmpd.conf

Add the following line to the end of this file:

	rocommunity lampnode 192.168.0.16
	rocommunity lampnode 192.168.0.17

NOTE: 

 - Use different community or authentication strings(Default is public), if possible.
 - The "rocommunity" means this is a read-only access, remote accessing can only obtain 
information from your server, and can not make any settings on the server.
 - The "lampnode" is equivalent to the accessing password


#### SNMPv3
The version 3 of SNMP (SNMP v3) is used to provide a secured environment in managing the systems and networks. The SNMPv3 Agent supports the following set of security levels as defined in the USM MIB (RFC 2574) :

 - noAuthnoPriv - Communication without authentication and privacy.
 - authNoPriv - Communication with authentication and without privacy. The protocols used for Authentication are MD5 and SHA (Secure Hash Algorithm).
 - authPriv - Communication with authentication and privacy. The protocols used for Authentication are MD5 and SHA ; and for Privacy, DES (Data Encryption Standard) and AES (Advanced Encryption Standard) protocols can be used. For Privacy Support, you have to install some third-party privacy packages. Details about installation is dealt with in the topic "Privacy Support".

By default, the SNMPv3 Agent provides support for three level of users, namely:

- noAuthUser - Users with security level noAuthnoPriv and context name as noAuth.
- authUser - Users with security level authNoPriv and context name as auth.
- privUser - Users with security level authPriv and context name as priv.

We will create a account(snmpuser, pass), and the password encryption method is MD5.

	$service snmpd stop
	$net-snmp-config --create-snmpv3-user -ro -A pass -a MD5 snmpuser

NOTE: Before you use net-snmp-config, you should stop SNMP service. After adding the new user entry to the Tables, 
The v3 agent can now be accessed by the new user.

Disable SNMP v1 and SNMP v2c:commented out com2sec and group, in e.g:

        #com2sec notConfigUser  default       public

        #group   notConfigGroup v1           notConfigUser
        #group   notConfigGroup v2c           notConfigUser

### View and access

#### Add a new "view" named all after systemview

	view    systemview    included   .1.3.6.1.2.1.1
	view    systemview    included   .1.3.6.1.2.1.25.1.1	
	view    all           included   .1      80

NOTE: 80 is a mask. The "mask" field is used to control the elements of the OID sub-tree that should be considered as relevant 
when determining the view in which an OID is in. Normally, the OID is included on whole, so you will need a mask with as many bits set as there are in the OID elements.

#### Modify the access

Change the line:	

	access  notConfigGroup ""      any       noauth    exact  systemview  none none

To:

	access  notConfigGroup ""      any       noauth    exact  all  none none

#### Add the syslocation at the end of this file

	syslocation  "Server -- Lampnode office"
	syscontact   robert@lampnode.com

#### Enable snmpd 	

Then, you should start the SNMP, and configurate this service.

        $service snmpd start
        $chkconfig snmpd on

## Setup Iptable

        iptables -A INPUT -i eth0 -p udp -s 192.168.0.3 --dport 161 -j ACCEPT

## Test it

### For SNMPv2

	$snmpwalk -c lampnode -v 2c 127.0.0.1

### For SNMPv3
User Name "snmpuser", Security level "authNoPriv" with MD5 Auth protocol for localhost(127.0.0.1):

        $snmpwalk -v 3 -u snmpuser -a MD5 -A "pass" -l authNoPriv 127.0.0.1	

NOTE: Please refer to [snmpwalk simple guide](/linux/howto-use-snmpwalk-on-linux/) for further information.
