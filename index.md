---
layout: page
title: 说者无意
tagline: 代码如诗
description: xxxx
---
{% include JB/setup %}

# 欢迎来到说者无意

下面是最近最新的文章：

<ul class="posts circle">
  {% for post in site.posts %}
    <li><small>{{ post.date | date_to_standard }}</small>  <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

