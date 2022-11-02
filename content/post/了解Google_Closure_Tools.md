---
title: '了解Google Closure Tools'
date: 2014-11-15 09:48:03
categories: 
- FrontEnd
tags: 
- web
- javascript
- google
- closurecompiler
- 闭包工具集
---
hello一个html5-openui5项目，公司的编译系统在googlecc.xml（ant脚本）报了一个错，用googlecc做关键词搜了半天没弄清是什么东西，后来才发现是GoogleClosure Compiler。
不同于个人的小项目，企业级Web应用里面可能存在大量的Javascript代码。JS文件很多，文件块头还不小。不管是静态引入还是GoogleClosureLibrary/require.js这种模块化动态异步加载，下载时间长了，都会给Web用户带来不好的感知性能体验。很多Javascript压缩工具可以帮助减小JS文件大小，GoogleClosure Compiler就是其中一款。
谷歌2009年开源了其内部使用的JavaScript开发工具，[Google Closure Tools](https://developers.google.com/closure/)，希望帮助程序员更高效地开发出富客户端Web应用程序。该工具集由如下工具组成：
- [Closure Compiler](https://developers.google.com/closure/compiler):该优化器将JavaScript优化成紧凑、高性能的代码。它通过去除无用死代码、空格和注释、缩短长的局部变量名等方法压缩代码，检查语法、变量引用和变量类型，并对常见的JavaScript陷阱给出警告。
- [Closure Library](https://developers.google.com/closure/library)：功能广泛的，经过良好测试的，模块化的，跨浏览器的JavaScript库
- [Closure Templates](https://developers.google.com/closure/templates)：客户端和服务器端模板系统，可以有助于动态生成可重用的HTML和UI元素。ClosureTemplates摒弃了一个页面使用一个(大)模板，而是针对单个小组件使用(小)模板，以便复用。该模板可生成JavaScript或Java代码，因此同一模板可在客户端或者服务端使用。
- [Closure Linter](https://developers.google.com/closure/utilities)：按照[《谷歌JavaScript编程风格指南》](http://google-styleguide.googlecode.com/svn/trunk/javascriptguide.xml) 里面的指导方针对JavaScript代码进行编程风格检查和修复的工具
- [Closure Stylesheets](http://code.google.com/p/closure-stylesheets/)：支持很多谷歌扩展的增强格式表语言系统。可以定义和使用变量、函数、条件，以使格式表可读性增强、更易于维护。内建的工具可以将其编译成标准CSS。

##### 阅读列表：
[闭包：权威指南(Closure：The Definitive Guide)](https://www.safaribooksonline.com/library/view/_/9781449381882/?utm_medium=referral&utm_campaign=publisher&utm_source=oreilly&utm_content=book+page)  部分翻译 [前言](http://blog.csdn.net/zj831007/article/details/6797438)  [1](http://blog.csdn.net/zj831007/article/details/6798021)  [2](http://blog.csdn.net/zj831007/article/details/6801110)  [3](http://blog.csdn.net/zj831007/article/details/6817465)  [4](http://blog.csdn.net/zj831007/article/details/6821611)  [5](http://blog.csdn.net/zj831007/article/details/6831127)  
[Google Closure Compiler --js压缩优化](http://blog.csdn.net/ouailuo143/article/details/6537983)  
[Closure Compiler vs. YUICompressor](http://lifesinger.org/blog/2009/11/closure-compiler-vs-yuicompressor/)  
[应用 closure compiler 高级模式](http://yiminghe.iteye.com/blog/800881)  
[Closure Compiler 高级模式及更多思考](http://ued.taobao.org/blog/2010/12/advanced-optimization-in-closure-compiler-and-more/)  
[知乎为什么要选择 Closure Library 来作为 JavaScript 库，而不选择更流行的 jQuery 之流呢？](http://www.zhihu.com/question/19720509)  
[Google Closure Library介绍](http://leeight.appspot.com/article/24801.html)  