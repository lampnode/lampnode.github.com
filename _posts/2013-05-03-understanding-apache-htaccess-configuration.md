---
layout: post
title: "理解Apache htaccess配置"
tagline: "Understanding Apache htaccess configuration"
description: ""
category: Apache
tags: [ Linux, Apache ]
---
{% include JB/setup %}

.htaccess文件是Apache服务器上的一个设置文件。它提供了针对目录改变配置的方法，以作用于此目录及其所有子目录。.htaccess的功能包括

- 设置网页密码
- 设置发生错误时出现的文件
- 改变首页的文件名,如index.html
- 禁止读取文件名、重新导向文件
- 加上MIME类别、禁止列目录下的文件

在需要针对目录改变服务器的配置，而对服务器系统没有root权限时，应该使用.htaccess文件.

每一个放置.htaccess的目录和其子目录都会被.htaccess影响。例如，在/abc/目录下放置了一个.htaccess文件，那么/abc/和 /abc/def/内所有的文件都会被它影响，但/index.html不会被它影响，这一点是很重要的。

*** 注意：*** 

- 修改.htaccess文件无需重新启动Apache服务器，而是立即生效。
- 在可能的情况下应该尽量避免使用.htaccess文件，因为使用.htaccess文件会降低服务器的运行性能。


## 配置方法

### 安全配置

在主配置文件中的启用并控制对.htaccess文件的使用：必须保证在主配置文件中包含如下的配置语句：

	AccessFileName .htaccess
	<Files ~ “^\.htaccess”>
		Order allow,deny
		Deny from all
	</Files>

### 设置目录属性

例如要对 /var/www/html/private 目录使用.htaccess


	<Directory "/var/www/html/private">
		...
		AllowOverride All
		...
	</Directory>

### 设置文件

	#cd /var/www/html
	#mkdir private
	#cd private
	#touch .htaccess
        #chmod 644 .htaccess

在.htaccess中添加需要的内容。

### 重启服务器

由于设置过程中修改了主配置文件，这里需要重启服务器
	#/etc/init.d/httpd restart

### 配置规则

rewrite engine会对每条rewrite规则进行解析，每条rewrite规则可以带或不带rewrite condition, 带的话写在该条rewrite规则之前。如果rewrite规则符合，会进一步检查rewrite condition.具体处理如下：

- 首先匹配rewrite的patern，若不匹配则进入下一条rewrite rule。
- 如果匹配，则mod_rewrite检查rewrite condition, 如果没有condition，则新的string将替换url，然后进入下一条rewrite rule.
- 如果rewrite condition存在，则按顺序检查conditions。 Condition的 匹配并不是对url的，而是针对扩展变量等。conditons之间默认是AND的关系，也就是说conditon只要有一条不匹配，则退出匹配；当一条 条件被匹配后，则检查下一条，直到不匹配为止，如果所有条件匹配，替换就会进行。
- 测试条件：-f文件存在；-d目录存在；-l是链接文件(symbol link)；-s文件大小非0

#### rewrite rule的参数

语法: 

	RewriteCond TestString CondPattern

例如

	RewriteCond %{HTTP_HOST} ^www.example.net [NC]


- TestString是一个纯文本的字符串，但是可以包含可扩展的成分
- CondPattern是条件pattern, 即一个应用于当前实例TestString的正则表达式, 即TestString将会被计算然后与CondPattern匹配.
- 另外,还可以为CondPattern追加特殊的标记[flags] 作为RewriteCond指令的第三个参数。Flags是一个以逗号分隔的以下标记的列表：
--  'nocase|NC' 它使测试忽略大小写, 即TestString和CondPattern无大小写检查
--  'ornext|OR' 它以OR方式组合若干规则的条件，而不是隐含的AND。

#### RewriteRule 指令
语法：

	RewriteRule Pattern Substitution

例如：

	RewriteRule ^(.*)$ http://www.9med.net/$1 [R=permanent,L]

- Pattern是一个作用于当前URL的兼容perl的正则表达式. 这里的 "当前" 是指该规则生效时的URL的值。
- Substitution是，当原始URL与Pattern相匹配时，用以替代(或替换)的字符串。

