---
layout: page
title: "Vim"
description: ""
---
{% include JB/setup %}
<h1>Linx Editor : VI(M)</h1>
<h2>Vim Help Sheet</h2>
<div class="contentMainBox">
<h3> Modes and Controls </h3>
<ul>
<li>Command Mode: ESC</li>
<li>Insertion Mode</li>
</ul>

<h3>Basic commands</h3>
<ul>
<li><b>:w</b>Save</li>
<li><b>:x</b>Save and exit</li>
<li><b>:q</b>Quit if no changes made</li>
<li><b>:q!</b>Quit and discard any changes</li>
<li><b>u</b>Undo last change</li>
<li><b>U</b>Undow all changes to line</li>
<li><b>.</b>Repeat last command</li>
</ul>

<h3>Cursor Navigation</h3>
<ul>
<li><b>h or arrow left </b> Cursor left</li>
<li><b>j or arrow down </b> Cursor down</li>
<li><b>k or arrow up   </b>Cursor up</li>
<li><b>l or arrow right</b> Cursor right</li>
<li><b>w </b>Next word</li>
<li><b>W </b>	Next blank delimited word</li>
<li><b>b </b>	Start of word</li>
<li><b>B </b>	Start of blank delimited word</li>
<li><b>e </b>	End of word</li>
<li><b>E </b>	End of blank delimited word</li>
<li><b>( </b>	Back a sentence</li>
<li><b>) </b>	Forword a sentence</li>
<li><b>{ </b>	Back a paragraph</li>
<li><b>} </b>	Forword a paragraph</li>
<li><b>0 </b>	Beginning of current line</li>
<li><b>$ </b>	End of the current line</li>
<li><b>H </b>   Top of screen</li>
<li><b>M </b> 	Middle of screen</li>
<li><b>L </b>   Bottom of screen</li>
</ul>
</div>    

<div class="contentMainBox">
<h3>Insert Text</h3>
<ul>
<li><b>i</b>Insert before cursor</li>
<li><b>a</b>Append after cursor</li>
<li><b>I</b>Insert before line</li>
<li><b>A</b>Append after line</li>
<li><b>o</b>Add a new line after current line</li>
<li><b>O</b>Add a new line before current line</li>
<li><b>r</b>Overwrite one character</li>
<li><b>R</b>Overwrite many character</li>
<li><b>:r FILE_NAME </b>Reads file and insert it after this line</li>
</ul>

<h3>Deleting Text</h3>
<ul>
<li><b>x</b>Delete character to right of cursor</li>
<li><b>X</b>Delete character to left of cursor</li>
<li><b>D</b>Delete the rest of line</li>
<li><b>dd or :d</b>Delete the current line</li>
</ul>

<h3>Searching</h3>
<ul>
<li><b>/string</b>Search forword for string</li>
<li><b>?string</b>Search backword for string</li>
<li><b>n</b>Go to the next match</li>
<li><b>N</b>Go to the previous match</li>
<li><b>:set nu</b>Turn on the line numbers</li>
</ul>
</div>
