---
title: '[OpenUI5] 使用DateRangeSelection'
date: 2016-04-11 05:58:48
categories: 
- 前端
tags: 
- openui5
- daterangeselection
- javascript
- html5
- web
---
今天使用了DateRangeSelection来选择日期范围。
[DateRangeSelection范例](https://sapui5.hana.ondemand.com/explored.html#/sample/sap.m.sample.DateRangeSelection/preview)  
[sap.m.DateRangeSelection jsDoc](https://openui5.hana.ondemand.com/docs/api/symbols/sap.m.DateRangeSelection.html)  
[DateRangeSelection源代码](https://github.com/SAP/openui5/blob/master/src/sap.m/src/sap/m/DateRangeSelection.js)  
[sap.ui.core.format.DateFormat jsDoc](https://openui5.hana.ondemand.com/docs/api/symbols/sap.ui.core.format.DateFormat.html)  
[Working with Dates in Sapui5](http://stackoverflow.com/questions/30647921/working-with-dates-in-sapui5)  
[sap.ui.core.format.DateFormat](https://help.sap.com/saphelp_uiaddon10/helpdata/en/91/f2eba36f4d1014b6dd926db0e91070/content.htm)  

通过阅读上述资料，DateRangeSelection内存储的起始、结束时间为Date类。可以通过设置displayFormat和delimiter来改变界面上日期的表现形式；不支持valueFormat，因此只能通过getDateValue()、getSecondDateValue()获取Date对象，然后通过DateFormat获得相应格式化的日期字符串。
DateRangeSelection最新版代码提供了setMinDate()和setMaxDate()函数，但是jsDoc还没有体现，我司目前所用的OpenUI5版本还不支持。
