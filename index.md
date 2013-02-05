---
layout: page
title: Welcome to LAMPNode
tagline: Focus On LAMP Technologies
---
{% include JB/setup %}

## The LAMPnode:A knowledge archives just for the LAMP Developers

The LAMPNode is aimed at the web developers as written by a developer working on LAMP. The site is for a collection of softwares and program languages that I use, with methods of installing and configuration that works better on LAMP. The more I learn, the more I realize how far I have to go still. So please refer to these tutorials as my notes and always investigate further, especially when it comes to your LAMP better! We all start somewhere, so here you can see my growth.

If you find mistakes, have suggestions, and or questions please mail me at robert.c@lampnode.com, thank you!
    
## About LAMP

LAMP is an acronym for asolution stack of free , open source software, originally coined from the first letters of Linux operating system, Apache HTTP Server, MySQL database software and PHP programming language, principal components to build a viable general purpose web server.

### Linux

Linux is a Unix-like computer operating system kernel. Like the other LAMP components, Linux is free open-source software which means the source code is provided with operating system, which can be edited according to specific needs.

### Apache

Apache Web Server project is a free software/open source web server, the most popular in use.

### Mysql

MySQL is a multithreaded, multi-user, SQL database management system (DBMS) now owned by Oracle Corporation with more than eleven million installations.

### PHP

PHP is a widely-used general-purpose scripting language that is especially suited for Web development and can be embedded into HTML.

---

<img src="/images/Linux_logo.gif" style="padding:10px;margin:10px;border:1px solid grey;" />

<img src="/images/Apache-logo.png" style="margin:10px;padding:10px;border:1px solid grey;" />

<img src="/images/Mysql_logo.jpg" style="margin:10px;padding:10px;border:1px solid grey;" />

<img src="/images/Php-logo.gif" style="margin:10px;padding:10px;border:1px solid grey;" />

---

## Software Recommendations

- Mail: Thunderbird
- File Management: VisualSVN Server - FileZilla
- SSH: PuTTY - WinSCP
- Documents Management: Evernote
- System: grub4dos | ext2explore
- IDE: Eclipse
- Server: Tomcat Httpd

------
## Posts List
<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>




