---
layout: page
title: Hello World!
tagline: Supporting tagline
---
{% include JB/setup %}

<p>
Here's a sample "posts list".
asdfadf
adsfa
df<br/>
adfasdfa

<ul class="posts circle">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

</p>
