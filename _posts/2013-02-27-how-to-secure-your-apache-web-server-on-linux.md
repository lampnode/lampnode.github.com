---
layout: post
title: "如何增强Linux Apache Web服务器的安全"
tagline: "How to Secure Your Apache Web Server on Linux"
description: ""
category: Linux
tags: [ Apache ]
---
{% include JB/setup %}

## 以单独的用户和用户组运行Apache

Apache默认地以nobody或daemon运行。让Apache运行在自己没有特权的帐户比较好。例如：用户apache。

### 创建apache用户

	useradd webuser

### 更改httpd.conf，正确地设置User和Group。

	vi httpd.conf

修改如下

	User webuser
	Group webuser

## 限制访问根目录（使用Allow和Deny）

在httpd.conf文件按如下设置来增强根目录的安全。

{% highlight xml %}
	<Directory />
    		Options None
    		Order deny,allow
    		Deny from all
	</Directory>
{% endhighlight %} 
在上面的：

- Options None –设置这个为None，是指不激活其它可有可无的功能。
- Order deny,allow – 这个是指定处理Deny和Allow的顺序。
- Deny from all –阻止所有请求。Deny的后面没有Allow指令，所以没人能允许访问。

## 禁止目录浏览

如果你不关闭目录浏览，用户就能看到你的根目录（或任何子目录）所有的文件（目录）。为了禁止目录浏览，你可以设置Opitons指令为“None“或者是“-Indexes”。在选项名前加“-”会强制性地在该目录删除这个特性。.
Indexes选项会在浏览器显示可用文件的列表和子目录（当没有默认首页在这个目录）。所以Indexes应该禁用。

{% highlight xml %}
<Directory />
  Options None
  Order allow,deny
  Allow from all
</Directory>
{% endhighlight %} 
(or)

{% highlight xml %}
<Directory />
  Options -Indexes
  Order allow,deny
  Allow from all
</Directory>
{% endhighlight %}

## 禁用.htaccess
在htdocs目录下的特定子目录下使用.htaccess文件，用户能覆盖默认apache指令。在一些情况下，这样不好，应该禁用这个功能。
我们可以在配置文件中按如下设置禁用.htaccess文件来不允许覆盖apache默认配置。

{% highlight xml %}
<Directory />
  Options None
  AllowOverride None
  Order allow,deny
  Allow from all
</Directory>
{% endhighlight %}

7、禁用其它选项
下面是一些Options指令的可用值。

Options All –所有的选项被激活（除了MultiViews）。如果你不指定Options指令，这个是默认值。
Options ExecCGI –执行CGI脚本（使用mod_cgi）。
Options FollowSymLinks –如果在当前目录有符号链接，它将会被跟随。
Options Includes –允许服务器端包含文件（使用mod_include）。
Options IncludesNOEXEC –允许服务器端包含文件但不执行命令或cgi。
Options Indexes –允许目录列表。
Options MultiViews -允许内容协商多重视图（使用mod_negotiation）
Options SymLinksIfOwnerMatch – 跟FollowSymLinks类似。但是要当符号连接和被连接的原始目录是同一所有者是才被允许。
绝不要指定“Options All”，通常指定上面的一个或多个的选项。你可以按下面代码把多个选项连接。
Options Includes FollowSymLinks
当你要嵌入多个Directory指令时，“+”和“-”是有用处的。也有可能会覆盖上面的Directory指令。
如下面，/site目录，允许Includes和Indexes。

{% highlight xml %}
<Directory /site>
  Options Includes Indexes
  AllowOverride None
  Order allow,deny
  Allow from all
</Directory>
{% endhighlight %}

对于/site/en目录，如果你需要继承/site目录的Indexes（不允许Includes），而且只在这个目录允许FollowSymLinks，如下：

{% highlight xml %}
<Directory /site/en>
  Options -Includes +FollowSymLink
  AllowOverride None
  Order allow,deny
  Allow from all
</Directory>
{% endhighlight %}

/site目录允许IncludeIndexes
/site/en目录允许Indexes和FollowSymLink


## 禁止显示或发送Apache版本信息

默认地，服务器HTTP响应头会包含apache和php版本号。像下面的，这是有危害的，因为这会让黑客通过知道详细的版本号而发起已知该版本的漏洞攻击。

	Server: Apache/2.2.17 (Unix) PHP/5.3.5

为了阻止这个，需要在httpd.conf设置ServerTokens为Prod，这会在响应头中显示“Server:Apache”而不包含任何的版本信息。

	# vi httpd.conf

修改如下选项

	ServerTokens Prod


下面是ServerTokens的一些可能的赋值：

* ServerTokens Prod 显示“Server: Apache”
* ServerTokens Major 显示 “Server: Apache/2″
* ServerTokens Minor 显示“Server: Apache/2.2″
* ServerTokens Min 显示“Server: Apache/2.2.17″
* ServerTokens OS 显示 “Server: Apache/2.2.17 (Unix)”
* ServerTokens Full 显示 “Server: Apache/2.2.17 (Unix) PHP/5.3.5″ (如果你这指定任何的值，这个是默认的返回信息)
