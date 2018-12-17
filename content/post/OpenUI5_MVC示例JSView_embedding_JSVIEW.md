---
title: '[OpenUI5] MVC示例:JSView embedding JSVIEW'
date: 2015-01-07 23:47:47
categories: 
- 前端
tags: 
- openui5
- mvc
- jsview
- embedding
- json
---
OpenUI5 SDK的演示程序里面有一个视图嵌套另外一个视图，但是通过Componentcontainer和Component.js实现的。一直对视图直接嵌套另外一个视图觉得理所当然但是有点顾虑，此外也担心外层视图的数据模型如何传递给内部视图。当然内外两层视图可以使用不同的数据模型，但是如果不知道共享一份数据视图是否可行?


在jsbin上做了一个示例：[http://jsbin.com/jirogo/1/edit?html,output](http://jsbin.com/jirogo/1/edit?html,output)，结果显示担忧是多余的

![[OpenUI5] MVC示例:JSView embedding JSVIEW](/images/2015/1/0026uWfMgy6P0e460Tn39.jpg)
