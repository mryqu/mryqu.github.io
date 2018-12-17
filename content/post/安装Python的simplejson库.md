---
title: '安装Python的simplejson库'
date: 2013-09-24 22:51:08
categories: 
- Python
tags: 
- python
- pip
- simplejson
- ubuntu
- install
---
在Ubuntu下运行一个Python程序，遇到如下问题：ImportError: No module named simplejson。

首先查看一下Python和pip的版本：
```
python -V
pip -V
```

竟然没有装pip，解决方案如下：
```
sudo apt-get install python-pip
pip2 install simplejson
```
