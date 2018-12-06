---
title: '找不到TTY而导致的Vagrant destroy失败'
date: 2015-05-06 05:50:21
categories: 
- Tool
- Vagrant
tags: 
- vagrant
- tty
- required
- devops
---
在Windows的Git Bash上想要够过`vagrant destroy`命令删除一个Vagrant虚拟机，结果碰到了这个错误：
<pre>
Vagrant is attempting to interface with the UI in a way that requires a TTY. Most actions in Vagrant that require a TTY have configuration switches to disable this requirement. Please do that or run Vagrant with TTY.
</pre>

据说Windows上的Cygwin以一种奇怪的方式处理stdin导致Ruby以为没有TTY，没想到Git Bash所基于的MinGW也有这样的问题。
权变措施是使用`vagrant destroy --force`。

[](http://stackoverflow.com/questions/23633276/vagrant-is-attempting-to-interface-with-the-ui-in-a-way-that-requires-a-tty)  
[](https://groups.google.com/forum/#!msg/vagrant-up/ExFet5jMomU/T9FiZluf4ggJ)  