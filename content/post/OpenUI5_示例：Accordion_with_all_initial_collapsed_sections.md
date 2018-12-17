---
title: '[OpenUI5] 示例：Accordion with all initial collapsed sections'
date: 2015-05-04 00:01:32
categories: 
- 前端
tags: 
- openui5
- javascript
- accordion
- coolapsed
- section
---
sap.ui.commons.Accordion会设置一个默认展开的section。
```
sap.ui.commons.Accordion.prototype.addSection = function(oSection) {
 this.addAggregation("sections", oSection);

 //Add a default opened section id
 if ( (this.getOpenedSectionsId() == null ||
      this.getOpenedSectionsId() == "" ) &&
      oSection.getEnabled()){
  this.setOpenedSectionsId(oSection.getId());
 }

 this.aSectionTitles.push(oSection.getTitle());
};
```

如果想让初始化所有section为折叠的，只要将openedSectionsId设为“-1”就可以了。
示例位置: [http://jsbin.com/sajoba/1/edit?html,output](http://jsbin.com/sajoba/1/edit?html,output)
![[OpenUI5] 示例：Accordion with all initial collapsed sections](/images/2015/5/0026uWfMgy6SmWve3L12f.png)