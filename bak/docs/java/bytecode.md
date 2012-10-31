---
layout: default
title: Java字节码
---
## 简介
java bytecode 是 JVM 中执行的指令. 每个字节码都是一个字节(byte)长, 后面跟着不定长度的参数, 所有就有了多字节的指令. 一个字节长8个bit, 这就意味可能有256个字节码, 但是现在的字节码还没有达到256个. 此外, java字节码是基于栈的执行体系, 也就是说会依赖于栈这种数据结构, 在栈上做很多 pop 和 push.

## 指令
### 指令的划分
指令被划分为几个作用:

* load到栈 或者 store回 loacl variable (比如: aload_0, istore)
* 做数值计算或逻辑计算 (比如: ladd, fcmpl)
* 类型转换 (比如 i2b, d2i)
* 对象的创建或者操作 (比如: new, putfield)
* 栈的一些操作 (比如: swap, dup2)
* 流程的控制 (比如: ifeq, goto)
* 方法调用 (比如: invokespecial, areturn)

### 指令的前后缀
很多指令都有前缀和后缀, 这些通常都有相同的含义, 如下:

* i : integer
* l : long
* s : short
* b : byte
* c : character
* f : float
* d : double
* a : reference


