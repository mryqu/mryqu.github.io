---
title: '[OpenUI5] logging'
date: 2014-11-16 09:21:34
categories: 
- 前端
tags: 
- openui5
- javascript
- log
---
jQuery.sap.log是客户端Javascript日志API。
![[OpenUI5] logging](/images/2014/11/0026uWfMgy71XUnyq5r59.png)
通过上图可知，其日志级别分别为ALL、DEBUG、ERROR、FATAL、INFO、NONE、TRACE和WARNING，默认日志级别为ERROR。

如果要显示所有日志信息，可以执行:
```
jQuery.sap.log.setLevel(6)
```
