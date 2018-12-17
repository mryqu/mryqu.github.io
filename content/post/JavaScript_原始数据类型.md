---
title: '[JavaScript] 原始数据类型'
date: 2013-12-07 10:09:54
categories: 
- 前端
tags: 
- javascript
- primitive
- typeof
- operator
---
### 原始数据类型
JavaScript共有5种原始数据类型：

|原始数据类型|包装对象|介绍
|-----
|string|String|字符串遇到加号之外的计算操作符，会转换成数值。内容为不为数值的字符串转换成NaN。当用比较操作符比较两个字符串时，比较的是第一个字母的unicode。
|number|Number|十进制数：123八进制数：0123十六进制数：0x123指数：1e1、1E+1、2E-3无穷：Infinity、-Infinity非数字：NaN
|Boolean|Boolean|
|null||与undefined的区别在于，已定义但没有值
|undefined||

### typeof操作符
typeof的返回值有六种可能：number、string、boolean、object、function、undefined。![JavaScript: 原始数据类型](/images/2013/12/0026uWfMgy6QpPL0Sne48.png)

### 条件判断或3元条件运算符(?:)判断

|值|Boolean结果
|-----
|undefined|false
|null|false
|number|0和NaN为false，其他为true
|string|空字符串""为false，其他为true
|对象|不为null的对象始终为true

### 参考

[MDN：Primitive data type](https://developer.mozilla.org/en-US/docs/Glossary/Primitive)    
[ MDN：typeof operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/typeof)    