---
title: '了解Objenesis'
date: 2015-08-12 06:04:09
categories: 
- Java
tags: 
- objenesis
- java
- 类
- 实例化
---
Objenesis是一个很小的Java库，作用是绕过构造器创建一个实例。Java已经支持通过Class.newInstance()动态实例化Java类，但是这需要Java类有个适当的构造器。很多时候一个Java类无法通过这种途径创建，例如：
- 构造器需要参数
- 构造器有副作用
- 构造器会抛出异常

Objenesis可以绕过上述限制。它一般用于：
- **序列化、远程处理和持久化**：无需调用代码即可将Java类实例化并存储特定状态。
- **代理、AOP库和Mock对象**：可以创建特定Java类的子类而无需考虑super()构造器。
- **容器框架**：可以用非标准方式动态实例化Java类。例如Spring引入Objenesis后，Bean不再必须提供无参构造器了。

Objenesis内部提供了多个不同JVM上的解决方案：![了解Objenesis](/images/2015/8/0026uWfMgy6UzGJGBGYfc.jpg)

### 参考

[Objenesis项目官网](http://objenesis.org/)  
[GitHub：Objenesis](https://github.com/easymock/objenesis)  