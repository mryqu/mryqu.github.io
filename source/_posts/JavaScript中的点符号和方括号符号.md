---
title: 'JavaScript中的点符号和方括号符号'
date: 2014-11-08 09:18:27
categories: 
- 前端
tags: 
- javascript
- dot
- square_bracket
- notation
---
JavaScript中对象可以通过点符号(dot notation)或方括号符号(square bracketnotation)访问属性。
```
a = {};
b = function() {
  alert("Thanks!");
};
c = function() {
  alert("Bye!");
};

a["Hello"] = b;
a.bye = c;
a.hello();
a.bye();
```
两者相同之处: 当属性不存在时返回undefined。两者的区别是:
- 点符号访问方式更快，代码阅读起来更清晰。
- 方括号符号访问方式可以访问包含特殊字符的属性，属性选择可以使用变量。JSLint会对方括号符号访问进行告警。