此外，Substitution还可以追加特殊标记[flags]  作为RewriteRule指令的第三个参数。 Flags是一个包含以逗号分隔的下列标记的列表:

##### redirect|R [=code]

(强制重定向 redirect) 以 
	http://thishost[:thisport]/(使新的URL成为一个URI) 
	
为前缀的Substitution可以强制性执行一个外部重定向。 如果code没有指定，则产生一个HTTP响应代码302(临时性移动)。 如果需要使用在300-400范围内的其他响应代码，只需在此指定这个数值即可， 另外，还可以使用下列符号名称之一: temp (默认的), permanent, seeother. 用它可以把规范化的URL反馈给客户端，如, 重写"/~"为 "/u/"，或对/u/user加上斜杠，等等。

*** 注意: *** 在使用这个标记时，必须确保该替换字段是一个有效的URL! 否则，它会指向一个无效的位置! 并且要记住，此标记本身只是对URL加上 

	http://thishost[:thisport]/的前缀，重写操作仍然会继续。 
	
通常，你会希望停止重写操作而立即重定向，则还需要使用'L'标记.

##### forbidden|F (强制URL为被禁止的 forbidden)

强制当前URL为被禁止的，即，立即反馈一个HTTP响应代码403(被禁止的)。 使用这个标记，可以链接若干RewriteConds以有条件地阻塞某些URL。

##### gone|G (强制URL为已废弃的 gone)

强制当前URL为已废弃的，即，立即反馈一个HTTP响应代码410(已废弃的)。 使用这个标记，可以标明页面已经被废弃而不存在了.

##### proxy|P (强制为代理 proxy)

