---
layout: post
title: "how to add NetworkManager plugin for VPN on CentOs 6"
tagline: "how to add NetworkManager plugin for VPN on CentOs 6"
description: ""
category: Linux 
tags: [CentOs, VPN]
---
{% include JB/setup %}

As default, the pptp plugins of network manager on centos 6 is not avaliable. This document describes the steps to add the NetworkManager plugin for pptp.

## enable epel resource

It is important to enable epel source before you install related packages.

	wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
	rpm -ivh epel-release-6-8.noarch.rpm 

## Insall related packages

	#yum -y install ppp
	#yum -y install pptp
	#yum -y install vpnc
	#yum -y install openvpn 
	#yum install pptp NetworkManager-pptp* -y
   	#yum install pptp NetworkManager-vpnc* -y
   	#yum install pptp NetworkManager-openvpn* -y
	#yum install NetworkManager* -y



