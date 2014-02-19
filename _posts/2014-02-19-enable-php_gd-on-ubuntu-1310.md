---
layout: post
title: "Enable php_GD on Ubuntu 13.10"
tagline: "Enable php_GD on Ubuntu 13.10"
description: ""
category: PHP
tags: [PHP, Ubuntu]
---
{% include JB/setup %}

The php_gd is not enabled on Ubuntu after install apache server. 

## Condition

	sudo apt-get install lamp-server^

## Steps

### install php5_gd

	sudo apt-get install php5-gd
	sudo /etc/init.d/apache restart

### Test

{% highlight java%}
	<?php
    	header("Content-type:image/png");
    	$im= imagecreatetruecolor(300, 200);
    	$bg_color=  imagecolorallocate($im, 0, 0, 0);
    	$text_color= imagecolorallocate($im, 23, 14, 91);
    	imagestring($im, 1, 5, 5,"A Simple Text String", $text_color);
    	imagepng($im);
    	imagedestroy($im);
	?>
{%endhighlight%}
