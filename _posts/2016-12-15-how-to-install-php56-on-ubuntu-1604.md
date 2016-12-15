---
layout: post
title: "How to install php5.6 on Ubuntu 16.04"
tagline: "How to install php5.6 on Ubuntu 16.04"
description: ""
category: 
tags: [PHP, Ubuntu ]
---
{% include JB/setup %}


## Remove all the stock php packages


    sudo apt-get purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`

## Add the PPA

    sudo add-apt-repository ppa:ondrej/php

If you get add-apt-repository: command not found run the following command first :

    sudo apt-get install software-properties-common

## Install your PHP Version

    sudo apt-get update
    sudo apt-get install php5.6

You can install php5.6 modules too for example

    sudo apt-get install php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml php5.6-cli

## Verify PHP version

    sudo php -v




