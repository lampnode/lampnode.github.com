---
layout: post
title: "Howto install and setup bind9 on Ubuntu"
tagline: "Howto install and setup bind9 on Ubuntu"
description: ""
category: Linux 
tags: [ Linux, Ubuntu, Bind ]
---
{% include JB/setup %}

The purpose of this tutorial is to describe steps by steps to install and setup bind9 on Ubuntu.


## Installation

	$sudo apt-get install bind9

## Configuration

### Basic

	$sudo vim /etc/bind/named.conf.local

In this example, Let us setup example.com(192.168.0.0/24) as the local domain.you should
add the following content to the end of this file.

	# set zone for internal
	zone "hxstong.org" {
		type master;
		file "/etc/bind/zones/example.com.zone";
		allow-update { none; };
		};

	# set zone for internal
	zone "0.168.192.in-addr.arpa" {
		type master;
		file "/etc/bind/zones/example.com.rev.zone";
		allow-update { none; };
	};


### Add zone files

Firstly, you should create a directory to save all of zone files:

	# cd /etc/bind
	# mkdir zones

Then, create local zone file:

	$ vim /etc/bind/zones/example.com.zone

Add the following content to this file:

	@   IN  SOA     example.com. root.example.com. (
		2013042201  ;Serial
		3600        ;Refresh
		1800        ;Retry
		604800      ;Expire
		86400       ;Minimum TTL
	)
	; Specify our two nameservers
			IN      NS              ns.hxstong.org.
			IN      NS              printer.hxstong.org.
			IN      NS              dev.hxstong.org.

	; Resolve nameserver hostnames to IP, replace with your two droplet IP addresses.
	ns              IN      A               192.168.0.3
	srv             IN      A               192.168.0.253
	dev				IN		A				192.168.0.16

OK, Let us define reverse DNS lookup.

	# vim /etc/bind/zone/example.com.rev.zone

Add the following content to this file:

	$TTL 86400
	@       IN SOA  example.com. root.example.com. (
			1997022700 ; Serial
			28800      ; Refresh
			14400      ; Retry
			3600000    ; Expire
			86400 )    ; Minimum

	@       IN      NS      example.com.
	3       IN      PTR     ns.example.com.
	16		IN		PTR		dev.example.com.
	253     IN      PTR     srv.example.com.

### Update name.conf.options

now, let`s edit the options file:

	#vim /etc/bind/named.conf.options

Update the following content to the options section:

#### setup dump and cache

	# specify a different location for the dumpfile
	dump-file       "/var/cache/bind/data/cache_dump.db";
	# For rndc stats: This statement defines the file to which data will be written when the command rndc stats is issued.
	statistics-file "/var/cache/bind/data/named_stats";
	#  The file to whitch BIND memory usage statistics will be written when it exits
	memstatistics-file "/var/cache/bind/data/named_mem_stats";

#### Add the forwoarder DNS name servers

We need to add forwarder DNS name servers which are used when the internal name server cannot resolve 
the DNS name requested. Here we user the OPEN-DNS name server IPs.

	forwarders {
		208.67.222.222;208.67.220.220;208.67.222.220;208.67.220.222;
	};

#### Query range you allow

To define an match list of IP address(es) which are allowed to issue queries to the server. 
If not specified all hosts are allowed to make queries (defaults to "allow-query {any;};").

	allow-query { localhost; 192.168.0.0/24; };

#### Restrict recursive lookup on BIND

This will allow local server and local network queries to resolve domains not managed by himself. All remote queries will be refused except the domains entered into your named.conf.

	recursion yes;
	allow-recursion { localhost; 192.168.0.0/24;};

#### Version

Specifies the string that will be returned to a version

	version "Not Disclosed";


#### Disable ipv6 if you need:

	listen-on-v6 { none; };

### Add the logs options

now, let`s edit the options file:

	#vim /etc/bind/named.conf.options

Add the following content to the logging section:

{% highlight bash %}
logging {
    channel default_file {
        file "/var/log/named/default.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel general_file {
        file "/var/log/named/general.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel database_file {
        file "/var/log/named/database.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel security_file {
        file "/var/log/named/security.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel config_file {
        file "/var/log/named/config.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel resolver_file {
        file "/var/log/named/resolver.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel xfer-in_file {
        file "/var/log/named/xfer-in.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel xfer-out_file {
        file "/var/log/named/xfer-out.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel notify_file {
        file "/var/log/named/notify.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel client_file {
        file "/var/log/named/client.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel unmatched_file {
        file "/var/log/named/unmatched.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel queries_file {
        file "/var/log/named/queries.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel network_file {
        file "/var/log/named/network.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel update_file {
        file "/var/log/named/update.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel dispatch_file {
        file "/var/log/named/dispatch.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel dnssec_file {
        file "/var/log/named/dnssec.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    channel lame-servers_file {
        file "/var/log/named/lame-servers.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };

    category default { default_file; };
    category general { general_file; };
    category database { database_file; };
    category security { security_file; };
    category config { config_file; };
    category resolver { resolver_file; };
    category xfer-in { xfer-in_file; };
    category xfer-out { xfer-out_file; };
    category notify { notify_file; };
    category client { client_file; };
    category unmatched { unmatched_file; };
    category queries { queries_file; };
    category network { network_file; };
    category update { update_file; };
    category dispatch { dispatch_file; };
    category dnssec { dnssec_file; };
    category lame-servers { lame-servers_file; };
};
{%endhighlight %}

	# mkdir /var/log/named
	# touch /var/log/named/default.log
	# chown -R bind:bind /var/log/named
	# /etc/init.d/bind9 restart


now you just need to restart bind:

	#/etc/init.d/bind9 restart

### update "resolv.conf"

	#vim /etc/resolv.conf

set search as  example.com, and set 192.168.0.3 as your new DNS server.

	search example.com
	nameserver 192.168.0.3

## Test your DNS

Install DNS utility.

	$sudo apt-get install dnsutils

Once the install process finished, type following command:

	
	$dig domain.com	
