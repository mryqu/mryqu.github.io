---
title: '[C++] 重温函数隐藏和重写'
date: 2013-10-26 08:23:25
categories: 
- C++
tags: 
- C++
- overload
- hide
- override
- virtual
---
首先回顾一下C++的重载、隐藏和重写概念：

- 在相同作用域中，同名不同参的函数称为重载，这是c++多态的一种表现。对相同名字的成员函数，编译器可以根据传递的参数类型调用相应的成员函数。同名不同参的全局函数和类成员函数由于作用域不同，不是重载。不能通过函数返回值进行重载。像int和float这样不同的参数类型，可能会由于隐式转换隐患而无法通过编译。
- 当派生类中的成员函数/变量和基类中的成员函数/变量同名时，会隐藏基类的成员函数/变量，也就是指在派生类调用这个同名的成员函数/变量，调用的是派生类的成员函数/变量，而不是基类的那个成员函数/变量。可以通过类名::成员函数/变量去访问基类中同名的成员函数/变量。
- 派生类中的成员函数与基类的成员函数同名同参，就称为重写。当直接访问成员函数调用的是在派生类中重写的函数而不是从基类继承下来的成员函数，如果要访问从基类继承下来的成员函数也是通过类名::成员函数这种方式去调用基类的成员函数。

下面的小示例testOverride.cpp用于测试添加virtual与否对重写的影响：
```
class BaseClass {
public:
  BaseClass() {
    cout << "BaseClass() on " << this << endl;
  }
  BaseClass(const BaseClass&) {
    cout << "BaseClass(BaseClass) on " << this <<  endl;
  }
  virtual void vfun1() {
    cout << "BaseClass:vfun1() on " << this <<  endl;
  }
  virtual void vfun2() {
    cout << "BaseClass:vfun2() on " << this <<  endl;
  }
  void fun1() {
    cout << "BaseClass:fun1() on " << this <<  endl;
  }
  void fun2() {
    cout << "BaseClass:fun2() on " << this <<  endl;
  }

  virtual ~BaseClass() {
    cout << "~BaseClass() on " << this << endl;
  }
};

class DerivedClass : public BaseClass {
public:
  DerivedClass():name(new string("NULL")) {
      cout << "DerivedClass() on " << this << endl;
  }
  DerivedClass(const string& n):name(new string(n)) {
      cout << "DerivedClass(string) on " << this << endl;
  }
  void vfun1() {
    cout << "DerivedClass:vfun1() on " << this <<  endl;
  }
  void fun1() {
    cout << "DerivedClass:fun1() on " << this <<  endl;
  }

  ~DerivedClass() {
    delete name;
    cout << "~DerivedClass(): name has been deleted on " << this << endl;
  }

private:
  void vfun2() {
    cout << "DerivedClass:vfun2() on " << this <<  endl;
  }
  void fun2() {
    cout << "DerivedClass:fun2() on " << this <<  endl;
  }

private:
  string* name;
};

int main() {
  cout << "=== test bo1 ===" << endl;
  BaseClass* bo1 = new BaseClass();
  bo1->vfun1();
  bo1->vfun2();
  bo1->fun1();
  bo1->fun2();
  delete bo1;
  cout << "=== test do1 ===" << endl;
  DerivedClass* do1 = new DerivedClass();
  do1->vfun1();
  // error: 'virtual void DerivedClass::vfun2()' is private 
  // within this context
  // do1->vfun2();
  do1->fun1();
  // error: 'void DerivedClass::fun2()' is private 
  // within this context
  // do1->fun2();
  delete do1;
  cout << "=== test bo2 ===" << endl;
  BaseClass* bo2 = new DerivedClass("123");
  bo2->vfun1();
  bo2->vfun2();
  bo2->fun1();
  bo2->fun2();
  delete bo2;
  
  return 0;
}
```

vfun2和fun2在BaseClass类中是public访问权限，而在DerivedClass类中是private访问权限。
- 对DerivedClass指针，vfun2和fun2无法访问，这个满足期望。
- 对于指向DerivedClass对象的BaseClass指针，vfun2和fun2仍然可以访问。**我只能在心里留一个"?"了！！！**

