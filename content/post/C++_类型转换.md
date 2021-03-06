---
title: '[C++] 类型转换'
date: 2007-12-15 21:20:37
categories: 
- C++
tags: 
- C++
- cast
- type conversion
---
C++中的强制转换函数共有以下几种：
- C 风格（C-style）强制转型: `(Type) expr`
- 函数风格（Function-style）强制转型: `Type( expr )`要注意的是`Type(expr)`语法上等同`(Type)expr`，但是要避免使用。`Type(expr,expr_else)`是安全的。
- `static_cast <type-id> ( expr )`：用于非多态类型转换。static_cast是第一个应该尝试的类型转换。它完成类似隐性类型转换（例如int转float，指针转void*）这样的工作，也能调用显式（或隐式）类型转换函数。在很多情况下，显式使用static_cast没有必要。static_cast也能在继承层次上进行类型转换。在进行上行转换（子类转父类）是没有必要的，下行转换只要没有虚拟继承的情况下也可用，但是它不会做任何检查，下行转换为非该对象真正的类型时行为不明确。type-id和expr必须是指针、引用、算术类型或枚举类型。
- `dynamic_cast <type-id> ( expr )`：用于多态类型转换。dynamic_cast是几乎唯一用于处理多态类型转换的。你可以将一个指针或引用转换成其他类的多态类型（一个多态类型至少有一个虚函数，不管是声明的还是继承的）。它不仅经可用于下行转换，还可以横向转换或上行转换到另一个继承链。dynamic_cast会检查转换是否可行，如果可行则返回期望的对象，否则原表达式是指针的话返回空指针、原表达式是引用的话抛出std::bad_cast异常。dynamic_cast有一些限制。当继承层次上有相同类型的多个对象（DiamondDerivationproblem，菱形派生问题）而又没有使用虚拟继承时，无法工作。它仅能遍历公开继承，在遍历保护继承或私有继承时总是失败。非公开的继承很少使用，所以这种问题也很少见。Type-id必须是类的指针、类的引用或者void*；如果type-id是类指针类型，那么expr也必须是一个指针，如果type-id是一个引用，那么exp也必须是一个引用。
- `const_cast <type-id> ( expr)`：用来修改类型的const、volatile和__unaligned属性。const_cast可用于对一个变量添加或删除const属性，其他C++类型转换（甚至reinterpret_cast）没有删除const的能力。需要注意的是原有变量是const的，如果修改之前的常量值会造成不确定的行为。如果一个const引用指向非常量，对引用去掉const是安全的。当重载的成员函数是const的时候非常有用，例如你可以对一个对象添加const以调用重载的成员函数。const_cast也能对volatile属性进行修改，只是会更少被用到。除了const 或volatile修饰之外， type_id和expr的类型是一样的。
- `reinterpret_cast <type-id> ( expr )`：对类型简单重新解释reinterpret_cast是最危险的类型转换，应该尽可能少地使用。它直接将一个类型转换成另外一个，例如将一个指针获得的值转换成另一种类型、将指针存储成整型值、或其他一些丑陋的转换。基本上，reinterpret_cast仅能保障转换回原类型是正常的，你能在中间类型不小于原有类型的情况下获得相同的值。有很多reinterpret_cast不能做的转换。主要用于转义转换和二进制处理，例如将原始数据流转成实际数据、或将数据存储在对齐指针的低bit位中。type-id必须是一个指针、引用、算术类型、函数指针或者成员指针。

其中前两种称为旧风格（old-style）的强制转型，后四种为标准C++的类型转换符。

旧风格的强制转型可以看成按下列顺序排列的第一个成功的类型转换组合：
- const_cast
- static_cast (忽略访问限制)
- static_cast接着const_cast
- reinterpret_cast
- reinterpret_cast接着const_cast

旧风格的强制转型比较危险，因为可能被解析成reinterpret_cast，而且解析成static_cast时会忽略访问权限控制（能做其他类型转换无法实现的功能）。此外，使用旧风格的强制转型也不如C++类型转换容易查找，所以一般不推荐使用。

### 参考

[Type conversions](http://www.cplusplus.com/doc/tutorial/typecasting/)  
[MSDN：Casting Operators](https://msdn.microsoft.com/en-us/library/5f6c9f8h.aspx)  
[When should static_cast, dynamic_cast, const_cast and reinterpret_cast be used?](http://stackoverflow.com/questions/332030/when-should-static-cast-dynamic-cast-const-cast-and-reinterpret-cast-be-used)  
[总结C++中的所有强制转换函数(const_cast，reinterpret_cast，static_cast，dynamic_cast)](http://bbs.csdn.net/topics/210039564)  
[In C++, why use static_cast(x) instead of (int)x?](http://stackoverflow.com/questions/103512/in-c-why-use-static-castintx-instead-of-intx)  