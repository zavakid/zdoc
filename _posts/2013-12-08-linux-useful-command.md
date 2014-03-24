---
layout: post
title: Linux上有用的命令
categories:
  Linux
  shell
  command
tags:
  Linux
  shell
  command
---

//有空就更新

### 替换文本

{% hl shell %}
# 把 test 开头文件中的 Windows 换成 Linux
# -i[extension]     edit <> files in place (makes backup if extension supplied)
# -e program        one line of program (several -e's allowed, omit programfile)
# -p                assume loop like -n but print line also, like sed
# -n                assume "while (<>) { ... }" loop around program
perl -i -pe 's/Windows/Linux/;' test*
{% endhl %}



### 压缩/解压相关

{% hl shell %}
# pigz 是 gz 的多核版
tar cvf - paths-to-archive | pigz > archive.tar.gz
# 使用 -p 指定核数
tar cvf - paths-to-archive | pigz -9 -p 32 > archive.tar.gz
{% endhl %}

### 确定系统性能的情况(其实更重要的是对数据的解读)

#### 网络流量监控

{% hl shell %}
ar -n DEV 1 1000
{% endhl %}

#### 磁盘IO

{% hl shell %}
iostat -dxk 1 1000
{% endhl %}

#### CPU

{% hl shell %}
top
# or 
vmstat
{% endhl %}

### 参考

* [Utilizing multi core for tar+gzip/bzip compression/decompression](http://stackoverflow.com/questions/12313242/utilizing-multi-core-for-targzip-bzip-compression-decompression)
* [每个极客都应该知道的Linux技巧](http://blog.jobbole.com/60549/)
