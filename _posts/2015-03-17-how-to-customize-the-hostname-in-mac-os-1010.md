---
layout: post
title: "How to customize the hostname in Mac OS 10.10"
tagline: "How to customize the hostname in Mac OS 10.10"
description: ""
category: MacOS
tags: [ MacOS ]
---
{% include JB/setup %}

This document is to show you how to change your Mac computer name through the command line and make it permanent.

## For hostname


    $ sudo scutil --set HostName MacBookPro  


After the command is executed you can verify that the changes took place by typing:

    $ hostname
    
You can also set a temporary hostname change by using the following command:

    $ sudo hostname new_hostname

This will reset itself after your Mac reboots though, so if you want a permanent hostname change, use the above command instead.

## For share computer name


    $ sudo scutil --set ComputerName MacBookPro 
     


