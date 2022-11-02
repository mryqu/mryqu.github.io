---
title: '[JavaScript] 函数的Arguments对象属性'
date: 2014-08-21 20:53:34
categories: 
- FrontEnd
tags: 
- javascript
- argruments
- function
- callee
- caller
---
### arguments对象

每个函数表达式在其作用域内都可以访问一个特殊的本地变量：arguments，它是跟数组很类似的对象，同样可以通过下标访问，例如arguments[0]和arguments[1]...。![JavaScript: 函数的Arguments对象属性](/images/2014/8/0026uWfMgy6Oyx5ve33ad.jpg)

#### arguments.length

传递给函数的参数个数。

#### arguments.callee

返回当前正在调用的函数。![JavaScript: 函数的Arguments对象属性](/images/2014/8/0026uWfMgy6OyYO4mdc8a.jpg)callee属性是arguments对象的一个成员，它表示对函数对象自身的引用，有利于匿名函数的递归或者保证函数的封装性，上例中的sumV2仅调用局部变量arguments的callee属性，较sumV1需要调用全局变量sumV1，封装性更好。![JavaScript: 函数的Arguments对象属性](/images/2014/8/0026uWfMgy6OyZKUxhRd7.jpg)值得注意的是，callee也拥有一个length属性。通过上例可知arguments.length反映的是函数的实参长度，arguments.callee.length反映的是函数的形参长度。

#### arguments.caller (<font color="#FF0000">已废弃</font>)

arguments.caller并属于标准，且已被废弃。可以使用同样不属于标准但被大多数主流浏览器支持的Function.caller获得调用当前函数的函数。![JavaScript: 函数的Arguments对象属性](/images/2014/8/0026uWfMgy6Oz5tVyX802.jpg)

### 参考

[Arguments object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/arguments)  
[arguments.callee](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/arguments/callee)  
[arguments.caller](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/caller)  
[Why was the arguments.callee.caller property deprecated in JavaScript?](http://stackoverflow.com/questions/103598/why-was-the-arguments-callee-caller-property-deprecated-in-javascript)  
[Function caller](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/caller)   