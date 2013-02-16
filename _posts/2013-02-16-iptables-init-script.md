---
layout: post
title: "IPTABLES初始化脚本"
tagline: "IPTABLES init script"
description: "好用的iptable初始化脚本"
category: Linux
tags: [Iptables,Security]
---
{% include JB/setup %}
在管理Linux服务器的过程中，Iptables是基础的安全工具，按照自己的想法初始化有效的iptables脚本，是很有必要的

## 关于Iptables

iptables 是与 Linux 内核集成的 IP 信息包过滤系统。如果 Linux 系统连接到因特网或 LAN、服务器或连接 LAN 和因特网的代理服务器， 则该系统有利于在 Linux 系统上更好地控制 IP 信息包过滤和防火墙配置。

## 下载

<a href="/bashScripts/iptables_setup.sh">Iptables-init-script</a>

## 使用方法 Usage
使用Root用户登录，修改权限,保证可以执行：
	
	$chmod 700 /etc/init.d/iptables

注意：在执行后，请测试每个端口的开发状况后，在保存当前规则。
