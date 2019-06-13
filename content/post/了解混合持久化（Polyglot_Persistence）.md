---
title: '了解混合持久化（Polyglot Persistence）'
date: 2015-04-27 05:58:13
categories: 
- db+nosql
tags: 
- 混合持久化
- polyglot
- persistence
- 优缺点
---
开发web程序的最早期时间，最被广泛使用的企业程序架构是将程序的服务器端组件打包为单个单元。很多企业Java应用程序由单个WAR或EAR文件组成。其它语言（比如Ruby，甚至C++）编写的应用程序也大抵如此。这种单体架构模式(monolithicapplication architecturepattern)往往通过一个数据访问层与单一类型的数据库相连接，所有不同用途的数据存储都存储在该数据库内。
![了解混合持久化（Polyglot Persistence）](/images/2015/4/0026uWfMgy6RPreFpxsf6.png)
数据库环境在过去的十多年里增长巨大。每个新出现的数据库相较于其它数据库，都在某些方面有着优势，但同时它们也做了各种各样的折衷。事实上，根据CAP定理不可能拥有完美的数据库，我们需要根据应用程序来选择哪种折衷是可接受的。带有这些约束的工作场景符合[Martin Fowler](https://twitter.com/martinfowler)推广的混合持久化思路。混合持久化的思路是指，你应该根据工作的不同需求选择相应合适的数据库，这样我们就能两者兼得了。
![了解混合持久化（Polyglot Persistence）](/images/2015/4/0026uWfMgy6RPrBn0MJ45.jpg)
混合持久化的优点显而易见：一个复杂的企业应用程序会使用很多类型的数据，对每种数据采用最适合的存储技术，可以带来性能的提升。随着微服务架构模式（Microservicearchitecturepattern）越来越受欢迎，复杂的企业应用程序将会被分解成很多的微服务，每个微服务内将对所操作的数据采用最适合的存储技术。

混合持久化的缺点也同样鲜明：以增加复杂性为代价。每种数据存储机制都有其学习成本，选择正确的数据存储也有决策成本。需要了解每种数据存储的性能瓶颈并不断迎接挑战。

[Martin Fowler](https://twitter.com/martinfowler)建议对战略性的项目采用混合持久化，这样才能通过新技术获得足够收益。

### 参考

[Polyglot Persistence](http://martinfowler.com/bliki/PolyglotPersistence.html)    
[The featuer is: Polyglot Persistence](http://martinfowler.com/articles/nosql-intro-original.pdf)    
[NoSQL精粹 第13章混合持久化](http://www.amazon.cn/%E5%9B%BE%E4%B9%A6/dp/B00EEQ2GPS)    
[](http://sww.sas.com/saspedia/Polyglot_persistence)    