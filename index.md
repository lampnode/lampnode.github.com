---
layout: page
title: Welcome to LAMPNode
tagline: Focus On LAMP Technologies
---
{% include JB/setup %}

## Last updated

<ul class="lastUpdated">
    {% for post in site.posts limit 4 %}
     <li><dl class="lastUpdatedItem">
	<dt><span class="lastUpdatedDate">{{ post.date | date_to_string }}</span>  <a class="lastUpdatedTitle"  href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></dt>
       <dd> {{ post.content | strip_html | truncatewords:75}}
            <a href="{{ post.url }}">Read more...</a></dd>
      </dl></li>
    {% endfor %}
</ul>

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




