---
layout: post
title: "Howto manage encrypted disks with LUKS on Linux"
tagline: "Howto manage encrypted disks with LUKS on Linux"
description: ""
category: Linux
tags: [ Linux, Encryption ]
---
{% include JB/setup %}

The purpose of this document is guide you to encrypt your data on Linux.

## Install cryptsetup utility

	$sudo apt-get install cryptsetup

If on CentOS,

	$sudo yum install cryptsetup-luks

## Managing LUKS partition

### Create LUKS partition 
 
In this example,  Let us to encrpt "/dev/sda1"(80G). Type the following command:

	$sudo cryptsetup luksFormat /dev/sda1

Sample outputs:

	WARNING!
	========
	This will overwrite data on /dev/sda1 irrevocably.

	Are you sure? (Type uppercase yes): YES
	Enter LUKS passphrase: 
	Verify passphrase: 
	Command successful.

### Mapping the partition

Type the following command create a mapping:

	$sudo cryptsetup luksOpen /dev/sda1 backupX

Sample outputs:

	Enter passphrase for /dev/sda1:

It will add a mapping partition named "/dev/mapper/backupX" after successful verification. You can use the following 
command to see the status for the mapping:

	$ls -al /dev/mapper

Sample outputs:

	total 0
	drwxr-xr-x.  2 root root     80 Jun  6 10:13 .
	drwxr-xr-x. 19 root root   3800 Jun  6 10:13 ..
	lrwxrwxrwx.  1 root root      7 Jun  6 10:13 backupX -> ../dm-0
	crw-rw----.  1 root root 10, 58 Jun  6 09:46 control

Then,

	o croptsetup -v status backupX

Sample outputs:

	/dev/mapper/backupX is active.
	type:  LUKS1
	cipher:  aes-cbc-essiv:sha256
	keysize: 256 bits
	device:  /dev/sda1
	offset:  4096 sectors
	size:    156292226 sectors
	mode:    read/write
	Command successful.

### Format and mount LUKS partition

Before you mount this partition, format it firstly:

	$sudo mkfs.ext4	/dev/mapper/backupX

Then, mount it:

	$mkdir ~/eDisk
    $sudo mount /dev/mapper/backupX	~/eDisk

	$cd eDisk/
	$touch files
	$ ll

Sample outputs:

	total 16
	-rw-r--r--. 1 root root     0 Jun  6 10:02 files
	drwx------. 2 root root 16384 Jun  6 09:59 lost+found

### Close mapping

Before you want to close mapping this partition, you should make sure unmount it.

	$df -h
	Filesystem           Size  Used Avail Use% Mounted on
	/dev/sdb3             20G  3.7G   15G  21% /
	tmpfs                922M  144K  922M   1% /dev/shm
	/dev/sdb1            485M   80M  381M  18% /boot
	/dev/sdb6             50G  180M   48G   1% /opt
	/dev/sdb2             39G  758M   36G   3% /var
	/dev/mapper/backupX   74G  180M   70G   1% /root/eDisk

OK, you need umount it:

	$sudo umount ~/eDisk/

Then, close the mapping(The "backupX -> ../dm-0" has missing)

	$sudo cryptsetup luksClose backupX

	$ls -al /dev/mapper/
	total 0
	drwxr-xr-x.  2 root root     60 Jun  6 10:11 .
	drwxr-xr-x. 19 root root   3780 Jun  6 10:11 ..
	crw-rw----.  1 root root 10, 58 Jun  6 09:46 control

### Auto mount the partition

#### Make a keyfile
	
	$su - root
	$dd if=/dev/urandom of=.keyfile bs=1k count=4
	$ls -al

Sample output:

	-rw-r--r--.  1 root root  4096 Jun  6 10:19 .keyfile

#### Add this key to the partition

	$cryptsetup luksAddKey /dev/sda1 ~/.keyfile

Sample outputs(You should enter the password when you format this disk):	

	Enter any passphrase:

#### Setup crypttab

	$vim /etc/crypttab

Add the following:

	backupX		/dev/sda1	/root/.keyfile	luks

#### Setup the fstab

	$vim /etc/fstab

Add the following to the end of this file:

	/dev/mapper/backupX	/root/eDisk		ext4    defaults	0 0



	
	



	

