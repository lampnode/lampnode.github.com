---
layout: post
title: "Howto Find Out Hardware Details on Linux"
tagline: "Howto Find Out Hardware Details on Linux"
description: ""
category: Linux 
tags: [ Linux ]
---
{% include JB/setup %}

The purpose of this document is to guide you how to find out the hardware information on Linux.


## Installation

You should install ralated command-line tools(e.g. lshw ) firstly.

### lshw

lshw is a command-line utility for showing detailed hardware specification of a Linux machine.

To install lshw on ubuntu:

	$sudo apt-get install lshw

To install lshw on CentOS:

	#yum install lshw

## Usage

### Check the disk hardware information

To display all disks and storage controllers in the system, enter:

	# lshw -class disk

Sample outputs:

{% highlight bash %}
  *-disk:0 UNCLAIMED      
       description: ATA Disk
       product: ST31000524AS
       vendor: Seagate
       physical id: 0.0.0
       bus info: scsi@0:0.0.0
       version: JC47
       serial: 6VPEE0JT
       capacity: 931GiB (1TB)
       capabilities: 15000rpm
       configuration: ansiversion=5
  *-disk:1 UNCLAIMED
       description: ATA Disk
       product: ST31000524AS
       vendor: Seagate
       physical id: 0.1.0
       bus info: scsi@0:0.1.0
       version: JC47
       serial: 6VPEEFL4
       capacity: 931GiB (1TB)
       capabilities: 15000rpm
       configuration: ansiversion=5
  *-disk:2
       description: SCSI Disk
       product: VIRTUAL DISK
       vendor: Dell
       physical id: 1.0.0
       bus info: scsi@0:1.0.0
       logical name: /dev/sda
       version: 1028
       size: 931GiB (999GB)
       capacity: 931GiB (999GB)
       capabilities: 15000rpm partitioned partitioned:dos
       configuration: ansiversion=5 signature=000e0a2d
  *-cdrom UNCLAIMED
       description: SCSI CD-ROM
       product: DVD+-RW TS-L633J
       vendor: TSSTcorp
       physical id: 0.0.0
       bus info: scsi@3:0.0.0
       version: D150
       capabilities: removable
       configuration: ansiversion=5

{% endhighlight %}

The following command will quickly list installed disks including CD/DVD/BD drivers:

	# lshw -short -C disk

Sample output:

{% highlight bash %}
H/W path               Device     Class      Description
========================================================
/0/100/1c/0/0.0.0                 disk       1TB ST31000524AS
/0/100/1c/0/0.1.0                 disk       1TB ST31000524AS
/0/100/1c/0/1.0.0      /dev/sda   disk       999GB VIRTUAL DISK
/0/100/1f.5/0.0.0                 disk       DVD+-RW TS-L633J
{% endhighlight %}

***NOTE*** There are 2 disk(1T) on this device. and RAID1 is actived. 


### Check Hard disk partition szie

	# df -h

Sample outputs:

{% highlight bash %}
	Filesystem            Size  Used Avail Use% Mounted on
	/dev/sda2              16G  5.7G  8.7G  40% /
	/dev/sda1             244M   25M  206M  11% /boot
	tmpfs                 2.0G     0  2.0G   0% /dev/shm
	/dev/sda5              92G  4.8G   83G   6% /opt
	/dev/sda6             806G  217G  549G  29% /var/ftp
{% endhighlight %}


### Check the cpu

	#lshw -class cpu

Sample outputs:

{% highlight bash %}
  *-cpu                   
       description: CPU
       product: Intel(R) Xeon(R) CPU           X3430  @ 2.40GHz
       vendor: Intel Corp.
       physical id: 400
       bus info: cpu@0
       version: Intel(R) Xeon(R) CPU           X3430  @ 2.40GHz
       slot: CPU1
       size: 2400MHz
       capacity: 3600MHz
       width: 64 bits
       clock: 505MHz
       capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx rdtscp x86-64 constant_tsc ida nonstop_tsc pni monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr sse4_1 sse4_2 popcnt lahf_lm
{% endhighlight %}



### Check the memory

	# lshw -C memory

Sample output:

{% highlight bash %}
  *-firmware              
       description: BIOS
       vendor: Dell Inc.
       physical id: 0
       version: 1.6.4 (03/03/2011)
       size: 64KiB
       capacity: 4032KiB
       capabilities: isa pci pnp upgrade shadowing cdboot bootselect edd int13floppytoshiba int13floppy360 int13floppy1200 int13floppy720 int9keyboard int14serial int10video acpi usb biosbootspecification netboot
{% endhighlight %}

### Check the newtork

	# lshw -class network

Sample outputs:


{% highlight bash %}
  *-network:0             
       description: Ethernet interface
       product: NetXtreme II BCM5716 Gigabit Ethernet
       vendor: Broadcom Corporation
       physical id: 0
       bus info: pci@0000:02:00.0
       logical name: eth0
       version: 20
       serial: 78:2b:cb:3a:16:3e
       size: 100MB/s
       capacity: 1GB/s
       width: 64 bits
       clock: 33MHz
       capabilities: pm vpd msi msix pciexpress bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
       configuration: autonegotiation=on broadcast=yes driver=bnx2 driverversion=2.1.11 duplex=full firmware=6.2.12 bc 5.2.3 NCSI 2.0.11 ip=60.215.129.82 latency=0 link=yes module=bnx2 multicast=yes port=twisted pair speed=100MB/s
  *-network:1 DISABLED
       description: Ethernet interface
       product: NetXtreme II BCM5716 Gigabit Ethernet
       vendor: Broadcom Corporation
       physical id: 0.1
       bus info: pci@0000:02:00.1
       logical name: eth1
       version: 20
       serial: 78:2b:cb:3a:16:3f
       capacity: 1GB/s
       width: 64 bits
       clock: 33MHz
       capabilities: pm vpd msi msix pciexpress bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
       configuration: autonegotiation=on broadcast=yes driver=bnx2 driverversion=2.1.11 duplex=half firmware=6.2.12 bc 5.2.3 NCSI 2.0.11 latency=0 link=no module=bnx2 multicast=yes port=twisted pair	
 {% endhighlight %}
