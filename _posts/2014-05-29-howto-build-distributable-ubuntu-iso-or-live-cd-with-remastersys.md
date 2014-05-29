---
layout: post
title: "Howto build distributable Ubuntu ISO or Live CD with remastersys"
tagline: "Howto build distributable Ubuntu ISO or Live CD with remastersys"
description: ""
category: Linux 
tags: [ Linux, Ubuntu, Iso ]
---
{% include JB/setup %}

The purpose of this document is to guide you to manage your distributable iso or customized live-CD for
Ubuntu with remastersys.

## Install Remastersys

### Add the remastersys repository to "/etc/apt/sources.list"

	$sudo vim /etc/apt/sources.list

### To install Remastersys repository key

	wget -q -O - http://www.remastersys.com/ubuntu/remastersys.gpg.key |sudo  apt-key add -

Paste the following into the sources.list:

	# Remastersys repo
	deb http://www.remastersys.com/ubuntu precise main

Or, run the commands below to add Remastersys repository.

	# sudo sh -c 'echo "deb http://www.remastersys.com/ubuntu precise main" >> /etc/apt/sources.list'

### Install the packages

Save and exit the file. Then, install it:

	$sudo apt-get update && sudo apt-get install remastersys remastersys-gtk

## Usage

### To Backup the system 

	$sudo remastersys backup	

OR
	$sudo remastersys backup Ubuntu-14.04-64bit-lampnode.backup.iso

The ISO would be created stored in ~/remastersys.


### To make a distributable iso with your personal data

	$sudo remastersys dist

It will create an iso image called customdist.iso in the /home/remastersys directory. The dist option makes that your personal folder (e.g. "/home/robert") will not be included in the iso image.

After you`ve burnt the iso image onto a CD/DVD, you can run:

	$sudo remastersys clean

It will remove all temporary file created during the iso generation as well as the /home/remastersys directory.

###  Limitations

 - There`s a 4GB size limit of what can be backed up and created into an ISO image of your computer.
 - DO NOT install the driver for Nvidia graphics card. You need to retain The default graphics driver.
