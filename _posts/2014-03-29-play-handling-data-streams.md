---
layout: post
title: PlayFramework 的流处理
draft: true
categories:
  Scala
  Stream
  Play
tags:
  Scala
  Stream
  Play
---

流处理在web中常见的场景, 应该是 chunked upload/download, 还有通过 Comet/WebSockets 来实现实时通信了.

Play 在这方面, 提供了一个范例: *Iteratees* (要翻译成中文还真不好翻译).
Play 专门使用了一个工程 play-iteratees 来将这块独立出来, 其实理论上来讲, 这块也是可以独立出来的, 毕竟流处理的模式, 还能用在除了 web 之外的很多地方. 

### Iteratees
Iteratee 表示一个消费者, 其实就是一个函数,

