---
title: '切记：Java中long字面量以L结尾'
date: 2013-10-26 10:30:48
categories: 
- Java
tags: 
- negative
- int
- long
- cast
- literal
---
最近碰到一个问题，输入是int，要求按无符号整数使用。为了实现要求，升级成long然后与上0xffffffff，结果不正常。问了几个基友，都有点茫然。
问题出在0xffffffff上了，现在就操练一下。

将0xffffffff赋给一个long变量，它的值是多少？
```
long n = 0xffffffff;
System.out.println(Long.toHexString(n));
```

结果是0xffffffffffffffff呦！
```
ffffffffffffffff
```

将0x000000008fffffff赋给一个long变量，它的值是多少？
```
long = 0x000000008fffffff;
System.out.println(Long.toHexString(n));
```

结果是0xffffffff8fffffff呦！！！
```
ffffffff8fffffff
```

int转换成long的规则是，一个负的int数，会自动扩展符号位，升级成负的long数的。
正确的用法是0xffffffffL，字面量表明是long类型，所以头32位才会全是0。
```
long = 0xffffffffL;
System.out.println(Long.toHexString(n));
```
输出结果：
```
ffffffff
```
