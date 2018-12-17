---
title: '[JavaScript] 逻辑操作符的特殊行为'
date: 2013-12-07 14:47:35
categories: 
- 前端
tags: 
- javascript
- logical
- operator
- behavior
- return_value
---
Javascript中并不要求逻辑运算的两个操作数为布尔类型，并且返回值也不一定为布尔类型。&&操作符，如果第一个操作表达式能被转换成false，返回第一个操作表达式；否则返回第二个操作表达式。当用于两个布尔类型值时，两个值都为true时返回ture，否则返回false。||操作符，如果第一个操作表达式能被转换成true，返回第一个操作表达式；否则返回第二个操作表达式。当用于两个布尔类型值时，任一个值为true时返回ture，否则返回false。示例：![Javascript: 逻辑操作符的特殊行为](/images/2013/12/0026uWfMgy6QpTVziKP77.png)
### 参考

[ MDN：Logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators)  