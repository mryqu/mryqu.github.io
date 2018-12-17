---
title: '在Vi中搜索多字节unicode字符'
date: 2013-10-20 09:00:49
categories: 
- Tool
- Linux
tags: 
- vi
- unicode
- hex
- decimal
- octal
---
使用Vi编辑unicode字符文本文件时，可以通过下列方式搜索和替换字符：
```
\%d   匹配特定十进制字符 (例如 \%d 123)
\%x   匹配特定十六进制字符 (例如 \%x2a)
\%o   匹配特定八进制字符 (例如 \%o040)
\%u   匹配特定多字节字符 (例如 \%u20ac)
\%U   匹配特定大的多字节字符(例如 \%U12345678)
```

为了在文本中查看任何字符的unicode或十六机制格式内容，将光标置于该字符上之后输入`ga` 命令。这会以十进制、十六机制和八进制显示显示字符值：
![在Vi中搜索多字节unicode字符](/images/2013/10/0026uWfMgy6XIVdySWG2e.png)