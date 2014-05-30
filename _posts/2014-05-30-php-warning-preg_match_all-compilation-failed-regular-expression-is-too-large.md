---
layout: post
title: "PHP Warning: preg_match_all(): Compilation failed: regular expression is too large"
tagline: "PHP Warning: preg_match_all(): Compilation failed: regular expression is too large"
description: ""
category: PHP 
tags: [ PHP Warning ]
---
{% include JB/setup %}

The purpose of this documents is describe how to fix php errors.

## PHP Error

	Warning: preg_match_all(): Compilation failed: regular expression is too large at offset 707830

In Zend framework:

	Warning:preg_match() [function.preg-match]: Compilation failed: regular expression is too large at offset 156184 /opt/web/jourcore/core/lib/Zend/Validate/Hostname.php [615 ]

***NOTE:*** This error occurred when parsing a wrong email address (e.g. "user@ example.com", there are a  space between "@" and "example.com" )

## Howto fix it

Update the pcre.backtrack nad pcre.recursion limit may fix this problem.

	[Pcre]
	;PCRE library backtracking limit.
	pcre.backtrack_limit=100000
 
	;PCRE library recursion limit.
	;Please note that if you set this value to a high number you may consume all
	;the available process stack and eventually crash PHP (due to reaching the
	;stack size limit imposed by the Operating System).
	pcre.recursion_limit=100000


