---
title: '[JavaScript] 字符串与JSON数据互转'
date: 2014-08-26 06:06:26
categories: 
- FrontEnd
tags: 
- javascript
- string
- json
- parse
- stringify
---
### 字符串->JSON

转换方法有3种:

#### 使用浏览器内置window.JSON.parse方法
原生方法，速度最快，首选方案。老版本浏览器不支持。

|浏览器|支持版本
|---
|Chrome|(Yes)
|Firefox (Gecko)|3.5 (1.9.1)
|Internet Explorer|8.0
|Opera|10.5
|Safari|4.0
|Android|(Yes)
|Chrome for Android|(Yes)
|Firefox Mobile (Gecko)|1.0 (1.0)
|IE Mobile|(Yes)
||Opera Mobile|(Yes)
|Safari Mobile|(Yes)


#### 使用Funtion()构造函数
较eval_r()快

#### 使用 eval_r() 函数

功能强大，能解析任何JS代码,但是执行效率和安全性都不好示例代码：
```
var jsonStr = '{"name":"kxeg","data":[{"key":"Alpha","color":"lightblue"},{"key":"Beta","color":"orange"}]}';

//JSON.parse()
if (window && window.JSON && window.JSON.parse)
  jsonObj1 = window.JSON.parse(jsonStr);

//Function 创建一个闭包,返回一个json数据对象
jsonObj2 = (new Function('return'+jsonStr))();

//eval_r()
jsonObj3 = eval_r('('+jsonStr+')');
```
![JavaScript: 字符串与JSON数据互转](/images/2014/8/0026uWfMgy6RtYRWmur77.jpg)

### JSON->字符串

使用浏览器内置window.JSON.stringify方法

### 参考

[js中字符串数据转为json对象的方法](http://www.cnblogs.com/jiji262/archive/2012/07/12/2587979.html)  
[ MDN：JSON](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON)  