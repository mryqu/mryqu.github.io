---
title: '[Git] 查看某文件历史记录'
date: 2013-11-09 06:38:12
categories: 
- Tool
- Git
tags: 
- git
- log
- gitk
- 文件
- 历史记录
---
在Git中查看某个文件历史记录，方式如下：
- git log [filename]：显示对该文件的提交记录
- git log -p [filename]：显示对该文件的提交记录及每次提交增量内容
- gitk [filename]：图形显示对该文件的提交记录及每次提交增量内容