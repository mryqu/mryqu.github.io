---
title: '[OpenUI5] 获得当前页面语言'
date: 2015-01-10 15:33:19
categories: 
- 前端
tags: 
- openui5
- javascript
- jquery
- locale
- lang
---
获得当前页面语言的方法：

- javascript:`document.getElementsByTagName('html')[0].getAttribute('lang')`
- jQuery: `$('html').attr('lang')`
- OpenUI5: `sap.ui.getCore().getConfiguration().getLanguage()`

示例：
![[OpenUI5] 获得当前页面语言](/images/2015/1/0026uWfMgy72bz31qj18b.png)