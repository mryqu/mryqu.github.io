---
title: '面向对象设计的SOLID原则和设计模式'
date: 2007-11-23 13:43:37
categories: 
- Tech
tags: 
- OOAD
- S.O.L.I.D
- design pattern
- 设计模式
- UML
---
## S.O.L.I.D

S.O.L.I.D是面向对象设计和编程(OOD&OOP)中几个重要编码原则(ProgrammingPrinciple)的首字母缩写。
- SRP :The Single Responsibility Principle单一责任原则 
- OCP :The Open Closed Principle 开放封闭原则 
- LSP :The Loskop Substitution Principle里氏替换原则 
- DIP  :The Dependency Inversion Principle依赖倒置原则 
- ISP  :The Interface Segregation Principle接口分离原则

### 单一责任原则： 

当需要修改某个类的时候原因有且只有一个（THERE SHOULD NEVER BE MORE THAN ONE REASONFOR A CLASS TOCHANGE）。换句话说就是让一个类只做一种类型责任，当这个类需要承当其他类型的责任的时候，就需要分解这个类。
比如：报表的内容和报表的格式都会变化改变，但是这两种变化的性质不同，一个是实质内在，一个是表面上的，SRP认为这是问题的两个方面，其实代表不同的职责，应该将它们分离放入不同的类或模块中，而不应该放在一起，否则的话，因为不同原因发生变化，导致对方变动，比如报表格式变新的样式，这个变化是不应该涉及到内容的。
反模式: 一个类处理的事情太多了, 应当进行分解

### 开放封闭原则 

软件实体应该是可扩展，而不可修改的。也就是说，对扩展是开放的，而对修改是封闭的。这个原则是诸多面向对象编程原则中最抽象、最难理解的一个。
反模式: 一个模块的修改将导致其他模块的修改

### 里氏替换原则 

当一个子类的实例应该能够替换任何其超类的实例时，它们之间才具有is-A关系
子类可以代替基类, 客户使用基类, 他们不需要知道派生类所做的事情. 
反模式: if(a instanceof TypeA) {...}
这是一个针对行为职责可替代的原则，如果S是T的子类型，那么S对象就应该在不改变任何抽象属性情况下替换所有T对象。这里的抽象属性是指对象的字段属性。

我们使用接口时经常碰到一个问题，需要使用接口子类中的方法，而接口中没有这个方法，那么只能要么修改接口，要么将接口downcast为具体子类。为什么会出现这个尴尬现象？有几种情况导致，其中一种情况是是将当前的类重构到接口时，没有将类中所有方法extract到接口中，可能因为这些被你漏掉的方法不属于当前接口，那么，它又违背了单一职责原理，说明你当前这个类的方法设计得又不合理。

所以，如果单一职责设计的足够好，那么LSP原则则是检验的方法。LSP原则是对对象职责和协作的一种检验约束方法，此外还有DBC(designby contract)原则，为了保证实现接口的子类职责行为的约束，DBC三要素都必须被重视满足：
1. Preconditions前置条件不能在子类中被强化。
2. Postconditions后置条件不能在子类中被弱化。
3. 子类自身不变性Invariants必须在子类自己中封装满足。这也是前面“不改变任何抽象属性”的意思。

### 依赖倒置原则

1. 高层模块不应该依赖于低层模块，二者都应该依赖于抽象 
2. 抽象不应该依赖于细节，细节应该依赖于抽象

要针对接口编程，不针对实现编程。

### 接口分离原则 

不能强迫用户去依赖那些他们不使用的接口。换句话说，使用多个专门的接口比使用单一的总接口总要好。
反模式：肥类(fat class), 有成堆的方法, 而且用户很少使用
SOLID原则如今在DCI架构中能够得到真正实现和发展。

