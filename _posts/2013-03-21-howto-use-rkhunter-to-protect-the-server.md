---
layout: post
title: "如何使用rkhunter保护服务器"
tagline: "HowTo use rkhunter to protect the server"
description: ""
category: Linux
tags: [ Linux, Security ]
---
{% include JB/setup %}

[rkhunter](http://www.rootkit.nl/)是Linux下的一款开源入侵检测工具。rkhunter具有比chrootkit更为全面的扫描范围。除rootkit特征码扫描外，rkhunter还支持端口扫描，常用开源软件版本和文件变动情况检查等。

## 安装

### YUM安装

安装rkhunter,需要设置EPEL( [在CentOS上如何启用 EPEL Repository](/Linux/how-to-enable-epel-repository-for-centos/)  )
{% highlight bash %}
[root@server ~]#yum install rkhunter -y
Loaded plugins: fastestmirror
Determining fastest mirrors
 * base: mirrors.btte.net
 * epel: mirrors.sohu.com
 * extras: mirrors.btte.net
 * updates: mirrors.163.com
base                                                      | 1.1 kB     00:00     
epel                                                      | 3.6 kB     00:00     
epel/primary_db                                           | 3.7 MB     00:34     
extras                                                    | 2.1 kB     00:00     
local                                                     | 1.3 kB     00:00     
updates                                                   | 1.9 kB     00:00     
updates/primary_db                                        | 253 kB     00:00     
Setting up Install Process
Resolving Dependencies
--> Running transaction check
---> Package rkhunter.noarch 0:1.4.0-1.el5 set to be updated
--> Finished Dependency Resolution

Dependencies Resolved

=================================================================================
 Package            Arch             Version                Repository      Size
=================================================================================
Installing:
 rkhunter           noarch           1.4.0-1.el5            epel           202 k

Transaction Summary
=================================================================================
Install       1 Package(s)
Upgrade       0 Package(s)

Total download size: 202 k
Downloading Packages:
rkhunter-1.4.0-1.el5.noarch.rpm                           | 202 kB     00:01     
Running rpm_check_debug
Running Transaction Test
Finished Transaction Test
Transaction Test Succeeded
Running Transaction
  Installing     : rkhunter                                                  1/1 

Installed:
  rkhunter.noarch 0:1.4.0-1.el5                                                  

Complete!
{% endhighlight %}

### 参数

#### --checkall (or -c)

检查系统并执行所有测试。

#### --createlogfile*

建立Log(预设产生于/var/log/rkhunter.log)

#### --cronjob

加入系统排程 (会自动拿掉彩色输出)

#### --help (or -h)
显示说明及相关用法

#### --nocolors*
不要使用颜色为输出型式(一些Term Type对颜色或延长的显示符号会有问题)

#### --report-mode*
若用 crontab 或其他用法时，如header/footer则不显示
--skip-keypress*
(不采互动)也就是不要每个测试后等待提示出现，按下 Enter 才能继续

#### --quick*
执行快的扫瞄(代替充分的扫瞄) 略过一些测试而执行某些加强的测试(对正常扫瞄而言，较不适当)。

#### --update
更新 hashes database

#### --version
显示版本并离开

#### --versioncheck
检查最新的版本


## 更新rkhunter的数据库

	$rkhunter --update
	$rkhunter --list

## 为基本系统程序建立校对样本

	$rkhunter --propupd
	[ Rootkit Hunter version 1.3.8 ]
	File created: searched for 165 files, found 136
## 检测

### 基本方法

{% highlight bash %}
[root@server ~]# rkhunter -c
[ Rootkit Hunter version 1.4.0 ]

Checking system commands...

  Performing 'strings' command checks
    Checking 'strings' command                               [ OK ]

  Performing 'shared libraries' checks
    Checking for preloading variables                        [ None found ]
    Checking for preloaded libraries                         [ None found ]

  Performing file properties checks
    Checking for prerequisites                               [ Warning ]
    /sbin/chkconfig                                          [ OK ]
    /sbin/nologin                                            [ OK ]
    /sbin/rmmod                                              [ OK ]
    ......
	
[Press <ENTER> to continue]

Checking for rootkits...
  Performing check of known rootkit files and directories
    55808 Trojan - Variant A                                 [ Not found ]
    ADM Worm                                                 [ Not found ]
    AjaKit Rootkit                                           [ Not found ]
    ......

[Press <ENTER> to continue]

  Performing additional rootkit checks
    Suckit Rookit additional checks                          [ OK ]
    Checking for possible rootkit files and directories      [ None found ]
    Checking for possible rootkit strings                    [ None found ]
  Performing malware checks
    Checking running processes for suspicious files          [ None found ]
    Checking for login backdoors                             [ None found ]
    Checking for suspicious directories                      [ None found ]
    Checking for sniffer log files                           [ None found ]
  Performing trojan specific checks
    Checking for enabled xinetd services                     [ Warning ]
    Checking for Apache backdoor                             [ Not found ]
  Performing Linux specific checks
    Checking loaded kernel modules                           [ OK ]
    Checking kernel module names                             [ OK ]

[Press <ENTER> to continue]

Checking the network...
  Performing checks on the network ports
    Checking for backdoor ports                              [ None found ]
    Checking for hidden ports                                [ Skipped ]
  Performing checks on the network interfaces
    Checking for promiscuous interfaces                      [ None found ]

Checking the local host...
  Performing system boot checks
    Checking for local host name                             [ Found ]
    Checking for system startup files                        [ Found ]
    Checking system startup files for malware                [ None found ]
  Performing group and account checks
    Checking for passwd file                                 [ Found ]
    Checking for root equivalent (UID 0) accounts            [ None found ]
    Checking for passwordless accounts                       [ None found ]
    Checking for passwd file changes                         [ Warning ]
    Checking for group file changes                          [ Warning ]
    Checking root account shell history files                [ OK ]
  Performing system configuration file checks
    Checking for SSH configuration file                      [ Found ]
    Checking if SSH root access is allowed                   [ Warning ]
    Checking if SSH protocol v1 is allowed                   [ Not allowed ]
    Checking for running syslog daemon                       [ Found ]
    Checking for syslog configuration file                   [ Found ]
    Checking if syslog remote logging is allowed             [ Not allowed ]
  Performing filesystem checks
    Checking /dev for suspicious file types                  [ None found ]
    Checking for hidden files and directories                [ None found ]

[Press <ENTER> to continue]

System checks summary
=====================
File properties checks...
    Required commands check failed
    Files checked: 138
    Suspect files: 0
Rootkit checks...
    Rootkits checked : 316
    Possible rootkits: 0
Applications checks...
    All checks skipped
The system checks took: 1 minute and 22 seconds
All results have been written to the log file (/var/log/rkhunter/rkhunter.log)
One or more warnings have been found while checking the system.
Please check the log file (/var/log/rkhunter/rkhunter.log)

{% endhighlight %}

### 检测二进制命令

	$krootkit ps pwd ls  

### 检查所有，只提示被感染文件加 -q  

	$chkrootkit -q  

### 制定检测其他root目录，可以先把要检测的系统挂到/mnt/root下。  
	
	$chkrootkit -r /mnt/root  

## 邮件提醒

添加rkhunter.sh到"/etc/cron.daily/"

	vim /etc/cron.daily/rkhunter.sh

添加如下内容到文件 rkhunter.sh

{% highlight bash %}
#!/bin/sh
(
/usr/local/bin/rkhunter --versioncheck
/usr/local/bin/rkhunter --update
/usr/local/bin/rkhunter --cronjob --report-warnings-only
) | /bin/mail -s 'Rkhunter Daily Run Service' your@email.com
{% endhighlight %}

修改文件权限

	$chmod 755 /etc/cron.daily/rkhunter.sh

## 调试问题

### PATH设置问题

如果出现类似错误,如
	
	Invalid BINDIR configuration option: Invalid directory found: ...

说明你的PATH变量有问题，请检查相关配置

