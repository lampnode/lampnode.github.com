---
layout: page
title: "ls"
description: ""
---
{% include JB/setup %}

iptables 是与 Linux 内核集成的 IP 信息包过滤系统。如果 Linux 系统连接到因特网或 LAN、服务器或连接 LAN 和因特网的代理服务器， 则该系统有利于在 Linux 系统上更好地控制 IP 信息包过滤和防火墙配置。

## 格式

	iptables [-t table] {-A|-D} chain rule-specification

	iptables [-t table] -I chain [rulenum] rule-specification

	iptables [-t table] -R chain rulenum rule-specification

	iptables [-t table] -D chain rulenum

	iptables [-t table] -S [chain [rulenum]]

	iptables [-t table] {-F|-L|-Z} [chain [rulenum]] [options...]

	iptables [-t table] -N chain

	iptables [-t table] -X [chain]

	iptables [-t table] -P chain target

	iptables [-t table] -E old-chain-name new-chain-name

## 基础知识

### TABLES 

当前有三个表（哪个表是当前表取决于内核配置选项和当前模块)。 
#### -t table 

这个选项指定命令要操作的匹配包的表。如果内核被配置为自动加载模块，这时若模块没有加载，(系统)将尝试(为该表)加载适合的模块。这些表如下：filter,这是默认的表，包含了内建的链INPUT（处理进入的包）、FORWORD（处理通过的包）和OUTPUT（处理本地生成的包）。nat,这个表被查询时表示遇到了产生新的连接的包,由三个内建的链构成：PREROUTING (修改到来的包)、OUTPUT（修改路由之前本地的包）、POSTROUTING（修改准备出去的包）。mangle 这个表用来对指定的包进行修改。它有两个内建规则：PREROUTING（修改路由之前进入的包）和OUTPUT（修改路由之前本地的包）。 

### COMMANDS 

这些选项指定执行明确的动作：若指令行下没有其他规定,该行只能指定一个选项.对于长格式的命令和选项名,所用字母长度只要保证iptables能从其他选项中区分出该指令就行了。 

#### -A -append 

在所选择的链末添加一条或更多规则。当源（地址）或者/与 目的（地址）转换为多个地址时，这条规则会加到所有可能的地址(组合)后面。 

#### -D -delete 

从所选链中删除一条或更多规则。这条命令可以有两种方法：可以把被删除规则指定为链中的序号(第一条序号为1),或者指定为要匹配的规则。 

#### -R -replace 

从选中的链中取代一条规则。如果源（地址）或者/与 目的（地址）被转换为多地址，该命令会失败。规则序号从1开始。 

#### -I -insert 

根据给出的规则序号向所选链中插入一条或更多规则。所以，如果规则序号为1，规则会被插入链的头部。这也是不指定规则序号时的默认方式。 

#### -L -list 

显示所选链的所有规则。如果没有选择链，所有链将被显示。也可以和z选项一起使用，这时链会被自动列出和归零。精确输出受其它所给参数影响。 

#### -F -flush 

清空所选链。这等于把所有规则一个个的删除。 

#### --Z -zero 

把所有链的包及字节的计数器清空。它可以和 -L配合使用，在清空前察看计数器，请参见前文。 

#### -N -new-chain 

根据给出的名称建立一个新的用户定义链。这必须保证没有同名的链存在。 

#### -X -delete-chain 

删除指定的用户自定义链。这个链必须没有被引用，如果被引用，在删除之前你必须删除或者替换与之有关的规则。如果没有给出参数，这条命令将试着删除每个非内建的链。 


#### -P -policy 

设置链的目标规则。 

#### -E -rename-chain 

根据用户给出的名字对指定链进行重命名，这仅仅是修饰，对整个表的结构没有影响。TARGETS参数给出一个合法的目标。只有非用户自定义链可以使用规则，而且内建链和用户自定义链都不能是规则的目标。 

#### -h Help. 

帮助。给出当前命令语法非常简短的说明。 

### PARAMETERS 
 
以下参数构成规则详述，如用于add、delete、replace、append 和 check命令。 

#### -p -protocal [!]protocol 

规则或者包检查(待检查包)的协议。指定协议可以是tcp、udp、icmp中的一个或者全部，也可以是数值，代表这些协议中的某一个。当然也可以使用在/etc/protocols中定义的协议名。在协议名前加上"!"表示相反的规则。数字0相当于所有all。Protocol all会匹配所有协议，而且这是缺省时的选项。在和check命令结合时，all可以不被使用。 

#### -s -source [!] address[/mask] 

指定源地址，可以是主机名、网络名和清楚的IP地址。mask说明可以是网络掩码或清楚的数字，在网络掩码的左边指定网络掩码左边"1"的个数，因此，mask值为24等于255.255.255.0。在指定地址前加上"!"说明指定了相反的地址段。标志 --src 是这个选项的简写。 

