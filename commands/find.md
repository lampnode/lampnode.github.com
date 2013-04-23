---
layout: page
title: "find"
description: ""
---
{% include JB/setup %}

## 使用范围

find命令是一个无处不在命令，是linux中最有用的命令之一。find命令用于：在一个目录（及子目录）中搜索文件，你可以指定一些匹配条件，如按文件名、文件类型、用户甚至是时间戳查找文件

## 格式

	find [-H] [-L] [-P] [-D debugopts] [-Olevel] [path...] [expression]

上面的find命令的常用形式可以简化为：

	find [path...] [expression]

- path：find命令所查找的目录路径。例如用.来表示当前目录，用/来表示系统根目录
- expression：expression可以分为——“-options [-print -exec -ok ...]”

### 参数

#### -print

find命令将匹配的文件输出到标准输出

#### -exec

find命令对匹配的文件执行该参数所给出的shell命令。相应命令的形式为
	
	'command' {  } \;

注意{   }和\；之间的空格 

	find ./ -size 0 -exec rm {} \;
 
删除文件大小为零的文件。

为了用ls -l命令列出所匹配到的文件，可以把ls -l命令放在find命令的-exec选项中：

	find . -type f -exec ls -l {  } \; 

在/logs目录中查找更改时间在5日以前的文件并删除它们：

	find /logs -type f -mtime +5 -exec rm {  } \;
#### -ok

和-exec的作用相同，只不过以一种更为安全的模式来执行该参数所给出的shell命令，在执行每一个命令之前，都会给出提示，让用户来确定是否执行。 

	find . -name "*.conf"  -mtime +5 -ok rm {  } \; 

在当前目录中查找所有文件名以.LOG结尾、更改时间在5日以上的文件，并删除它们，只不过在删除之前先给出提示
	

## 常用选项及实例

#### -name 
按照文件名查找文件。 

	find /dir -name filename  

在/dir目录及其子目录下面查找名字为filename的文件 
	find . -name "*.c" 

在当前目录及其子目录（用“.”表示）中查找任何扩展名为“c”的文件

#### -perm 
按照文件权限来查找文件。 

	find . -perm 755 –print 在

当前目录下查找文件权限位为755的文件，即文件属主可以读、写、执行，其他用户可以读、执行的文件

#### -prune 
使用这一选项可以使find命令不在当前指定的目录中查找，如果同时使用-depth选项，那么-prune将被find命令忽略。 

	find /apps -path "/apps/bin" -prune -o –print 在

/apps目录下查找文件，但不希望在/apps/bin目录下查找 

	find /usr/sam -path "/usr/sam/dir1" -prune -o –print 在

/usr/sam目录下查找不在dir1子目录之内的所有文件

#### -user 
按照文件属主来查找文件。 

	find ~ -user sam –print 

在$HOME目录中查找文件属主为sam的文件

#### -group 
按照文件所属的组来查找文件。 

	find /apps -group gem –print 

在/apps目录下查找属于gem用户组的文件 

#### -mtime -n +n 

按照文件的更改时间来查找文件， - n表示文件更改时间距现在n天以内，+ n表示文件更改时间距现在n天以前。 

	find / -mtime -5 –print 
	
在系统根目录下查找更改时间在5日以内的文件 
	
	find /var/adm -mtime +3 –print 

在/var/adm目录下查找更改时间在3日以前的文件

#### -nogroup 

查找无有效所属组的文件，即该文件所属的组在/etc/groups中不存在。 

find / –nogroup -print

#### -nouser 
查找无有效属主的文件，即该文件的属主在/etc/passwd中不存在。 

find /home -nouser –print
-newer file1 ! file2 

查找更改时间比文件file1新但比文件file2旧的文件。

#### -type 
查找某一类型的文件，诸如： 

* b - 块设备文件。 
* d - 目录。 
* c - 字符设备文件。 
* p - 管道文件。 
* l - 符号链接文件。 
* f - 普通文件。 
* find /etc -type d –print 在/etc目录下查找所有的目录 
* find . ! -type d –print 在当前目录下查找除目录以外的所有类型的文件 
* find /etc -type l –print 在/etc目录下查找所有的符号链接文件
* -size n：[c] 查找文件长度为n块的文件，带有c时表示文件长度以字节计。 


	find . -size +1000000c –print 

在当前目录下查找文件长度大于1 M字节的文件 
	
	find /home/apache -size 100c –print 

在/home/apache目录下查找文件长度恰好为100字节的文件 

	find . -size +10 –print 

在当前目录下查找长度超过10块的文件（一块等于512字节）

#### -depth

在查找文件时，首先查找当前目录中的文件，然后再在其子目录中查找。 

	find / -name "CON.FILE" -depth –print 

它将首先匹配所有的文件然后再进入子目录中查找 

#### -mount

在查找文件时不跨越文件系统mount点。  

find . -name "*.XC" -mount –print 

从当前目录开始查找位于本文件系统中文件名以XC结尾的文件（不进入其他文件系统）

#### -follow

如果find命令遇到符号链接文件，就跟踪至链接所指向的文件。


### find与xargs

在使用find命令的-exec选项处理匹配到的文件时， find命令将所有匹配到的文件一起传递给exec执行。但有些系统对能够传递给exec的命令长度有限制，这样在find命令运行几分钟之后，就会出现溢出错误。错误信息通常是“参数列太长”或“参数列溢出”。这就是xargs命令的用处所在，特别是与find命令一起使用。


find命令把匹配到的文件传递给xargs命令，而xargs命令每次只获取一部分文件而不是全部，不像-exec选项那样。这样它可以先处理最先获取的一部分文件，然后是下一批，并如此继续下去。

在有些系统中，使用-exec选项会为处理每一个匹配到的文件而发起一个相应的进程，并非将匹配到的文件全部作为参数一次执行；这样在有些情况下就会出现进程过多，系统性能下降的问题，因而效率不高；

而使用xargs命令则只有一个进程。另外，在使用xargs命令时，究竟是一次获取所有的参数，还是分批取得参数，以及每一次获取参数的数目都会根据该命令的选项及系统内核中相应的可调参数来确定。

来看看xargs命令是如何同find命令一起使用的，并给出一些例子。

	find . -type f -print | xargs file 

查找系统中的每一个普通文件，然后使用xargs命令来测试它们分别属于哪类文件

	find / -name "core" -print | xargs echo "" >/tmp/core.log

 在整个系统中查找内存信息转储文件(core dump) ，然后把结果保存到/tmp/core.log 文件中：

	find . -type f -print | xargs grep "hostname"

 用grep命令在所有的普通文件中搜索hostname这个词

	find ./ -mtime +3 -print|xargs rm -f –r 

删除3天以前的所有东西 （find . -ctime +3 -exec rm -rf {} \;）

	find ./ -size 0 | xargs rm -f &

 删除文件大小为零的文件

find命令配合使用exec和xargs可以使用户对所匹配到的文件执行几乎所有的命令。

