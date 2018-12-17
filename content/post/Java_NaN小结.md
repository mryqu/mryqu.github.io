---
title: 'Java NaN小结'
date: 2013-08-05 23:14:48
categories: 
- Java
tags: 
- java
- double
- NaN
- user-defined
- 自定义
---
### Double.NAN介绍

Double类有个NaN常量，是Not a Number的缩写，其值等于`Double.longBitsToDouble(0x7ff8000000000000L)` ，用于表示非数值。NaN必须使用isNaN(double)方法来判断，NaN与任何double数值进行加减乘除等数学运算后的结果仍然是NaN，且NaN使用==运算符与自身进行判断返回结果为false。测试代码如下：![Java NaN小结](/images/2013/8/0026uWfMgy6OOjbZCcj7b.jpg)
测试结果如下：
```
Double.NaN==Double.NaN              :false
Double.isNaN(Double.NaN*0)          :true
Double.NaN*0==0                     :false
Double.isNaN(Double.NaN/0)          :true
Double.NaN/0==0                     :false
Double.isNaN(0/Double.NaN)          :true
0/Double.NaN==0                     :false
Double.isNaN(Double.NaN+0)          :true
Double.NaN+0==0                     :false
Double.isNaN(Double.NaN-0)          :true
Double.NaN-0==0                     :false
Double.isNaN(Double.NaN*Double.NaN) :true
Double.NaN*Double.NaN==0            :false
```

### 自定义NAN介绍

Double.NaN可以用来表示计算结果发生异常，但是无法获知异常原因。我们可以通过自定义NAN来解决这一问题。使用Double类的isNaN(double)方法判断自定义NAN，其返回结果为true，我们可以通过自己的方法判决到底是那种NaN。测试代码如下：![Java NaN小结](/images/2013/8/0026uWfMgy6OOju66f993.jpg)
测试结果如下：
```
Double.isNaN(Double.NaN)                                    :true
MyNaN.isMyNaN(Double.NaN)                                   :false
Double.isNaN(MyNaN.INVALID_PARAMETER_NAN)                   :true
MyNaN.isMyNaN(MyNaN.INVALID_PARAMETER_NAN)                  :true
Double.isNaN(Double.longBitsToDouble(0xffff000000000123L))  :true
MyNaN.isMyNaN(Double.longBitsToDouble(0xffff000000000123L)) :false
```
