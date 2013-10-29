---
layout: post
title: "如何将定制的cls加入TEXMFHOME"
tagline: "How to add custom cls to TEXMFHOME"
description: ""
category: LATEX
tags: []
---
{% include JB/setup %}

I have a .cls file that I would like all of my .tex file to use it. The following is the detailed steps:

### Check the TEXMFHOME


	C:\Documents and Settings\Edwin>tlmgr conf
	=========================== version information ==========================
	tlmgr revision 30643 (2013-05-23 01:55:59 +0200)
	tlmgr using installation: C:/texlive/2013
	TeX Live (http://tug.org/texlive) version 2013
	....
	=========================== kpathsea variables ===========================
	TEXMFMAIN=C:/texlive/2013/texmf-dist
	TEXMFDIST=C:/texlive/2013/texmf-dist
	TEXMFLOCAL=C:/texlive/2013/../texmf-local
	TEXMFSYSVAR=C:/texlive/2013/texmf-var
	TEXMFSYSCONFIG=C:/texlive/2013/texmf-config
	TEXMFVAR=C:/Documents and Settings/Edwin/.texlive2013/texmf-var
	TEXMFCONFIG=C:/Documents and Settings/Edwin/.texlive2013/texmf-config
	TEXMFHOME=C:/Documents and Settings/Edwin/texmf
	VARTEXFONTS=C:/Documents and Settings/Edwin/.texlive2013/texmf-var/fonts
	....
	==== kpathsea variables from environment only (ok if no output here) ====

### Create the TEXMFHOME of texmf and copy file

	C:\Documents and Settings\Edwin\texmf\tex\latex|my_article.cls

then copy your cls file to the path

### Make LaTeX see local texmf tree

	C:\Documents and Settings\Edwin>mktexlsr
	
	mktexlsr: Updating C:/texlive/2013/texmf-config/ls-R...
	mktexlsr: Updated C:/texlive/2013/texmf-config/ls-R.
	mktexlsr: Updating C:/texlive/2013/texmf-var/ls-R...
	mktexlsr: Updated C:/texlive/2013/texmf-var/ls-R.
	mktexlsr: Updating C:/texlive/2013/../texmf-local/ls-R...
	mktexlsr: Updated C:/texlive/2013/../texmf-local/ls-R.
	mktexlsr: Updating C:/texlive/2013/texmf-dist/ls-R...

### Test

	d:\workspace\latex article.tex

	This is pdfTeX, Version 3.1415926-2.5-1.40.14 (TeX Live 2013/W32TeX)
	 restricted \write18 enabled.
	entering extended mode
	(./article.tex
	LaTeX2e <2011/06/27>
	Babel <3.9f> and hyphenation patterns for 78 languages loaded.
	(c:/Documents and Settings/Edwin/texmf/tex/latex/my_article.cls

