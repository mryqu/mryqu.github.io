---
title: '重温MVC:一个很好的MVC图'
date: 2014-03-26 22:28:35
categories: 
- Tech
tags: 
- mvc
- model/view/controlle
- pattern
- uml
---
今天看了一个帖子[A terrific Model View Controller (MVC) diagram](http://alvinalexander.com/uml/uml-model-view-controller-mvc-diagram)，感觉文中说的很对：一个技术如果能简洁地表达出来，才容易被人记住并记的牢。该文中的[Model/View/Controller](http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)UML图共有两个，第一个图非常简单，仅展示作者用于控制器、视图和模型的符号。![重温MVC:一个很好的MVC图](/images/2014/3/0026uWfMgy6P17tGcS7ab.png)第二个图展示了MVC模式允许的操作和禁止的操作。![重温MVC:一个很好的MVC图](/images/2014/3/0026uWfMgy6P17znbBj8d.png)
- 用户与视图对象交互。
- 视图对象和控制器对象可以相互访问调用。
- 不同的控制器对象之间可以相互访问调用。
- 控制器对象可以访问调用模型对象。
- 除了上面这四种访问方式，禁止对象之间的其他通信方法。