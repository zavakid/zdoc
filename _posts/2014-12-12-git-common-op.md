---
layout: post
title: git 分支常见操作
published: true
categories:
  git
tags:
  git
---

参考: http://pcottle.github.io/learnGitBranching/

HEAD 指针移动
{% hl shell %}
git co some_commit
# ^ 表示上一个的意思, 三个^表示让ref指针往前回滚三次
git co ref^^^ 
# 与上面等价
git co ref~3 
{% endhl %}

rebase
{% hl shell %}
# rebase的名字很形象,将当前分支的base点移动到某个ref所指向的commit上,
#相当于把分支复制到某个 commit
git rebase ref 
{% endhl %}

交互式 rebase
{% hl shell %}
git rebase -i HEAD~4
{% endhl %}

移动分支
{% hl shell %}
# 将 refA 移动到 refB所代表的commit上
git br -f refA refB
{% endhl %}

回滚
{% hl shell %}
# reset 是将当前的分支往回移动一次修改, 意味着重写历史, 适合没被推送之前操作
git reset HEAD~1

# revert 回滚此次操作, revert 尊重历史, 适合操作已被推送的commit
git revert HEAD
{% endhl %}

cherry-pick
{% hl shell %}
# cherry-pick 可以把其他的ci捡过来, 然后进行提交
# 将 ci1 ci2 在当前分支上进行提交
git cherry-pick ci1 ci2 
{% endhl %}

