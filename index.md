---
layout: page
title: Welcome to LAMPNode
tagline: Focus On LAMP Technologies
---
{% include JB/setup %}

## Last updated

<ul >
    {% for post in site.posts limit 4 %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
        {{ post.content | strip_html | truncatewords:75}}<br>
            <a href="{{ post.url }}">Read more...</a><br><br>
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




