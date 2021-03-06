---
layout: post
title: 关于IO的同步,异步,阻塞,非阻塞
categories:
  linux
tags:
- IO复用
- IO模型
- Java
- NIO
- 同步IO
- 异步IO
- 阻塞IO
- 非阻塞IO
---
上次写了一篇文章：<a title="Unix IO模型学习" href="http://www.zavakid.com/70" target="_blank">Unix IO 模型学习</a>。恰巧在这次周会的时候，<a href="http://weibo.com/fp1203" target="_blank">@fp1203</a> (<a title="黄金档" href="http://www.goldendoc.org/" target="_blank">goldendoc</a>成员之一) 正好在讲解poll和epoll的底层实现。中途正好讨论了网络IO的同步、异步、阻塞、非阻塞的概念，当时讲下来，大家的理解各不相同，各执己见。搜索了网络上的一些文章，观点也各不相同，甚至连<a href="http://en.wikipedia.org/wiki/Asynchronous_I/O" target="_blank">wiki</a>也将异步和非阻塞当成一个概念在解释。

虽然网络上充斥了大量关于同步、异步、阻塞、非阻塞的文章，但大都是抄来抄去，没有一个权威的说法。但我找到了<a href="http://blog.csdn.net/historyasamirror/article/details/5778378" target="_blank">这一篇文章</a>，该文章引用了《UNIX网络编程 卷1》的介绍，这本书的作者是Richard Stevens。如果有Richard Stevens在这方面的定义或者结论，那么我想，这应该是比较有说服力的了。

关于《UNIX网络编程 卷1》这本书，我特意找了英文原版，也共享出来了：大家可以下载<a href="http://u.115.com/file/bh06p2sr#UNIX_Network_Programming.chm" target="_blank">《UNIX网络编程 卷1》的英文原版</a>（CHM格式）。

我看了6.2这节内容，这节内容就是讲IO模型的。刚刚提到的那篇文章，几乎就是翻译这个6.2节的。应该说，这个6.2节，对同步和异步的讲解，算是很清楚的。

下面是我自己理解的重点。
<h3>IO模型</h3>
目前unix存在五种IO模型（这也和上一篇文章：<a title="Unix IO模型学习" href="http://www.zavakid.com/70" target="_blank">Unix IO 模型</a> 中提到的一致），分别是：
<ul>
	<li>阻塞型 IO（blocking I/O）</li>
	<li>非阻塞性IO（nonblocking I/O）</li>
	<li>IO多路复用（I/O multiplexing）</li>
	<li>信号驱动IO（signal driven I/O）</li>
	<li>异步IO（asynchronous I/O）</li>
</ul>
<h3>IO的两个阶段</h3>
<ol>
	<li>等待数据准备好</li>
	<li>将数据从内核缓冲区复制到用户进程缓冲区</li>
</ol>
<h3>同步，异步的区别</h3>
那么究竟什么是同步和异步的区别呢？请重点读一下<a title="点此下载" href="http://u.115.com/file/bh06p2sr#UNIX_Network_Programming.chm" target="_blank">原文</a>6.2节中的信号驱动IO和异步IO中的比较。最后总结出来是：
<ul>
	<li>同步IO，需要用户进程主动将存放在内核缓冲区中的数据拷贝到用户进程中。</li>
	<li>异步IO，内核会自动将数据从内核缓冲区拷贝到用户缓冲区，然后再通知用户。</li>
</ul>
这样，同步和异步的概念就非常明显了。以上的五种IO模型，前面四种都是同步的，只有第五种IO模型才是异步的IO。
<h3>阻塞和非阻塞</h3>
那么阻塞和非阻塞呢？注意到以上五个模型。阻塞IO，非阻塞IO，只是上面的五个模型中的两个。阻塞，非阻塞，是针对单个进程而言的。

当对多路复用IO进行调用时，比如使用poll。需注意的是，poll是系统调用，当调用poll的时候，其实已经是陷入了内核，是内核线程在跑了。因此对于调用poll的用户进程来讲，此时是阻塞的。

因为poll的底层实现，是去扫描每个文件描述符（fd），而如果要对感兴趣的fd进行扫描，那么只能将每个描述符设置成非阻塞的形式（对于用户进程来讲，设置fd是阻塞还是非阻塞，可以使用系统调用fcntl），这样才有可能进行扫描。如果扫描当中，发现有可读（如果可读是用户感兴趣的）的fd，那么select就在用户进程层面就会返回，并且告知用户进程哪些fd是可读的。

这时候，用户进程仍然需要使用read的系统调用，将fd的数据，从内核缓冲区拷贝到用户进程缓冲区（这也是poll为同步IO的原因）。

那么此时的read是阻塞还是非阻塞呢？这就要看fd的状态了，如果fd被设置成了非阻塞，那么此时的read就是非阻塞的；如果fd被设置成了阻塞，那么此时的read就是阻塞的。

不过程序已经执行到了这时候，不管fd是阻塞还是非阻塞，都没有任何区别，因为之前的poll，就是知道有数据准备好了才返回的，也就是说内核缓冲区已经有了数据，此时进行read，是肯定能够将数据拷贝到用户进程缓冲区的。

但如果换种想法，如果poll是因为超时返回的，而我们又对一个fd（此fd是被poll轮询过的）进行read调用，那么此时是阻塞还是非阻塞，就非常有意义了，对吧！
<h3>结论</h3>
<ol>
	<li>判断IO是同步还是异步，是看谁主动将<strong>数据</strong>拷贝到用户进程。</li>
	<li>select或者poll，epoll，是同步调用</li>
	<li>javaScript或者nodejs中的读取网络（文件）数据，然后提供回调函数进行处理，是异步IO。</li>
</ol>
