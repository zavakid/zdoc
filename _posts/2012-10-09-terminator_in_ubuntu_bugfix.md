---
layout: post
title: terminator在ubuntu下有僵尸进程的解决
categories:
  linux
  efficiency
tags:
- life
- Linux
- terminator
- Ubuntu
---

之前用一篇文章介绍了一个非常好用的软件：<a href="{% post_url 2012-05-05-using_terminator %}">terminator</a>。但在我使用了一段时间之后，发现每当我启动 terminator 的时候，都会有一个僵尸进程存在，于是搜索了一番，最后找到这个  <a href="https://bugs.launchpad.net/terminator/+bug/885606">terminator 的 bug</a>。

仔细查看一番，原来是路径找不到的path，按照连接中讨论的方案，修复也非常简单。

{% hl bash %}
cd /use/lib
sudo ln -s libvte9 vte
{% endhl %}

就是这么简单。


