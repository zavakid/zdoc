---
layout: post
title: Ruby正则表达式学习笔记
categories:
  ruby
tags:
  ruby
  template
#published: false
---

参考：[Ruby Regex](http://www.ruby-doc.org/core-1.9.3/Regexp.html)

ruby中用 Regexp 这个类表示正则，使用 `/.../` 或者 `%r{...}` 包围起来，或者使用 Regexp::new ，都会新建一个 Regexp 类。

###字符集合

使用 `[a-z]` 的形式，还可以 `[0-9a-z]` 表示 0-9 或者 a-z ， `[^0-9]` 表示非0-9 <br/>
可以嵌套，比如 `[0-9[a-z]]`，其实等价于 `[0-9a-z]`<br/>
可以`&&`操作，比如 `[0-9&&[^1-5]]`，其实等价于 `[06-9]`<br/>

除了显示使用 `[ ]` 去指定字符集合，还可以使用一些元字符代表一些字符集合.比如：

* `/./` 表示除了换行的任意字符（可以确认下ruby是否会兼容不同平台的换行）
* `/./m` 表示任意字符（m表示多行模式，multiline）
* `/\w/` 表示单词(word)，等价于 `[a-zA-Z0-9_]`
* `/\W/` 表示非单词，等价于 `[^a-zA-Z0-9_]`
* `/\d/` 表示数字，等价于 `[0-9]`
* `/\D/` 非数字，等价于 `[^0-9]`
* `/\h/` 16进制字符，等价于 `[0-1a-fA-F]`
* `/\H/` 非16进制字符
* `/\s/` 表示空白字符，等价于 `[\t\r\n\f]`
* `/\S/` 非空白字符

POSIX也有相应的表示方式，使用 `[[:space:]]` 的形式。使用上比较复杂，不过，是POSIX的：）

POSIX不支持但ruby支持的：

* `/[[:word]]/`
* `/[[:ascii]]/`

### 重复

* `*`        0到无限次
* `+`       1到无限次
* `?`       0到1次
* `{n}`     n次
* `{n,}`    n到无限次
* `{,m}`   0-m次
* `{n,m}` n到m次

重复默认是贪婪的！在重复元符号后使用？来表示非贪婪。

### 捕捉
括号可以用来捕捉，然后用 \1 的形式来引用。
比如：`/[csh](..) [csh]\1 in/.match("The cat sat in the hat")`

可以使用组名来引用捕捉，而不是 `\1 ` 这样难读的数字，
使用 `(?'name')` 或者 `(?<name>)` 的形式。
比如： `pry(main)> /\$(?<dollars>\d+)\.(?<cents>\d+)/.match("$3.67")[:dollars] #=> "3"`

如果是在正则中，则使用 `\k<name>` 去反向引用，还是第一个例子：
`/[csh](?<cat>..) [csh]\k<cat> in/.match("The cat sat in the hat")`

注意：不能在一个正则中同时使用名字和数字去反向引用

### 分组
括号还可以表示分组，也就是在一个括号中的就是一个单元。
比如 ： `(abc)+ `

### 分组但不捕捉
使用 `(?:…)`

### 原子分组
使用 `(?>pat)`
一般原子分组都不会进行回溯，可以增加性能，但会遇到匹配不上的问题。
因为原子分子一旦匹配上了，就不会留下回溯的位置。
详见：[Ruby Regex Atomic](http://www.regular-expressions.info/atomic.html)

### 子表达式调用
就是在同一个正则中可以调用刚刚已经写过的子表达式，<br/>
比如 ： `/\A(?<paren>\(\g<paren>*\))*\z/ =~ '()'`<br/>
其中 `\A ` 和 `\z ` 是表示匹配字符串头和字符串尾的意思。<br/>
如果拆解出来，可以还原这个正则的书写顺序：

* 为了简单，不使用 `\A ` 和 `\z ` 了
* 一开始就是为了匹配 “()” ，所以写成了 ： `/\(\)/`
* 然后命令这个分组： `/(?<paren>\(\))/`
* 为了匹配 ((())) 这样的字符，就需要在 （ 和 ） 中间递归调用自己，
* 所以就写成 `/(?<paren>\(\g<paren>*\))/`

类似一种递归.

可以想象正则引擎在匹配的时候，在匹配完了了 ( 之后，就递归调用了自己。

### 锚点
参考 [Ruby Regex Anchors](http://www.ruby-doc.org/core-1.9.3/Regexp.html#Anchors) 一节。

注意点：

* `^` `\A ` 的区别 : 一样的, 需要验证
* `$` `\z ` `\Z ` 的区别: `\Z ` 与 `$` 一样，而 `\z ` 会把换行符当作字符,需要验证

lookahead 和 lookbefore 非常有用：

* `(?=pat)` 前面是 pat
* `(?!pat)` 前面不是 pat
* `(?<=pat)` 后面是 pat
* `(?<!pat)` 后面不是 pat

### 选项

* `/pat/i`   忽略大小写
* `/pat/m` 多行模式，把换行当作一个字符
* `/pat/x`   忽略空格和注释，常常使用这个方法来提高可读性
* `/pat/o`   只执行 #{} 一遍 


