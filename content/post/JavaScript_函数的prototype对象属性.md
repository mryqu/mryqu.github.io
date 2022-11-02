---
title: '[JavaScript] 函数的prototype对象属性'
date: 2014-08-22 21:44:13
categories: 
- FrontEnd
tags: 
- javascript
- prototype
- call
- apply
- bind
---
### 原型（prototype）

JavaScript 不包含传统的类继承模型，而是使用原型模型。继承方面，JavaScript中的每个对象都有一个内部私有的链接指向另一个对象，这个对象就是该对象的原型。这个原型对象也有自己的原型，直到对象的原型为 null为止（也就是没有原型）。这种一级一级的链结构就称为原型链。![JavaScript: 函数的prototype对象属性](/images/2014/8/0026uWfMgy6OxkhlC3t97.jpg)

#### Function.prototype.toString()

toString()方法返回表示函数源代码的字符串。![JavaScript: 函数的prototype对象属性](/images/2014/8/0026uWfMgy6OzNaZjea12.png)

#### Function.prototype.bind()

对于给定函数，bind()方法创建具有与原始函数相同主体的绑定函数。 在绑定函数中，this对象将解析为传入的对象。绑定函数具有指定的初始参数。
```
fun.bind(thisArg[, arg1[, arg2[, ...]]])
```
![JavaScript: 函数的prototype对象属性](/images/2014/8/0026uWfMgy6OzREiWPH7d.png)JavaScript bind 方法具有几种用法。 通常，它用于为在其他上下文中执行的函数保留执行上下文。

#### Function.prototype.call()和Function.prototype.apply()

call()和apply()方法都是调用一个对象的方法，用另一个对象上下文替换当前对象上下文。两者仅在定义参数方式有所区别：call传递的是参数列表，apply传递的是数组或arguments对象。
```
fun.call(thisArg[, arg1[, arg2[, ...]]])
```
应用call和apply还有一个技巧，就是call和apply应用另外一个函数以后，当前函数就具备了另外一个函数的方法和属性，这也可以称之为“继承”。![JavaScript: 函数的prototype对象属性](/images/2014/8/0026uWfMgy6OzZq8yMrc3.jpg)通过上例可知，extend调用call方法后就继承到了base的方法和属性。


### 参考

[JavaScript函数的Arguments对象属性](/post/javascript_函数的arguments对象属性)    
[Javascript继承机制的设计思想](http://www.ruanyifeng.com/blog/2011/06/designing_ideas_of_inheritance_mechanism_in_javascript.html)    
[深入理解JavaScript系列（5）：强大的原型和原型链](http://www.cnblogs.com/tomxu/archive/2012/01/05/2305453.html)    
[Function.prototype.apply()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply)    
[Function.prototype.call()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call)    
[Function.prototype.bind()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/bind)    
[Function.prototype.toString()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/toString)    
[Functional JavaScript, Part 3: .apply(), .call(), and the arguments object](http://tech.pro/tutorial/2010/functional-javascript-part-3-apply-call-and-the-arguments-object)    
[Bind, Call and Apply in JavaScript](https://variadic.me/posts/2013-10-22-bind-call-and-apply-in-javascript.html)    