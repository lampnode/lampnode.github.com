---
layout: post
title: "Minimal Services on CentOS"
description: ""
category: Linux
tags: [CentOs]
---
{% include JB/setup %}

This will improve the performance of a system by disabling unneeded services. Another benefit is reduced hardware requirements for your server.

## Methodology of Minimal Services

- Perform minimal OS installations
- Install additional software as needed after installation
- Minimal installations reduce the number of packages requiring updates
- No graphical environment needed on servers
- Limiting the Number of Running Services
- List of system services

Here is a list of services(daemons) to help you decide what to axe. Here is another list.
After performing a minimal installation, the machine reboots. When you login disable as many services as possible with the following commands:

	chkconfig anacron off
	chkconfig apmd off
	chkconfig atd off
	chkconfig autofs off
	chkconfig cpuspeed off
	chkconfig cups off
	chkconfig cups-config-daemon off
	chkconfig gpm off
	chkconfig isdn off
	chkconfig netfs off
	chkconfig nfslock off
	chkconfig openibd off
	chkconfig pcmcia off
	chkconfig portmap off
	chkconfig rawdevices off
	chkconfig readahead_early off
	chkconfig rpcgssd off
	chkconfig rpcidmapd off
	chkconfig smartd off
	chkconfig xfs off
	chkconfig ip6tables off
	chkconfig avahi-daemon off
	chkconfig firstboot off
	chkconfig yum-updatesd off 
	chkconfig sendmail off
	chkconfig mcstrans off
	chkconfig pcscd off
	chkconfig bluetooth off
	chkconfig hidd off

The next group of services is more useful to servers in some circumstances.
- xinetd may be needed for some servers
- acpid needed for power button to shut down server gently
- microcode_ctl not needed on AMD machines
- haldaem and messagebus support for plug and play devices
- mdmonitor not needed unless running software RAID

Evaluate their worth even more closely before disabling them.
 
	chkconfig xinetd off
	chkconfig acpid off
	chkconfig microcode_ctl off
	chkconfig haldaemon off
	chkconfig messagebus off
	chkconfig mdmonitor off

## Virtual Terminals

You may also minimize on virtual terminals. The default is six virtual terminals. You can probably do with two.
To disable them, edit the /etc/inittab file and comment out the ones that you do not want running like this:
 
	# Run gettys in standard runlevels
	1:2345:respawn:/sbin/mingetty tty1
	2:2345:respawn:/sbin/mingetty tty2
	#3:2345:respawn:/sbin/mingetty tty3
	#4:2345:respawn:/sbin/mingetty tty4
	#5:2345:respawn:/sbin/mingetty tty5
	#6:2345:respawn:/sbin/mingetty tty6
 
## Updating and Rebooting

On any new install, it is a good idea to run "yum update" and then reboot the machine to apply the latest security and software updates.
It is a good idea to reboot after the update to make sure that the system comes up properly.
 
