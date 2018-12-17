---
title: '[C++]玩玩Designated Initializer'
date: 2015-12-28 06:18:40
categories: 
- C++
tags: 
- C++
- gcc
- designated
- initializer
---
玩一把gcc的[Designated Initializers](https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html)：
![[C++]玩玩Designated Initializer](/images/2015/12/0026uWfMgy6ZurG6m8w78.png)
测试结果：结构体内的变量必须按照声明的顺序初始化，并且不能遗漏，否则会报“sorry, unimplemented:non-trivial designated initializers not supported”错误。

### 参考

[C99标准](http://www.open-std.org/JTC1/sc22/wg14/www/docs/n1256.pdf)    
[Bug 55606 - sorry, unimplemented: non-trivial designated initializers not supported](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=55606)    
[ C++ - g++: sorry, unimplemented: non-trivial designated initializers not supported - SysTutorials QA](http://ask.systutorials.com/463/unimplemented-trivial-designated-initializers-supported)    
[ http://stackoverflow.com/questions/31215971/non-trivial-designated-initializers-not-supported](http://stackoverflow.com/questions/31215971/non-trivial-designated-initializers-not-supported)    
[Non-trivial designated initializers not supported · Issue #8 · couchbaselabs/cbforest · GitHub](https://github.com/couchbaselabs/cbforest/issues/8)    