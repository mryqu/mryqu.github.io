---
title: '图表工具JS库'
date: 2015-04-08 05:53:33
categories: 
- FrontEnd
tags: 
- 图表
- diagram
- javascrip
- html5
- libarary
---
由于目前工作用到GoJS，所有也关注一下图表工具JS库。[ 10 JavaScript libraries to draw your own diagrams](http://modeling-languages.com/javascript-drawing-libraries-diagrams/)一文给出了10个JS库的功能分析和比较图表。

|**库**|**许可**|**语言 / 基础架构**|**高/低级**|**内建编辑器**|**Github (04/02/2015)**
|-----
|**JointJS**|MPL|HTMLJavascriptSVG|高|无|1388星265分支（fork）
|**Rappid**|商业1 500,00 €|HTMLJavascriptSVG|高|有|&nbsp;
|**Mxgraph**|商业4300.00 €|HTMLJavascriptSVG|高|有|&nbsp;
|**GoJS**|商业$1,350.00|HTMLCanvasJavascript|高|有|&nbsp;
|**Raphael**|MIT|HTMLJavascriptSVG|低|无|7105星1078分支（fork）
|**Draw2D**|GPL2商业|HTMLJavascriptSVG|中|无|&nbsp;
|**D3**|BSD|HTMLJavascriptSVG|低|无|36218星9142分支（fork）
|**FabricJS**|MIT|HTMLCanvasjavasript|低|无|4127星705分支（fork）
|**paperJS**|MIT|HTMLCanvasjavascript|低|无|4887星496分支（fork）
|**JsPlumb**|MIT/GPL2|HTMLJavascript|中|无|2161星563分支（fork）

这里面D3在数据科学领域成绩比计突出，是数据可视化的一个重要工具。此外我在接触过的开源项目有几个用到了Raphael（包括Activiti）。其他库还没有接触过。
[我为什么选择 D3.js](https://ruby-china.org/topics/16216)一文中将D3和Raphael进行了对比。Raphael是一个矢量图的API，专注于对矢量图形的操作。D3是一个数据可视化展示的API，通过数据与图形进行绑定。
图表工具JS库除了上面帖子提及的外，还有很多。如果有机会的话，我会在GoJS之外更多关注D3和Raphael。