包的设计原则： 
1. 发布/重用等价原则（REP）我们创建包的目的是为了给别人重用，所以重用的粒度就是发布的粒度。 
2. 公共闭合原则（CCP）因为相同原因而被修改的类应该放入一个包中，对应于“单一责任原则”。 
3. 公共重用原则（CRP）应该尽可能地将只被一个客户使用的包与被多个不同客户使用到的包分开。对应于“接口隔离原则” 
4. 非循环依赖原则（ADP）不要在包依赖图中出现循环依赖。如a依赖于b，b依赖于c，同时c又依赖于a。 
5. 稳定依赖原则（SDP）要依赖于稳定的包，而不要依赖于经常变化的包。对应于“依赖倒置原则”。 
6. 稳定抽象原则（SAP）稳定的包应当是抽象的。对应于“依赖倒置原则”。

## 设计模式 - DesignPattern

![All Design Pattern](/images/2007/11/0026uWfMty6EOrFGw6T8b.jpg)

### 创建型 

#### Abstract Factory（抽象工厂模式） ->(简单工厂模式) 
![Simple Factory](/images/2007/11/0026uWfMty6EOqOJ49L65.jpg)![Abstract Factory](/images/2007/11/0026uWfMty6EOqN5gasf0.jpg)

#### Factory Method（工厂模式） 
![Factory Method](/images/2007/11/0026uWfMty6EOqQK4Pn91.jpg)

#### Builder（生成器模式） 
![Builder](/images/2007/11/0026uWfMty6EOr0jFlk56.jpg)

#### Singleton（单件模式） ->(多例模式) 
![Singleton](/images/2007/11/0026uWfMty6EOr2oU0Z9d.png)

#### Prototype（原型模式） 
![Prototype](/images/2007/11/0026uWfMty6EOr5eluCbe.jpg)

### 结构型 

#### Adapter（适配器模式） 
![Adapter](/images/2007/11/0026uWfMty6EOr6bIGu22.jpg)

#### Bridge（桥接模式） 
![Bridge](/images/2007/11/0026uWfMty6EOr6ZUg55d.jpg)

#### Composite（组合模式） 
![Composite](/images/2007/11/0026uWfMty6EOr8EXtG7c.jpg)

#### Decorator（装饰模式） 
![Decorator](/images/2007/11/0026uWfMty6EOraxt72e0.jpg)

#### Facade（外观模式，门面模式） 
![Facade](/images/2007/11/0026uWfMty6EOrck0eAc8.jpg)

#### Flyweight（享元模式） ->(不变模式) 
![Flyweight](/images/2007/11/0026uWfMty6EOrdjcdtcb.jpg)

#### Proxy（代理模式） 
![Proxy](/images/2007/11/0026uWfMty6EOrgcvpW84.jpg)

### 行为型 

#### Chain of Responsibility（职责链模式） 
![Chain of Responsibility](/images/2007/11/0026uWfMty6EOrjzbhRb7.jpg)

#### Command（命令模式） 
![Command](/images/2007/11/0026uWfMty6EOrm2vi74f.jpg)

#### Interpreter（解释器模式） 
![Interpreter](/images/2007/11/0026uWfMty6EOrn0TRN73.jpg)

#### Iterator（迭代器模式） 
![Iterator](/images/2007/11/0026uWfMty6EOrpghlqa4.png)

#### Mediator（中介者模式） 
![Mediator](/images/2007/11/0026uWfMty6EOrq7gpR0b.jpg)

#### Memento（备忘录模式）
![Memento](/images/2007/11/0026uWfMty6EOrrnNWx09.jpg)
 

#### Observer（观察者模式） 
![Observer](/images/2007/11/0026uWfMty6EOrzF3Aoe4.jpg)

#### State（状态模式） 
![State](/images/2007/11/0026uWfMty6EOrALV0re7.jpg)

#### Strategy（策略模式）
![Strategy](/images/2007/11/0026uWfMty6EOrBSlfTed.png)

#### TemplateMethod（模板方法模式） 
![TemplateMethod](/images/2007/11/0026uWfMty6EOrD2BNI1e.jpg)

#### Visitor（访问者模式） 
![Visitor](/images/2007/11/0026uWfMty6EOrE85fZ53.png)
