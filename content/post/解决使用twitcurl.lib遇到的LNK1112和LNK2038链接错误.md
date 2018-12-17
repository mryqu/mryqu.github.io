---
title: '解决使用twitcurl.lib遇到的LNK1112和LNK2038链接错误'
date: 2015-12-30 14:52:38
categories: 
- DataBuilder
- C++
tags: 
- lnk1112
- lnk2038
- twitcurl
- x64
- mt
---
在使用twitcurl.lib时，遭遇下列链接错误：
```
fatal error LNK1112: module machine type 'X86' conflicts with target machine type 'x64'
libtwitcurl.lib(twitcurl.obj) : error LNK2038: mismatch detected for 'RuntimeLibrary': value 'MD_DynamicRelease' doesn't match value 'MT_StaticRelease' in xxxxx.obj
```

解决方法：
![解决使用twitcurl.lib遇到的LNK1112和LNK2038链接错误](/images/2015/12/0026uWfMgy6ZVCVr4oLc7.jpg)