日志输出如下：
```
=== test bo1 ===
BaseClass() on 0x800e05058
BaseClass:vfun1() on 0x800e05058
BaseClass:vfun2() on 0x800e05058
BaseClass:fun1() on 0x800e05058
BaseClass:fun2() on 0x800e05058
~BaseClass() on 0x800e05058
=== test do1 ===
BaseClass() on 0x800e05040
DerivedClass() on 0x800e05040
DerivedClass:vfun1() on 0x800e05040
DerivedClass:fun1() on 0x800e05040
~DerivedClass(): name has been deleted on 0x800e05040
~BaseClass() on 0x800e05040
=== test bo2 ===
BaseClass() on 0x800e06040
DerivedClass(string) on 0x800e06040
DerivedClass:vfun1() on 0x800e06040
DerivedClass:vfun2() on 0x800e06040
BaseClass:fun1() on 0x800e06040
BaseClass:fun2() on 0x800e06040
~DerivedClass(): name has been deleted on 0x800e06040
~BaseClass() on 0x800e06040
```

对于指向DerivedClass对象的BaseClass指针，fun2仍然可以访问，且指向的是BaseClass的fun2实现，这个满足期望。而vfun2由于带virtual关键字，则指向的是DerivedClass的vfun2实现，但是在DerivedClass类中可是private访问权限呀，无法理解，**在心里继续保留"??"！！！**

下面对testOverride.cpp稍加改造，让DerivedClass类保护或私有继承BaseClass类。
```
class BaseClass {
public:
  BaseClass() {
    cout << "BaseClass() on " << this << endl;
  }
  BaseClass(const BaseClass&) {
    cout << "BaseClass(BaseClass) on " << this <<  endl;
  }
  virtual void vfun1() {
    cout << "BaseClass:vfun1() on " << this <<  endl;
  }
  virtual void vfun2() {
    cout << "BaseClass:vfun2() on " << this <<  endl;
  }
  void fun1() {
    cout << "BaseClass:fun1() on " << this <<  endl;
  }
  void fun2() {
    cout << "BaseClass:fun2() on " << this <<  endl;
  }

  virtual ~BaseClass() {
    cout << "~BaseClass() on " << this << endl;
  }
};

class DerivedClass : BaseClass {
public:
  DerivedClass():name(new string("NULL")) {
      cout << "DerivedClass() on " << this << endl;
  }
  DerivedClass(const string& n):name(new string(n)) {
      cout << "DerivedClass(string) on " << this << endl;
  }
  void vfun1() {
    cout << "DerivedClass:vfun1() on " << this <<  endl;
  }
  void fun1() {
    cout << "DerivedClass:fun1() on " << this <<  endl;
  }

  ~DerivedClass() {
    delete name;
    cout << "~DerivedClass(): name has been deleted on " << this << endl;
  }

private:
  void vfun2() {
    cout << "DerivedClass:vfun2() on " << this <<  endl;
  }
  void fun2() {
    cout << "DerivedClass:fun2() on " << this <<  endl;
  }

private:
  string* name;
};

int main() {
  cout << "=== test bo1 ===" << endl;
  BaseClass* bo1 = new BaseClass();
  bo1->vfun1();
  bo1->vfun2();
  bo1->fun1();
  bo1->fun2();
  delete bo1;
  cout << "=== test do1 ===" << endl;
  DerivedClass* do1 = new DerivedClass();
  do1->vfun1();
  // error: 'virtual void DerivedClass::vfun2()' is private 
  // within this context
  // do1->vfun2();
  do1->fun1();
  // error: 'void DerivedClass::fun2()' is private 
  // within this context
  // do1->fun2();
  delete do1;
  
  // cout << "=== test bo2 ===" << endl;
  // error: 'BaseClass' is an inaccessible 
  // base of 'DerivedClass'
  // BaseClass* bo2 = new DerivedClass("123");
  // bo2->vfun1();
  // bo2->vfun2();
  // bo2->fun1();
  // bo2->fun2();
  // delete bo2; 

  return 0;
}
```

修改后，编译器始终对指向DerivedClass对象的BaseClass指针返回error: 'BaseClass' is aninaccessible base of 'DerivedClass'，所以注释掉对bo2的测试。

新日志输出如下：
```
=== test bo1 ===
BaseClass() on 0x800e05058
BaseClass:vfun1() on 0x800e05058
BaseClass:vfun2() on 0x800e05058
BaseClass:fun1() on 0x800e05058
BaseClass:fun2() on 0x800e05058
~BaseClass() on 0x800e05058
=== test do1 ===
BaseClass() on 0x800e05040
DerivedClass() on 0x800e05040
DerivedClass:vfun1() on 0x800e05040
DerivedClass:fun1() on 0x800e05040
~DerivedClass(): name has been deleted on 0x800e05040
~BaseClass() on 0x800e05040
```

在不使用公开继承的方式下，示例结果都符合期望。

### 参考

[access specifiers](http://en.cppreference.com/w/cpp/language/access)    
[Derived classes](http://en.cppreference.com/w/cpp/language/derived_class)    
[virtual function specifier](http://en.cppreference.com/w/cpp/language/virtual)    