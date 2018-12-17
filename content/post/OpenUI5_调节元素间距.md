---
title: '[OpenUI5] 调节元素间距'
date: 2015-01-05 20:31:26
categories: 
- 前端
tags: 
- openui5
- javascript
---
在使用OpenUI5时，有时两个元素间距不合预期，我大体可用两种方式进行改进：

- 一种方式是添加自己定制的CSS类，然后通过[addStyleClass](https://openui5.hana.ondemand.com/docs/api/symbols/sap.ui.core.Control.html#addStyleClass)方法对控件设置自己定制的CSS类
- ​另一种方法土点，就是对需要调整间距的两个元素上增加一个HBox/VBox控件，然后在两个之间加一个定宽/高的控件调节间距。```
//在oControl1和oControl2之间增加15px的间距
new VBox({
  items: [
    oControl1,
    new HBox({
      height: "15px",
      fitContainer: true
    }),
    oControl2
  ]
})
```
​