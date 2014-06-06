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
	Enter LUKS passphrase: <enter a password>
	Verify passphrase: <re-enter the password>

***NOTE*** Do NOT use SHA-1 to encrypt the LUKS disk. As the cryptography expert Bruce Schneier already told in year 2005. See his article here: [http://www.schneier.com/blog/archives/2005/02/sha1_broken.html](http://www.schneier.com/blog/archives/2005/02/sha1_broken.html). So, let`s encrypt the destination disk with aes-xts-plain:

	$sudo cryptsetup luksFormat -c aes-xts-plain64 -s 512 -h sha512 /dev/sda1

*** Params Detail ***

- "-c" --cipher aes-xts-plain64 
- "-s" --key-size 512 
- "-h" --hash sha512

### Load and close mapper of the LUKS partition

#### Mapping the LUKS partition

Type the following command create a mapping:

	$sudo cryptsetup luksOpen /dev/sda1 backupX

Sample outputs:

	Enter passphrase for /dev/sda1:

It will add a mapping partition named "/dev/mapper/backupX" after successful verification. You can use the following 
command to see the status for the mapping:

	$ls -al /dev/mapper

Sample outputs:

	lrwxrwxrwx.  1 root root      7 Jun  6 10:13 backupX -> ../dm-0
	crw-rw----.  1 root root 10, 58 Jun  6 09:46 control

Then,

	$sudo croptsetup -v status backupX

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

#### Close the LUKS partition

Before you want to close mapping this partition, you should make sure unmount it.
 
    $df -h
    Filesystem           Size  Used Avail Use% Mounted on
    ...... 
	/dev/mapper/backupX   74G  180M   70G   1% /root/eDisk
	......
 
OK, you need umount it:
 
     $sudo umount ~/eDisk/
 
Then, close the mapping(The "backupX -> ../dm-0" has missing)
 
     $sudo cryptsetup luksClose backupX
 
     $ls -al /dev/mapper/
     total 0
     drwxr-xr-x.  2 root root     60 Jun  6 10:11 .
     drwxr-xr-x. 19 root root   3780 Jun  6 10:11 ..
     crw-rw----.  1 root root 10, 58 Jun  6 09:46 control

### Format and mount LUKS partition

Before you mount this partition, format it firstly:

	$sudo cryptsetup luksOpen /dev/sda1 backupX
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

### Auto mount the partition

#### Make a keyfile
	
	$su - root
	#dd if=/dev/urandom of=.keyfile bs=1k count=4
	#chmod 400 /root/.keyfile
	#ls -al

Sample output:

	-rw-r--r--.  1 root root  4096 Jun  6 10:19 .keyfile

#### Add this key to the partition

	#cryptsetup luksAddKey /dev/sda1 ~/.keyfile

Sample outputs(You should enter the password when you format this disk):	

	Enter any passphrase:

#### Setup crypttab

To make these auto unlock, we need to make "/etc/crypttab" entries for this partition. They should be based off the 
crypto_LUKS partitions.

	#vim /etc/crypttab

Add the following:

	backupX		/dev/sda1	/root/.keyfile	luks

if your want to use UUID, To find their UUIDs, try this:

	#blkid | grep crypto_LUKS

It should output something like this.

	UUID=a4e810e2-7812-4dfa-893a-2f55dbf09d12

Now, let`s use those UUIDs to update the "/etc/crypttab" file. It should look something like this. Those names at the beginning again create the entries that map to /dev/mapper.

	backupX     UUID=a4e810e2-7812-4dfa-893a-2f55dbf09d12   /root/.keyfile  luks

When "/etc/crypttab" has been changed, update your initramfs so it can boot to the encrypted root partition:

	#update-initramfs -u

#### Setup the fstab

Now, the disks will automatically unlock at startup, but I also want them to automount too, so update "/etc/fstab" entries for 
this partition. It should be in this format and based off the UUID of the "/dev/mapper" entries. To find them quickly, try this.

	#blkid | grep mapper

Sample outputs:

	UUID=3b122bc3-8b5d-5cc1-baf6-7ef163cc6760

Let`s open the "/ect/fstab":

	#vim /etc/fstab

Add the following to the end of this file:

	/dev/mapper/backupX	/root/eDisk		ext4    defaults	0 0

Or, using the UUID's from above

	UUID=3b122bc3-8b5d-5cc1-baf6-7ef163cc6760 /root/eDisk        ext4         defaults 0 0


Then, Reboot and ensure your disks automount. 	
	



	

