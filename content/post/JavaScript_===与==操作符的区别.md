---
title: '[JavaScript] === 与 == 操作符的区别'
date: 2013-11-08 19:07:08
categories: 
- FrontEnd
tags: 
- javascript
- strict
- lenient
- equality
- operator
---
JavaScript中有两个等值比较操作符：严格相等===和宽松相等==。很多JavaScript指南都建议避免使用宽松相等，而是使用严格相等。
- ===：只有在两个操作数的数据类型和值都相等的情况下才为true
- ==：用于比较两个操作数是否相等，这两个操作数的数据类型不一定要相等，只要进行数据类型转换后相等即为true

### 严格相等=== （严格不相等!==）

规则如下：
- 如果类型不同，就[不相等]
- 如果两个都是数值原始类型，并且是同一个值，那么[相等]；(！例外)的是，如果其中至少一个是NaN，那么[不相等]。（判断一个值是否是NaN，只能用isNaN()来判断）
- 如果两个都是字符串原始类型，每个位置的字符都一样，那么[相等]；否则[不相等]。
- 如果两个都是布尔原始类型，两个值值都是true，或者都是false，那么[相等]。
- 如果两个原始类型值都是null，或者都是undefined，那么[相等]。
- 如果两个值都引用同一个对象（含数组和函数），那么[相等]；否则[不相等]。示例：![JavaScript: === 与 == 操作符的区别](/images/2013/11/0026uWfMgy6QpHHnqPvb9.png)

### 宽松相等== （宽松不相等!=）
规则如下：
- 如果两个值类型相同，进行 === 比较。
- 如果两个值类型不同，他们可能相等。根据下面规则进行类型转换再比较：
  - null与undefined是[相等]的。
  - 如果字符串原始类型和数值原始类型进行比较，把字符串转换成数值再进行比较。
  - 如果Boolean对象与其他类型进行比较，Boolean对象会转换成数值(true:1,false:0)再进行比较。
  - 如果一个是对象，另一个是数值或字符串原始类型，把对象转换成原始类型的值再比较。对象利用它的toString或者valueOf方法转换成原始类型。JavaScript[内置核心对象](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Predefined_Core_Objects)(例如Array、Boolean、Function、Math、Number、RegExp和String)，会尝试valueOf先于toString；例外的是Date，Date利用的是toString转换。如果类型转换失败，则会产生一个runtime错误。
  - 对象和原始类型比较，对象才会转换成原始类型。两个对象比较，如果两个值都引用同一个对象（含数组和函数），那么[相等]；否则[不相等]。示例：![JavaScript: === 与 == 操作符的区别](/images/2013/11/0026uWfMgy6QpLRmvOkac.png)

### 参考

[ MDN：Comparison Operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators)    