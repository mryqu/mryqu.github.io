---
title: '[OpenUI5] 第三方JavaScript库加载'
date: 2015-02-06 20:28:33
categories: 
- FrontEnd
tags: 
- openui5
- javascript
- 3rd
- library
- loading
---
SAP often put 3<sup>rd</sup> JavaScript libraries at \resources\sap\ui\thirdparty, then load as below:
```
jQuery.sap.require("sap/ui/thirdparty/d3");
```

样例：
[ OpenUI5: D3.js based custom control and table](http://jsbin.com/openui5-custom-d3-chart-and-table/1/edit?html,output)  
[ Custom SAPUI5 Visualization Controls with D3.js](http://scn.sap.com/community/developer-center/front-end/blog/2014/07/17/custom-sapui5-visualization-controls-with-d3js)  