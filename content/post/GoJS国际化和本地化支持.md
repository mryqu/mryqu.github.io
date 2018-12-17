---
title: 'GoJS国际化和本地化支持'
date: 2015-04-10 05:50:49
categories: 
- 前端
tags: 
- gojs
- 国际化
- 本地化
- i18n
- i10n
---
查了一下GoJS国际化支持文档，藏的还挺深，放在[GoJS 部署](http://gojs.net/latest/intro/deployment.html)里了。

**GoJS**应用可以显示非拉丁语文本。示例可见[Japanese Family Tree](http://gojs.net/latest/samples/familyTreeJP.html).
**GoJS**不操作货币值、日期值或地址，因此对这些数据类型没有本地化问题；**GoJS**不包含任何自己的图标（图像）或光标。
**GoJS**不显示任何内建文本字符串，因此无需转换工作。用于往控制台输出的错误和告警消息仅用于程序员调试，而不会面向最终用户。当读写JSON、几何路径字符串或CSS颜色时，其中的数值读写仅用于内部使用且为非本地化格式。
所有用户可见文本都完全在程序员的控制之下。为了本地化，可以很方便地使用[Binding](http://gojs.net/latest/api/symbols/Binding.html)中的转换函数。[TextEditingTool](http://gojs.net/latest/api/symbols/TextEditingTool.html)使用HTMLTextArea元素实现原地文本输入和编辑，从而利用浏览器对输入法编辑器的支持。

GoJS不像OpenUI5那样根据Locale相应从I18Nproperties文件获取本地化文本，而是通过下列方式提供国际化和本地化支持：
- 提供显示非拉丁语文本的能力
- 将自身摘出来，确保自身实现没有国际化和本地化的要求
- 将一切国际化的工作推出去，程序员可以直接设置国际化显示文本，也可以实现Binding(targetprop,sourceprop, conv)中的转换工具方法在客户端进行本地化。