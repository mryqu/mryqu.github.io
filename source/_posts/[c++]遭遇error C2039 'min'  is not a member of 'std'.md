---
title: "[C++]遭遇error C2039: 'min' : is not a member of 'std'"
date: 2015-12-22 05:31:50
categories: 
- C++
tags: 
- visual studio
- min
- std
- algorithm
- C++
---
使用Visual Studio2013编译twitcurl遭遇下列错误：
```
error C2039: 'min' : is not a member of 'std'
```
**解决方法**：
```
#include <algorithm>
```