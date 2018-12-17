---
title: '[OpenUI5] Grid layout for responsive design'
date: 2015-03-01 09:29:25
categories: 
- 前端
tags: 
- openui5
- layout
- grid
- responsive
- html5
---
OpenUI5的[Grid](https://openui5.hana.ondemand.com/docs/api/symbols/sap.ui.layout.GridData.html)机制位于sap.ui.layout库内，它在12列流布局中定位子控件位置。取决于当前屏幕尺寸，子控件可以指定可变的列数，从而实现响应式设计。
![[OpenUI5] Grid layout for responsive design](/images/2015/3/0026uWfMzy73zLYwZjBd3.jpg)
在上图示例中，无论屏幕大小，子控件1都占满12列，从而其他子控件无法跟它位于同一行内。
在大屏幕和中等屏幕尺寸下，子控件2和3共同占满12列，可以置于一行内；而在小屏幕尺寸下，二者需要列数超过12，只能分置于两行了。

### 参考

[Responsive Web Design](https://experience.sap.com/basics/post-123/)    
[UI5 features for building responsive Fiori apps](http://www.bluefinsolutions.com/blogs/dj-adams/february-2015/ui5-features-for-building-responsive-fiori-apps)    
[jsDoc: sap.ui.layout.GridData](https://openui5.hana.ondemand.com/docs/api/symbols/sap.ui.layout.GridData.html)    
[MDN: CSS Grid Layout](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout)    
[MDN: Using CSS multi-column layouts](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Columns/Using_multi-column_layouts)    