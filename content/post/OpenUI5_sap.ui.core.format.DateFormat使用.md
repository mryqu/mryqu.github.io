---
title: '[OpenUI5] sap.ui.core.format.DateFormat使用'
date: 2015-03-15 17:02:46
categories: 
- FrontEnd
tags: 
- openui5
- javascript
- date
- format
---
使用javascript的Date类型，想要输出国际化的字符串，可以使用toLocaleString函数，但是需要自己往里设locale，并且输出结果随操作系统和浏览器不同而变化。

最后还是用OpenUI5的DateFormat，既可以固定格式有可以自动国际化。
```
var oDateFormat = sap.ui.core.format.DateFormat.getDateTimeInstance({
    pattern: "EEEE, MMMM d, yyyy HH:mm:ss a z"
});
oDateFormat.format(new Date());
```
![[OpenUI5] sap.ui.core.format.DateFormat使用](/images/2015/3/0026uWfMgy72bJ4fPBPdd.jpg)