---
title: '[JavaScript] 继承'
date: 2014-08-27 20:41:17
categories: 
- FrontEnd
tags: 
- javascript
- inheritance
- override
- class
---
示例：
```
function BaseClass() {};

BaseClass.prototype.method1 = function() {
  console.log("BaseClass#method1")
};

BaseClass.prototype.method2 = function() {
  console.log("BaseClass#method2")
};

BaseClass.prototype.method3 = function() {
  return "BaseClass#method3";
};

ChildClass.prototype = new BaseClass();

function ChildClass() {
  //BaseClass.call(this);
};

ChildClass.prototype.method2 = function() {
  console.log("ChildClass#method2")
};

ChildClass.prototype.method3 = function() {
  console.log(BaseClass.prototype.method3.call(this)+" by ChildClass!");
};

ChildClass.prototype.method4 = function() {
  console.log("ChildClass#method4")
};

var myobj = new ChildClass();
myobj.method1();
myobj.method2();
myobj.method3();
myobj.method4();
```

测试：
![JavaScript: 继承](/images/2014/8/0026uWfMgy72wJOtXUo2c.png)
注解：

Javascript的继承要在原型链上进行，没有super()可以调用父类，覆盖父类函数时只能通过父类原型以call或apply函数的形式调用父类的方法。
