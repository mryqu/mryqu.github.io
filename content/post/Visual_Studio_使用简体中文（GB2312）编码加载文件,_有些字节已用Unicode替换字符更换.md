---
title: 'Visual Studio: 使用简体中文（GB2312）编码加载文件, 有些字节已用Unicode替换字符更换'
date: 2015-12-21 05:55:02
categories: 
- Tool
tags: 
- visual studio
- 2010
- unicode
- replaced
---
遭遇下列VS2010错误: Some bytes have been replaced with the Unicodesubstitution character while loading file base64.cpp with ChineseSimplified (GB2312) encoding. Saving the file will not preserve theoriginal file contents.
![Visual Studio: 使用简体中文（GB2312）编码加载文件, 有些字节已用Unicode替换字符更换](/images/2015/12/0026uWfMgy6Y9r5a4DH8d.png)我的Visual Studio已经勾选了Auto-detect UTF-8 encoding withoutsignature:![Visual Studio: 使用简体中文（GB2312）编码加载文件, 有些字节已用Unicode替换字符更换](/images/2015/12/0026uWfMgy6Y9t5TUht53.jpg) Ultraedit不能正常显示base64.cpp，但Sublime Text能正常显示。
![Visual Studio: 使用简体中文（GB2312）编码加载文件, 有些字节已用Unicode替换字符更换](/images/2015/12/0026uWfMgy6Y9rPZfRM6a.jpg)原因是base64.cpp并不是UTF-8编码，但是包含一个十六进制为"E9"的字符，即带重音符的e。由于我的系统locale是RPC，所以显示不正常，估计系统locale改成[CP1252 - Windows 拉丁语1代码页](http://www.cp1252.com/)就可以了。用Sublime Text将其转存为UTF-8编码当然也可以。