#### -d --destination [!] address[/mask] 

指定目标地址，要获取详细说明请参见 -s标志的说明。标志 --dst 是这个选项的简写。 

#### -j --jump target 

指定规则的目标；也就是说，如果包匹配应当做什么。目标可以是用户自定义链（不是这条规则所在的），某个会立即决定包的命运的专用内建目标，或者一个扩展（参见下面的EXTENSIONS）。如果规则的这个选项被忽略，那么匹配的过程不会对包产生影响，不过规则的计数器会增加。 

#### -i -in-interface [!] [name] 

这是包经由该接口接收的可选的入口名称，包通过该接口接收（在链INPUT、FORWORD和PREROUTING中进入的包）。当在接口名前使用"!"说明后，指的是相反的名称。如果接口名后面加上"+"，则所有以此接口名开头的接口都会被匹配。如果这个选项被忽略，会假设为"+"，那么将匹配任意接口。 

#### -o --out-interface [!][name] 

这是包经由该接口送出的可选的出口名称，包通过该口输出（在链FORWARD、OUTPUT和POSTROUTING中送出的包）。当在接口名前使用"!"说明后，指的是相反的名称。如果接口名后面加上"+"，则所有以此接口名开头的接口都会被匹配。如果这个选项被忽略，会假设为"+"，那么将匹配所有任意接口。 

#### [!] -f, --fragment 

这意味着在分片的包中，规则只询问第二及以后的片。自那以后由于无法判断这种把包的源端口或目标端口（或者是ICMP类型的），这类包将不能匹配任何指定对他们进行匹配的规则。如果"!"说明用在了"-f"标志之前，表示相反的意思。 



#### --source-port [!] [port[:port]] 

源端口或端口范围指定。这可以是服务名或端口号。使用格式端口：端口也可以指定包含的（端口）范围。如果首端口号被忽略，默认是"0"，如果末端口号被忽略，默认是"65535"，如果第二个端口号大于第一个，那么它们会被交换。这个选项可以使用 --sport的别名。 

#### --destionation-port [!] [port:[port]] 

目标端口或端口范围指定。这个选项可以使用 --dport别名来代替。 

#### --tcp-flags [!] mask comp 

匹配指定的TCP标记。第一个参数是我们要检查的标记，一个用逗号分开的列表，第二个参数是用逗号分开的标记表,是必须被设置的。标记如下：SYN ACK FIN RST URG PSH ALL NONE。因此这条命令：iptables -A FORWARD -p tcp --tcp-flags SYN, ACK, FIN, RST SYN只匹配那些SYN标记被设置而ACK、FIN和RST标记没有设置的包。 

#### [!] --syn 

只匹配那些设置了SYN位而清除了ACK和FIN位的TCP包。这些包用于TCP连接初始化时发出请求；例如，大量的这种包进入一个接口发生堵塞时会阻止进入的TCP连接，而出去的TCP连接不会受到影响。这等于 --tcp-flags SYN, RST, ACK SYN。如果"--syn"前面有"!"标记，表示相反的意思。 

#### --tcp-option [!] number 

匹配设置了TCP选项的。

## 例子

### 清除已有iptables规则

iptables -F
iptables -X
iptables -Z

### 开放指定的端口

#### 允许本地回环接口(即运行本机访问本机)

	iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT

#### 允许已建立的或相关连的通行

	iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#### 允许所有本机向外的访问

	iptables -A OUTPUT -j ACCEPT

#### 允许访问22端口

	iptables -A INPUT -p tcp --dport 22 -j ACCEPT


#### 屏蔽单个IP的命令是

	iptables -I INPUT -s 123.45.6.7 -j DROP

#### 封整个段即从123.0.0.1到123.255.255.254的命令

	iptables -I INPUT -s 123.0.0.0/8 -j DROP

#### 封IP段即从123.45.0.1到123.45.255.254的命令

	iptables -I INPUT -s 124.45.0.0/16 -j DROP

#### 封IP段即从123.45.6.1到123.45.6.254的命令是

	iptables -I INPUT -s 123.45.6.0/24 -j DROP

#### 查看已添加的iptables规则

	iptables -L -n

参数:

- v：显示详细信息，包括每条规则的匹配包数量和匹配字节数
- x：在 v 的基础上，禁止自动单位换算（K、M） vps侦探
- n：只显示IP地址和端口号，不将ip解析为域名

#### 删除已添加的iptables规则

将所有iptables以序号标记显示，执行：

	iptables -L -n --line-numbers

比如要删除INPUT里序号为8的规则，执行：

	iptables -D INPUT 8

#### iptables的开机启动及规则保存

CentOS上可能会存在安装好iptables后，iptables并不开机自启动，可以执行一下：

chkconfig --level 345 iptables on
