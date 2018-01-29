---
layout: post
title: "Wireless network management in Raspberry Pi"
tagline: "Wireless network management in Raspberry Pi"
description: ""
category: raspberry
tags: [ Raspberry ]
---
{% include JB/setup %}

## Scanning WiFi network

iwlist - Get more detailed wireless information from a wireless interface:

    sudo iwlist wlan0 scan

    @raspberrypi:~ $ sudo iwlist wlan0 scan
        wlan0     Scan completed :
        Cell 01 - Address: 12:2A:B3:A8:82:82
            ESSID:"Raspberry"
            Protocol:IEEE 802.11bgn
            Mode:Master
            Frequency:2.422 GHz (Channel 3)
            Encryption key:on
            Bit Rates:72 Mb/s
            Extra:rsn_ie=30140100000fac040100000fac040100000fac020c00
            IE: IEEE 802.11i/WPA2 Version 1
            Group Cipher : CCMP
            Pairwise Ciphers (1) : CCMP
            Authentication Suites (1) : PSK
            IE: Unknown: DD180050F204104A00011010440001021049000600372A000120
            Quality=48/100  Signal level=87/100

`ESSID: "Raspberry"` is the name of the WiFi network.
`IE: IEEE 802.11i/WPA2 Version 1` is an authenticated version of the wireless network

## Adding a password based WIFI network

    sudo vim /etc/wpa_supplicant/wpa_supplicant.conf

Add the followings:

    network={
        ssid="The_ESSID_from_earlier"
        psk="Your_wifi_password"
    }

If you are connected to a hidden network, you need to add a scan_ssid connection to the configuration file. The contents that need to be added are as follows:

    network={
        ssid="yourHiddenSSID"
        scan_ssid=1
        psk="Your_wifi_password"
    }


Adding multiple wireless network

    network={
        ssid="SchoolNetworkSSID"
        psk="passwordSchool"
        id_str="school"
    }
    network={
        ssid="HomeNetworkSSID"
        psk="passwordHome"
        id_str="home"
    }


OK, then reconfig wifi, force wpa_supplicant to re-read its configuration file

    sudo wpa_cli reconfigure


