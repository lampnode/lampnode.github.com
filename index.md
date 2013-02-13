---
layout	: index
title	: "首页"
tagline: Focus On LAMP Technologies
---
{% include JB/setup %}

<div class="contentMainBox">
<h2>最新日志 | Updated</h2>
<ul class="lastUpdated">
    {% for post in site.posts limit:6 %}
     <li><dl class="lastUpdatedItem">
       <dt> <a class="lastUpdatedTitle"  href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></dt>
       <dd> <span class="lastUpdatedDate">{{ post.date | date_to_string }}</span> 
            {{ post.content | strip_html | truncatewords:30 }}
            <a href="{{ post.url }}">Read More</a></dd>
      </dl></li>
    {% endfor %}
</ul>
</div>

<div class="contentMainBox">

<div class="contentMainBoxItem" style="margin-top:20px;background-color:#6495ED;color:#ffffff;border-radius: 10px">
	<p style="clear:both;font-size:26px;color:#ffffff;padding:5px 10px;">欢迎来到LAMPNode!</p>
        <p style="clear:both;font-size:18px;color:#cccccc;padding:0px 10px;">Focus On LAMP technologies</p>
	<img src="/images/gravatar_120.png" width="120px" height="120px" style="float:left;background-color:#cccccc;border:1px solid #555555;padding:5px;margin:0px 5px"/>
	<ul>
		<li style="font-size:22px;padding-bottom:10px;">Robert Chain <a href="/atom.xml"><img src="/images/radio_icon.png" /></a></li>
                <li>Beijing, China</li>
                <li>Software Engineer</li>
		<li><a href="#" style="color:#ffffff"><span class="jt_authorEmail">please enable js</span></a></li>
		<li>http://www.lampnode.com</li>
                <li>LAMPNode Since Fed, 2013</li>
                
	</ul>
</div>

<div class="contentMainBoxItem" >
<h3>开源项目 | Open Source Projects </h3>
<ul>
        <li> <b>Framework:</b> 
		<a href="http://framework.zend.com/" target="_blank">Zend Framework</a>
		<a href="http://www.smarty.net/" target="_blank">Smarty</a>
	</li>
</ul>
</div>

<div class="contentMainBoxItem" >
<h3>软件推荐 | Softwares </h3>
<ul>
	<li> <b>Mail:</b> Thunderbird</li>
	<li> <b>File Management:</b> VisualSVN Server - FileZilla</li>
	<li> <b>SSH: </b>PuTTY - WinSCP</li>
	<li> <b>Documents Management:</b> Evernote</li>
	<li> <b>System:</b> grub4dos | ext2explore</li>
	<li> <b>IDE: </b>Eclipse</li>
	<li> <b>Server:</b> Tomcat Httpd</li>
</ul>
</div>



<div class="contentMainBoxItem" >
<h3>开发速查 | Development Help Sheet</h3>
<ul>
	<li><b>Web Design:</b> 
		<a href="/library/colors.html">Web Colors Sheet</a> | 
		<a href="/library/css2.html" target="_blank">CSS2</a> |
		<a href="http://www.elizabethcastro.com/html/extras/xhtml_ref.html" target="_blank">(X)HTML Elements and Attributes</a>
	</li>
	<li><b>Programing:</b><a href="/library/jquery.html">Jquery</a></li>
	<li><b>Code Management:</b> <a href="/library/github.html">GitHub Guide</a></li>
	<li><b>Editors:</b> <a href="/library/vim.html">VI(M)</a></li> 
</ul>
</div>

</div>