此标记使替换成分被内部地强制为代理请求，并立即(即， 重写规则处理立即中断)把处理移交给代理模块。 你必须确保此替换串是一个有效的(比如常见的以 http://hostname开头的)能够为Apache代理模块所处理的URI。 使用这个标记，可以把某些远程成分映射到本地服务器名称空间， 从而增强了ProxyPass指令的功能。

*** 注意: *** 要使用这个功能，代理模块必须编译在Apache服务器中。 如果你不能确定，可以检查"httpd -l"的输出中是否有mod_proxy.c。 如果有，则mod_rewrite可以使用这个功能； 如果没有，则必须启用mod_proxy并重新编译"httpd"程序。

##### last|L (最后一个规则 last)

立即停止重写操作，并不再应用其他重写规则。 它对应于Perl中的last命令或C语言中的break命令。 这个标记可以阻止当前已被重写的URL为其后继的规则所重写。 举例，使用它可以重写根路径的URL('/')为实际存在的URL, 比如, '/e/www/'.

##### next|N (重新执行 next round)

重新执行重写操作(从第一个规则重新开始). 这时再次进行处理的URL已经不是原始的URL了，而是经最后一个重写规则处理的URL。 它对应于Perl中的next命令或C语言中的continue命令。 此标记可以重新开始重写操作，即, 立即回到循环的头部。但是要小心，不要制造死循环!

##### chain|C (与下一个规则相链接 chained)

此标记使当前规则与下一个(其本身又可以与其后继规则相链接的， 并可以如此反复的)规则相链接。 它产生这样一个效果: 如果一个规则被匹配，通常会继续处理其后继规则， 即，这个标记不起作用；如果规则不能被匹配， 则其后继的链接的规则会被忽略。比如，在执行一个外部重定向时， 对一个目录级规则集，你可能需要删除".www"(此处不应该出现".www"的)。

##### type|T=MIME-type (强制MIME类型 type)

强制目标文件的MIME类型为MIME-type。 比如，它可以用于模拟mod_alias中的ScriptAlias指令， 以内部地强制被映射目录中的所有文件的MIME类型为"application/x-httpd-cgi".

##### nosubreq|NS (仅用于不对内部子请求进行处理 no internal sub-request)

在当前请求是一个内部子请求时，此标记强制重写引擎跳过该重写规则。 比如，在mod_include试图搜索可能的目录默认文件(index.xxx)时， Apache会内部地产生子请求。对子请求，它不一定有用的，而且如果整个规则集都起作用， 它甚至可能会引发错误。所以，可以用这个标记来排除某些规则。根据你的需要遵循以下原则: 如果你使用了有CGI脚本的URL前缀，以强制它们由CGI脚本处理， 而对子请求处理的出错率(或者开销)很高，在这种情况下，可以使用这个标记。

##### nocase|NC (忽略大小写 no case)

它使Pattern忽略大小写，即, 在Pattern与当前URL匹配时，'A-Z' 和'a-z'没有区别。

##### qsappend|QSA (追加请求串 query string append)

此标记强制重写引擎在已有的替换串中追加一个请求串，而不是简单的替换。 如果需要通过重写规则在请求串中增加信息，就可以使用这个标记。

##### noescape|NE (在输出中不对URI作转义 no URI escaping)

此标记阻止mod_rewrite对重写结果应用常规的URI转义规则。 一般情况下，特殊字符(如'%', '$', ';'等)会被转义为等值的十六进制编码。 此标记可以阻止这样的转义，以允许百分号等符号出现在输出中，如：

	RewriteRule /foo/(.*) /bar?arg=P1%3d$1 [R,NE]

可以使'/foo/zed'转向到一个安全的请求'/bar?arg=P1=zed'.

##### passthrough|PT (移交给下一个处理器 pass through)

此标记强制重写引擎将内部结构request_rec中的uri字段设置为 filename字段的值，它只是一个小修改，使之能对来自其他URI到文件名翻译器的 Alias，ScriptAlias, Redirect 等指令的输出进行后续处理。举一个能说明其含义的例子： 如果要通过mod_rewrite的重写引擎重写/abc为/def， 然后通过mod_alias使/def转变为/ghi，可以这样:

	RewriteRule ^/abc(.*) /def$1 [PT]
	Alias /def /ghi

如果省略了PT标记，虽然mod_rewrite运作正常， 即, 作为一个使用API的URI到文件名翻译器， 它可以重写uri=/abc/…为filename=/def/...， 但是，后续的mod_alias在试图作URI到文件名的翻译时，则会失效。

*** 注意: *** 如果需要混合使用不同的包含URI到文件名翻译器的模块时， 就必须使用这个标记。。 混合使用mod_alias和mod_rewrite就是个典型的例子。

##### skip|S=num (跳过后继的规则 skip)

此标记强制重写引擎跳过当前匹配规则后继的num个规则。 它可以实现一个伪if-then-else的构造: 最后一个规则是then从句，而被跳过的skip=N个规则是else从句. (它和'chain|C'标记是不同的!)

##### env|E=VAR:VAL (设置环境变量 environment variable)

此标记使环境变量VAR的值为VAL, VAL可以包含可扩展的反向引用的正则表达式$N和%N。 此标记可以多次使用以设置多个变量。 这些变量可以在其后许多情况下被间接引用，但通常是在XSSI (via <!–#echo var="VAR"–>) or CGI (如 $ENV{'VAR'})中， 也可以在后继的RewriteCond指令的pattern中通过%{ENV:VAR}作引用。 使用它可以从URL中剥离并记住一些信息。

'cookie|CO=NAME:VAL:domain[:lifetime[:path]]' (设置cookie)
它在客户端浏览器上设置一个cookie。 cookie的名称是NAME，其值是VAL。 domain字段是该cookie的域，比如'.apache.org', 可选的lifetime是cookie生命期的分钟数， 可选的path是cookie的路径。
其实apache手册中有 http://man.chinaunix.net/newsoft/ApacheManual/mod/mod_rewrite.html

apache的官方rewrite guide 举例，以下是wordpress的rewrite的.htaccess:

	# BEGIN WordPress
	RewriteEngine On
	RewriteBase /
	#把learndiary.com的网址全部重定向到www.learndiary.com下
	RewriteCond %{HTTP_HOST} ^learndiary.com [NC]
	RewriteRule ^(.*)$ http://www.learndiary.com/$1 [L,R=301]
	#除开*.do形式的URL（必须）
	RewriteCond %{REQUEST_FILENAME} !-f
	RewriteCond %{REQUEST_FILENAME} !-d
	RewriteCond %{REQUEST_URI} !.+.do
	RewriteRule . /index.php [L]


### 配置案例

- 参看 [Apache .htaccess配置例子](/Apache/apache-htaccess-configuration-examples/)
