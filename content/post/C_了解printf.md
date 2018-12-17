---
title: '[C] 了解printf中的%.s'
date: 2015-01-22 20:59:59
categories: 
- C++
tags: 
- C
- printf
- width
- precision
- string
---
偶尔看到C代码`printf("%.*s",dataL,data);`，对printf中的格式化字符串"%.*s"有点不解。

查看了[http://www.cplusplus.com/reference/cstdio/printf/](http://www.cplusplus.com/reference/cstdio/printf/)文档后，有所理解。

| _width_ |description
|-----
| _(number)_ |Minimum number of characters to be printed. If the value tobe printed is shorter than this number, the result is padded withblank spaces. The value is not truncated even if the result islarger.
| * |The _width_ is not specified in the _format_ string, but as an additional integer value argument preceding theargument that has to be formatted.


| _.precision_ |description
|-----
| ._number_ |For integer specifiers (d, i, o,u, x, X): _precision_ specifies theminimum number of digits to be written. If the value to be written is shorter than this number, the result is padded with leading zeros. The value is not truncated even if the result is longer. A _precision_ of 0 means that no character is written for the value 0.<br>For a, A, e, E, f and F specifiers: this is the number of digits to be printed after the decimal point (by default, this is 6).<br>For g and G specifiers: This is the maximumnumber of significant digits to be printed.<br>For s: this is the maximum number of characters to beprinted. By default all characters are printed until the ending null character is encountered.<br>If the period is specified without an explicit value for _precision_ , 0 is assumed.
| .* |The _precision_ is not specified in the _format_ string, but as an additional integer value argument preceding the argument that has to be formatted.


个人理解如下：
- 格式化字符串没有指定固定宽度/精确度，而是使用*，代表接受整数参数。
- 对于字符串打印，宽度代表最小打印字符个数。如果字符串相对短的话，则填充空格。如果字符串相对长的话，也不会截断。
- 对于字符串打印，精度代表最大打印字符个数。如果字符串相对短的话，不会填充；如果字符串相对长的话，截断。

示例代码testPrintf.cpp如下：
![[C] 了解printf中的"%.*s"](/images/2015/1/0026uWfMzy7cz7Sth2820.jpg)
测试结果：
```
Hello123|
        Hello123|
Hello123        |
Hello123|
Hello123|
Hello123|
Hello123|
Hello|
Hello|
Hello123|
Hello|
```

我的理解是正确的。此外光指定精度时，使用"-"标志指定右对齐没起作用。
