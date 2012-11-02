---
layout: post
title: terminator的高效使用
categories:
  efficiency
tags:
- life
- Linux
- terminator
- Ubuntu
- 效率
---

平时使用的是 ubuntu，难免就需要经常使用终端，之前一直用的是 ubuntu 自带的终端。后来找到了 terminator 这款非常不错的终端软件。（ <a href="http://software.jessies.org/terminator/">官方地址</a> ）

刚刚接触一款新的软件，使用上肯定比之前的慢。不过经过10分钟的使用，我发现 terminator 很容易上手，而且使用上非常方便，以致于我决定以后不管是在个人还是在公司的电脑上，都要慢慢的使用这款软，以提高自己的工作效率。

ubuntu 默认的终端 —— gnome-terminal，只有 tab 这一概念，并且支持以 <code>alt + 数字</code> 的快捷键对 tab 进行切换；同时，还可以使用 <code>ctrl+shift+t</code> 的快捷方式新建 tab。并且，还有 bash 中 readline 默认提供的 emacs 快捷键（当然，你也可以设置成 vi mode，想想可以用 vi 模式在 sh 下操作的快感吧 :-) ）。

不过，所有 gnome-terminal 有的功能， terminator 都有。出此之外，terminator 还提供了一些很方便的功能：

<ul>
<li>允许在一个 tab 中打开多个终端 —— 这个可以满足我一边 <code>man</code> 一个命令，一边练习</li>
<li>允许同时操作多个终端 —— 这个功能使用的场景不多。但可以想象，如果你同时操作多台服务器，倒可以使用使用。先<code>cd</code>回到HOME，然后就进行自己的命令了。</li>
</ul>

terminator默认的快捷键没有<code>alt+number</code>，所以我自己设置了一份快捷键，并放在了：<a href="https://github.com/zavakid/terminator-config">github terminator config</a> 上，欢迎大家fork之。另外关于 terminator 的僵尸进程问题，已有解决方案，<a href="{% post_url 2012-10-09-terminator_in_ubuntu_bugfix %}">详见这里</a>。

下面是使用的几张截图：

<img src="http://pic.yupoo.com/zavakid/BXuv7KOo/medium.jpg" alt="同一tab下多个终端" />

<img src="http://pic.yupoo.com/zavakid/BXuvasam/medium.jpg" alt="广播命令，同时操作多个终端" />


