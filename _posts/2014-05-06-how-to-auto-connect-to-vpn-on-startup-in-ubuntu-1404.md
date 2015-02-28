---
layout: post
title: "How to auto connect to VPN on startup in Ubuntu 14.04"
tagline: "How to auto connect to VPN on startup in Ubuntu 14.04"
description: ""
category: Linux
tags: [ Linux, Ubuntu, VPN ]
---
{% include JB/setup %}

The purpose of this document is to guide you to manage the VPN connection by command line script.
We will use a bash script to run at startup that checks to see if connected to VPN every 5s,
and if not it tries to connect. 


## Context

 - Network Manager is OK
 - Has a vpn account
 - Ubuntu 14.04
 - It is supposted that you will auto-login by the user named root

## Setup

### Step 1 Create VPN connection in Newtork Manager

Create your VPN connection in Network Manager like usual. Let us suppose that we has an vyprVPN account:

	Username: robert@example.com
	Password:123-456
	Gateway:hk1.vpn.goldenfrog.com

We build a vpn connection named VPN-HK1.

### Step 2 Modify the connnection configuration

Using Vim, edit /etc/NetworkManager/system-connections/VPN-HK1.

	$sudo vim /etc/NetworkManager/system-connections/VPN-HK1

#### Change password-flags=1 to password-flags=0

	 password-flags=0
	
#### Add the following at the bottom: 

        [vpn-secrets] 
	password=123-456

Be sure to change VPNName and VPNPassword to match your configuration. Example after modifyed:

	[connection]
	id=VPN-HK1
	uuid=7594c25b-b7fe-46ae-91ac-a523ec97e26e
	type=vpn
	autoconnect=false

	[vpn]
	service-type=org.freedesktop.NetworkManager.pptp
	gateway=hk1.vpn.goldenfrog.com
	require-mppe=yes
	user=robert@example.com
	lcp-echo-failure=5
	password-flags=0
	lcp-echo-interval=30

	[ipv4]
	method=auto

	[vpn-secrets]
	password=123-456

### Step 3 Get the VPN UUID

	$sudo nmcli con 

The UUID by nmcli query and in configuration file is same. 

	NAME                      UUID                                   TYPE              TIMESTAMP-REAL                    
	VPN-HK1                   7594c25b-b7fe-46ae-91ac-a523ec97e26e   vpn               ......
	Wired connection 1        2ab388f8-8170-4b9e-951b-893644b0ffd8   802-3-ethernet    ......

### Step 4  Create bash scrpts

Once you have the UUID, and you've edited your VPN's config file, you need to create a script named autovpn.sh 
and save it in /root/vpn by doing the following:

	$sudo mkdir /root/vpn
	$sudo vim /root/vpn/autovpn.sh

Paste the following and be sure to replace the VPN-PARAM with the UUID for your VPN:

{% highlight java %}
#!/bin/bash

VPN_UUID="VPN-PARAM";
SLEEP_TIME=5;

NMCLI="/usr/bin/nmcli";
GREP="/bin/grep";
AWK="/usr/bin/awk";
SLEEP="/bin/sleep";
ECHO="/bin/echo";

while [ "true" ]
do
    VPNCON=$($NMCLI con status uuid "$VPN_UUID" | $GREP VPN.VPN-STATE | $AWK '{print $2}');

    if [[ $VPNCON != "5" ]]; then
        $SLEEP 1;
        $NMCLI con up uuid "$VPN_UUID";
    fi

    $SLEEP $SLEEP_TIME;
done
{% endhighlight %}

Then, change the script user permission(According to your auto-login user):
  
	$sudo chown root:root /root/vpn/autovpn.sh


### Step 5 Enable Auto connect

	$sudo vim /etc/profile

Add the following to the end of this file( Run command in background, discard stdout and stderr ):

	/bin/bash /root/vpn/autovpn.sh > /dev/null 2>&1 &

if you want to debug this script, you should redirect stdout and stderr to log file:

	/bin/bash /root/vpn/autovpn.sh >> /var/log/vpnLog 2>&1 &

Then,

	$chmod 666 /var/log/vpnLog


Reboot the computer, the script will launch and automatically check if it's connected to VPN every 5 seconds, 
and if it isn't will try to establish the connection! 

