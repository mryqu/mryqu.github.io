---
title: '用find和grep搜索特定目录下特定文件中的特定关键字'
date: 2013-10-23 19:58:54
categories: 
- Tool
tags: 
- find
- grep
- 文件
- 关键字
---
下例为递归搜索当前目录下所有以yqu为后缀的文件中的关键字123：
```
find . -name "*.yqu" | xargs grep -H "123"
```
