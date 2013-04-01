---
layout: page
title: "nslookup"
description: ""
---
{% include JB/setup %}

nslookup是查询域名的解析情况的常用工具。

## 语法
	
	nslookup [ -Option ... ] [ Host ] [ -NameServer ]

## 用法
nslookup 命令以两种方式查询域名服务器。交互式模式允许查询名称服务器获得有关不同主机和域的信息，或打印域中主机列表。在非交互式模式，打印指定的主机或域的名称和请求的信息。

### 子命令

#### server Domain 与 lserver Domain 

	server Domain
	lserver Domain

更改缺省服务器为 Domain 参数指定的值。lserver 子命令使用初始服务器查询有关域的信息。server 子命令使用当前的缺省服务器。如果未发现授权应答，则任何可能有应答的附加服务器名返回。

#### root

更改缺省服务器为 root 域名空间服务器。当前，使用主机 ns.nic.ddn.mil 。root 服务器名可以使用 set root 子命令更改。（root 子命令与 lserver ns.nic.ddn.mil 子命令同义）。

#### ls

	ls [Option] Domain [> FileName]
	ls [Option] Domain [>> FileName]

为指定的 Domain 列出可获得的信息，有选择的创建或追加输出到 FileName 参数指定的文件。缺省输出包含主机名和它们的因特网地址。Option 参数的可能值是：

* -t QueryType 列出指定类型的所有记录。缺省记录类型是 A。有效类型是：
* A  主机的因特网地址
* CNAME 为别名规范名称
* HINFO 主机 CPU 和操作系统
* KEY 安全性密钥记录
* MINFO 邮箱或邮件列表信息
* MX 邮件交换器
* NS 指定区域的名称服务器
* PTR 如果查询是因特网地址则指向主机名；否则，指向其他信息
* SIG 特征符记录
* SOA 域的“start-of-authority”信息
* TXT 文本信息
* UINFO 用户信息
* WKS 支持众所周知的服务
* -a 列出域中主机的别名（与 -t CNAME 选项相同）。
* -d 列出域中所有记录（与 -t ANY 选项同义）。
* -h 列出域中 CPU 和操作系统信息（与 -t HINFO 选项同义）。
* -s 列出域中众所周知的主机服务（与 -t WKS 选项同义）。

#### set 

	set Keyword[=Value]

改变影响查询的状态信息。该命令可以在命令行指定或有选择的在用户主目录的 .nslookuprc 文件指定。有效的关键字是：

* all 显示频繁地使用的选项要设置的当前值。有关当前缺省服务器和主机的信息也显示。
* class=Value 更改查询类为下列之一。类指定信息的协议组。缺省值是 IN。
* IN Internet 类
* CHAOS Chaos 类
* HESIOD MIT Althena Hesiod 类
* ANY 通配符（上面任意之一）
* [no]debug 打开调试模式。缺省值是 nodebug （关闭）。
* [no]d2 打开全面调试模式。缺省值是 nod2（关闭）。
* domain=Name 更改缺省域名为 Name 参数指定的域名。缺省域名追加到查询请求，取决于 defname 和 search 选项的状态。如果搜索列表在其名称中至少包含两部分则域搜索列表包含缺省域的父域。例如，如果缺省域是 CC.Berkeley.EDU，搜索列表是 CC.Berkeley.EDU 和 Berkeley.EDU。使用 set srchlist 命令指定不同列表。使用 set all 命令显示列表。domain=Name 选项的缺省值是在系统的 hostname、/etc/resolv.conf、或 LOCALDOMAIN 文件指定的值。
* srchlst=Name1/Name2/... 更改缺省域名为 Name1 参数指定的值，并且更改域搜索列表为 Name1、Name2......参数指定的名称。可以指定由斜杠分开的六个名称的最大值。使用 set all 命令显示名称列表。缺省值是在系统的 hostname、/etc/resolv.conf 或 LOCALDOMAIN 文件指定的值。
注：该命令覆盖缺省域名和 set domain 命令选项的搜索列表。
* [no]defname 追加缺省域名到单一的组成部分的查询请求（不包含句点的请求）。缺省值是 defname （追加）。
* [no]search 如果查询请求包含结尾句点以外的句点，追加域搜索列表中的域名到请求直到接收到应答。缺省值是 search。
* port=Value 更改缺省 TCP/UDP 名称服务器端口为 Value 参数指定的数。缺省值是 53。
* querytype=Value

#### type

	type=Value

更改信息查询为下列值之一。缺省值是 A。

* A 主机的因特网地址
* ANY 任何可用的选项。
* CNAME 为别名规范名称
* HINFO 主机 CPU 和操作系统
* KEY 安全性密钥记录
* MINFO 邮箱或邮件列表信息
* MX 邮件交换器
* NS 为指定区域的命名服务器
* PTR 如果查询因特网地址则指向主机名；否则，指向其他信息
* SIG 特征符记录
* SOA 域的“start-of-authority”信息
* TXT 文本信息
* UINFO 用户信息
* WKS 支持众所周知的服务
* [no]recurse 如果没有信息则通知名称服务器查询其他服务器。缺省值是 recurse。
* retry=Number 设置请求企图重试次数值为 Number 参数指定的值。当请求的应答没有在 set timeout 命令指定的时间帧之内接收，则超时周期加倍，请求重新发送。该子命令控制超时之前请求发送的次数。缺省值是 4。
* root=Host 更改 root 服务器名称为 Host 参数指定的名称。缺省值是 ns.nic.ddn.mil。
* timeout=Number 更改初始等待应答超时间隔为 Number 参数指定的秒数。缺省值是 5 秒。
* [no]vc 当发送请求到服务器使用虚拟电路。缺省值是 novc（没有虚拟电路）。
* [no]ignoretc 忽略数据包截断错误。缺省值是 noignoretc（不忽略）。

## 例子

交互模式例子

{% highlight bash %}
C:\Documents and Settings\Edwin>nslookup
Default Server:  google-public-dns-a.google.com
Address:  8.8.8.8

> set qt=all
> google.com
Server:  google-public-dns-a.google.com
Address:  8.8.8.8

Non-authoritative answer:
google.com      internet address = 74.125.31.102
google.com      internet address = 74.125.31.139
google.com      internet address = 74.125.31.138
google.com      internet address = 74.125.31.100
google.com      internet address = 74.125.31.113
google.com      internet address = 74.125.31.101
google.com      AAAA IPv6 address = 2404:6800:4008:c00::8b
google.com      MX preference = 30, mail exchanger = alt2.aspmx.l.google.com
google.com      nameserver = ns1.google.com
google.com      MX preference = 50, mail exchanger = alt4.aspmx.l.google.com
google.com      MX preference = 20, mail exchanger = alt1.aspmx.l.google.com
google.com      MX preference = 10, mail exchanger = aspmx.l.google.com
google.com      MX preference = 40, mail exchanger = alt3.aspmx.l.google.com
google.com      nameserver = ns3.google.com
google.com      nameserver = ns2.google.com
google.com      text =

        "v=spf1 include:_spf.google.com ip4:216.73.93.70/31 ip4:216.73.93.72/31
~all"
google.com
        primary name server = ns1.google.com
        responsible mail addr = dns-admin.google.com
        serial  = 2013031900
        refresh = 7200 (2 hours)
        retry   = 1800 (30 mins)
        expire  = 1209600 (14 days)
        default TTL = 300 (5 mins)
google.com      nameserver = ns4.google.com
>
{% endhighlight %}
