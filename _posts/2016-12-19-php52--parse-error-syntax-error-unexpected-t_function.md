---
layout: post
title: "PHP5.2  Parse error: syntax error, unexpected T_FUNCTION"
tagline: "PHP5.2  Parse error: syntax error, unexpected T_FUNCTION"
description: ""
category: 
tags: [ PHP ]
---
{% include JB/setup %}

When I update my PHP software, I have the following error:

    PHP Parse error:  syntax error, unexpected T_FUNCTION in /var/www/html/aa.php on line 210

The error is likely caused by

    return preg_replace_callback($e, function($v) use ($s,$r) { return $r[$v[1]];  },$sql);

Chances are you're using PHP 5.2 or earlier, which doesn't support closures. 

