---
title: '用Python清理XMind生成的html文件'
date: 2014-07-20 06:42:59
categories: 
- Python
tags: 
- python
- beautifulsoup
- xmind
- html
- 清理
---
XMind思维导图可以导出成html文件，但是每个Topic都被a标签包着，然后外面再被h1、h2...h5标题标签包着，看着就难受。此外h1、h2...h5和p标签都加了class属性，没什么用。
写一段小程序，将XMind生成的html文件进行格式清理。

```
from bs4 import BeautifulSoup as BeautifulSoup
soup = BeautifulSoup(open("c:/qutemp/123.html"))
for a in soup('a'):
    a.parent.string = a.string
    a.clear()
for tag in ['h1','h2','h3','h4','h5','p']:
    for tag in soup(tag):
        del tag['class']
print soup
```