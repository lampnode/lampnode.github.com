---
layout: post
title: "Automatically enable HTTPS on your website with EFF's Certbot"
tagline: "Automatically enable HTTPS on your website with EFF's Certbot"
description: ""
category: 
tags: [ HTTPS, Linux, Apache ]
---
{% include JB/setup %}

The purpose of this document is to enable HTTPS on your website with EFF's Certbot on CentOS. Detailed see: https://certbot.eff.org/#centosrhel6-apache



## Install

Not all of Certbot's dependencies are available in the standard repositories. To use Certbot, you must first enable the EPEL (Extra Packages for Enterprise Linux) repository.

Since it doesn't seem like your operating system has a packaged version of Certbot, you should use our certbot-auto script to get a copy:

    wget https://dl.eff.org/certbot-auto
    chmod a+x certbot-auto

certbot-auto accepts the same flags as certbot; it installs all of its own dependencies and updates the client code automatically. So you can just run:

    $ ./certbot-auto

## Get Started

Certbot has a fairly solid beta-quality Apache plugin, which is supported on many platforms, and automates both obtaining and installing certs:

    $ ./path/to/certbot-auto --apache

If you're feeling more conservative and would like to make the changes to your Apache configuration by hand, you can use the certonly subcommand:

    $ ./path/to/certbot-auto --apache certonly

To learn more about how to use Certbot read our documentation.

## Automating renewal

Certbot can be configured to renew your certificates automatically before they expire. Since Let's Encrypt certificates last for 90 days, it's highly advisable to take advantage of this feature. You can test automatic renewal for your certificates by running this command:

    ./path/to/certbot-auto renew --dry-run 

If that appears to be working correctly, you can arrange for automatic renewal by adding a cron or systemd job which runs the following:

    ./path/to/certbot-auto renew --quiet 
