---
title: 'GoJS BPMN元素界面实现分析'
date: 2015-03-11 20:10:35
categories: 
- workflow
tags: 
- gojs
- bpmn
- element
- javascript
- html5
---
[GoJS BPMN](http://gojs.net/latest/extensions/BPMN.html#)里面的BPMN元素采用过不是PNG/JPEG这样的静态图标，而是通过GoJS在Cavas绘出来的。
![GoJS BPMN元素界面实现分析](/images/2015/3/0026uWfMgy6QFj0Jz0p1d.png)
由[BPMN.js](http://gojs.net/latest/extensions/BPMN.js)可知，一个BPMN元素是一个go.Node，内部大致包含go.Panel、go.Shape、go.TextBlock等对象，用于绘制外层的正方形、填充内部颜色、添加图标和文字。
如果创建自己定制的BPMN元素，最麻烦的就是图标了。现在我来看一下GoJS BPMN扩展里面的图标是怎么保存和绘制的。
GoJS BPMN扩展里面大部分的图标都已经在[go.js](http://gojs.net/latest/release/go.js)里面以源代码的形式定义了，只有四个是在[BPMN.js](http://gojs.net/latest/extensions/BPMN.js)里面通过go.Shape.defineFigureGenerator方法定制的，分别是Empty、Annotation、BpmnTaskManual和BpmnTaskService。这四个图标的内容是[GoJS geometry](http://gojs.net/latest/intro/geometry.html)的格式保存的。
所有这些图标可以通过与go.Shape的figure进行绑定，由GoJS驱动完成底层绘制。我自己做了一个简单样例，对这些内嵌图标和BPMN定制图标稍微玩了点花样 http://jsfiddle.net/mryqu/mywy0nhz/
显示效果如下：
![GoJS BPMN元素界面实现分析](/images/2015/3/0026uWfMgy6QFjEVdj369.png)