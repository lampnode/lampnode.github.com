---
layout: post
title: "Howto use snmpwalk on linux"
tagline: "Howto use snmpwalk on linux"
description: ""
category: Linux 
tags: [ Linux, SNMP, Ubuntu, CentOS]
---
{% include JB/setup %}

The purpose of this document is to guide you how to use snmpwolk on Ubuntu/CentOS.

snmpwalk is to good tool for test and manage SNMP service. You can easily list all information offered by 
SNMP.

## Installation

	CentOS: #yum install net-snmp-utils
	Ubuntu: $sudo apt-get install snmp

## Usages

### Context

The server installed SNMP service.

	IP Address: 192.168.0.10
	SNMP community String: public
	SNMP Port: 161( UDP )

### Samples

#### Sample A

To listing all OIDs using snmp version tow:

	$ snmpwalk -v 2c -c public 192.168.0.10

### Sample B:

To view specialed OID value we can append the OID SNMPv2-MIB::sysContact.0

	$ snmpwalk -v 2c -c public 192.168.0.10 SNMPv2-MIB::sysContact.0

### Sample C:

If you want to query snmp by version three, you need a account(snmpuser, pass):

	$ snmpwalk -v 3 -u snmpuser -a MD5 -A "pass" -l authNoPriv 60.215.129.82


