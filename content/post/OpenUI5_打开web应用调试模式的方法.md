---
title: '[OpenUI5] 打开web应用调试模式的方法'
date: 2014-12-22 23:27:31
categories: 
- FrontEnd
tags: 
- web
- openui5
- debug
- mode
- 调试
---
OpenUI5 web应用调试模式无需服务器端支持，完全可在浏览器上进行设置。下面列举了四种打开调试模式的方法：
- URL指定参数sap-ui-debug=true例如：http://localhost:8080/fmwebstudio/?sap-ui-debug=true
- 在浏览器控制台执行jQuery.sap.debug(true)
- 在加载了OpenUI5 web应用页面执行`CTRL`-`SHIFT`-`ALT`-`P`快捷键调出技术信息进行设置。![OpenUI5技术信息](/images/2014/12/0026uWfMgy6OAGaonYm9a.png)
- 在加载了OpenUI5web应用页面执行`CTRL`-`SHIFT`-`ALT`-`S`快捷键调出OpenUI5诊断页面进行设置。![OpenUI5诊断页面](/images/2014/12/0026uWfMgy6OAHwqRvL55.jpg)