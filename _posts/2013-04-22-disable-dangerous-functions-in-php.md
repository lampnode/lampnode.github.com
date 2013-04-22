---
layout: post
title: "在PHP中禁止高风险的函数"
tagline: "Disable Dangerous Functions in PHP"
description: ""
category: PHP
tags: [ PHP ]
---
{% include JB/setup %}

## 高风险函数介绍

### system()

执行外部程序并显示输出资料。

#### 语法: 

	string system(string command, int [return_var]);

#### 内容说明:

本函数就像是 C 语中的函数 system()，用来执行指令，并输出结果。若是 return_var 参数存在，则执行 command 之后的状态会填入 return_var 中。

### exec()

执行外部程序。

#### 语法 

	string exec(string command, string [array], int [return_var]);

#### 内容说明

本函数执行输入 command 的外部程序或外部指令。它的返回字符串只是外部程序执行后返回的最后一行；若需要完整的返回字符串，可以使用 PassThru() 这个函数。

要是参数 array 存在，command 会将 array 加到参数中执行，若不欲 array 被处理，可以在执行 exec() 之前呼叫 unset()。若是 return_var 跟 array 二个参数都存在，则执行 command 之后的状态会填入 return_var 中。


### shell_exec()

PHP shell_exec() 於 Linux 預設會使用 sh 來執行程式

#### 语法

	string shell_exec ( string cmd)

### passthru()

执行外部程序并显示原始输出

#### 语法

	void passthru ( string command [, int &return_var] )

### popen()

打开进程文件指针，打开一个指向进程的管道，该进程由派生给定的 command 命令执行而产生。

#### 语法

	resource popen ( string $command , string $mode )

### proc_open()

执行命令并打开文件指针，用于输入/输出

#### 语法

	resource proc_open ( string $cmd , array $descriptorspec , array &$pipes [, string $cwd [, array $env [, array $other_options ]]] )

proc_open（）是类似对POPEN（）的，但提供了更大程度的程序执行控制权。

### parse_ini_file()

解析一个配置文件，并以数组的形式返回其中的设置。

#### 语法

	array parse_ini_file ( string $filename [, bool $process_sections = false [, int $scanner_mode = INI_SCANNER_NORMAL ]] )


### show_source()

对文件进行语法高亮显示。此函数是该函数的别名： highlight_file().

#### 语法

	show_source(filename,return)
	

### symlink()

创建一个符号链接,参考[PHP.net-symlink](http://php.net/manual/en/function.symlink.php),关于软链接与硬连接，参考[Understanding Linux symbolic and hard links](/Linux/understanding-linux-symbolic-and-hard-links/)

#### 语法

	bool symlink ( string $target , string $link )

#### PHP符号链接绕过open_basedir安全限制漏洞

PHP的open_basedir功能可以禁止脚本访问所配置的基础目录以外的文件。这个检查是在处理文件的PHP函数在实际的打开调用发生之前执行的。
攻击者可以使用symlink()函数来发动攻击。PHP的symlink()函数要保证符号链接操作的来源和目标都是open_basedir和safe_mode限制所允许的，但攻击者可以使用mkdir()、unlink()及至少两个符号链接将链接指向任意文件。

	mkdir("a/a/a/a/a/a");
   	symlink("a/a/a/a/a/a", "dummy");
   	symlink("dummy/../../../../../../", "xxx");
   	unlink("dummy");
   	symlink(".", "dummy");

## 禁止方法

### 搜索代码，确认存在哪些高风险函数在使用

	find . | grep "php$" | xargs grep -s "eval(" >> /tmp/review.txt
	find . | grep "php$" | xargs grep -s "fopen(" >> /tmp/review.txt 
	find . | grep "php$" | xargs grep -s "passthru(" >> /tmp/review.txt 
	find . | grep "php$" | xargs grep -s "exec(" >> /tmp/review.txt 
	find . | grep "php$" | xargs grep -s "proc_" >> /tmp/review.txt 
	find . | grep "php$" | xargs grep -s "dl(" >> /tmp/review.txt 
	find . | grep "php$" | xargs grep -s "require($" >> /tmp/review.txt
	find . | grep "php$" | xargs grep -s "require_once($" >> /tmp/review.txt
	find . | grep "php$" | xargs grep -s "include($" >> /tmp/review.txt 
	find . | grep "php$" | xargs grep -s "include_once($" >> /tmp/review.txt 
	find . | grep "php$" | xargs grep -s "include($" >> /tmp/review.txt 
	find . | grep "php$" | xargs grep -s "query(" >> /tmp/review.txt

### 设置php.ini

