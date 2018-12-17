---
title: '[C++] 重温析构函数'
date: 2013-10-25 21:11:16
categories: 
- C++
tags: 
- c
- constructor
- destructor
- virtual
- copy
---
创建一个C++对象时，一般先调用父类构造函数，再调用自己的构造函数；而在销毁一个C++对象时，一般先调用自己的析构函数，再调用父类的析构函数。我用如下testDestructor.cpp进行测试。
```
class BaseClass {
public:
  BaseClass() {
    cout << "BaseClass() on " << this << endl;
  }
  ~BaseClass() {
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

  ~DerivedClass() {
    delete name;
    cout << "~DerivedClass(): name has been deleted on " << this << endl;
  }

private:
  string* name;
};

int main() {
  cout << "=== test bo1 ===" << endl;
  BaseClass* bo1 = new BaseClass();
  delete bo1;
  cout << "=== test do1 ===" << endl;
  DerivedClass* do1 = new DerivedClass();
  delete do1;
  cout << "=== test bo2 ===" << endl;
  BaseClass* bo2 = new DerivedClass("123");
  delete bo2;
  cout << "=== test bo3 ===" << endl;
  BaseClass bo3 = DerivedClass("321");
  return 0;
}
```

输出结果如下：
```
=== test bo1 ===
BaseClass() on 0x800e05104
~BaseClass() on 0x800e05104
=== test do1 ===
BaseClass() on 0x800e05058
DerivedClass() on 0x800e05058
~DerivedClass(): name has been deleted on 0x800e05058
~BaseClass() on 0x800e05058
=== test bo2 ===
BaseClass() on 0x800e06058
DerivedClass(string) on 0x800e06058
~BaseClass() on 0x800e06058
=== test bo3 ===
BaseClass() on 0x7fffffffe840
DerivedClass(string) on 0x7fffffffe840
~DerivedClass(): name has been deleted on 0x7fffffffe840
~BaseClass() on 0x7fffffffe840
~BaseClass() on 0x7fffffffe82f
```

- bo1：创建时调用BaseClass构造函数，销毁时调用BaseClass析构函数；
- do1：创建时先调用BaseClass构造函数，再调用DerivedClass构造函数；销毁时先调用DerivedClass析造函数，再调用BaseClass析造函数；
- bo2：为什么没有调用DerivedClass析造函数?
- bo3：怎么调用了两次BaseClass析造函数? 0x7fffffffe82f这个对象是什么，怎么没见到构造函数?
分析：

对于bo2对象来说，它是BaseClass指针，指向的是DerivedClass对象。由于BaseClass类中的析构函数是非虚析构函数，当删除父类指针指向的派生类对象时就不会触发动态绑定，因而只会调用父类的析构函数，而不会调用派生类的析构函数。为了防止这种情况的发生，C++中父类的析构函数应采用virtual虚析构函数。

对于bo3来说，上段代码实现实际是创建了一个DerivedClass类临时对象，然后通过BaseClass类的默认拷贝构造函数创建的bo3。因而第一个析构函数调用对象是DerivedClass类临时对象，第二个析构函数调用对象才是bo3。

下面对testDestructor.cpp进行改造：为BaseClass类的析构函数添加virtual关键字，添加BaseClass类的拷贝构造函数：
```
class BaseClass {
public:
  BaseClass() {
    cout << "BaseClass() on " << this << endl;
  }
  BaseClass(const BaseClass&) {
    cout << "BaseClass(BaseClass) on " << this <<  std::endl;
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

  ~DerivedClass() {
    delete name;
    cout << "~DerivedClass(): name has been deleted on " << this << endl;
  }

private:
  string* name;
};

int main() {
  cout << "=== test bo1 ===" << endl;
  BaseClass* bo1 = new BaseClass();
  delete bo1;
  cout << "=== test do1 ===" << endl;
  DerivedClass* do1 = new DerivedClass();
  delete do1;
  cout << "=== test bo2 ===" << endl;
  BaseClass* bo2 = new DerivedClass("123");
  delete bo2;
  cout << "=== test bo3 ===" << endl;
  BaseClass bo3 = DerivedClass("321");
  return 0;
}
```

新的测试日志显示bo2正确调用DerivedClass类的析构函数，而创建bo3的拷贝构造函数也确实被调用。
```
=== test bo1 ===
BaseClass() on 0x800e05058
~BaseClass() on 0x800e05058
=== test do1 ===
BaseClass() on 0x800e05040
DerivedClass() on 0x800e05040
~DerivedClass(): name has been deleted on 0x800e05040
~BaseClass() on 0x800e05040
=== test bo2 ===
BaseClass() on 0x800e06040
DerivedClass(string) on 0x800e06040
~DerivedClass(): name has been deleted on 0x800e06040
~BaseClass() on 0x800e06040
=== test bo3 ===
BaseClass() on 0x7fffffffe840
DerivedClass(string) on 0x7fffffffe840
BaseClass(BaseClass) on 0x7fffffffe820
~DerivedClass(): name has been deleted on 0x7fffffffe840
~BaseClass() on 0x7fffffffe840
~BaseClass() on 0x7fffffffe820
```
