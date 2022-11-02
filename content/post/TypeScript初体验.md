---
title: 'TypeScript初体验'
date: 2017-02-08 05:59:50
categories: 
- FrontEnd
tags: 
- typescript
- javascript
- ecmascript
---
### TypeScript介绍

鉴于JavaScript这种脚本语言很难应用于大规模Web应用的开发，微软公司在2012年推出了新的开源编程语言——TypeScript。作为Object Pascal和C#之父Anders Hejisberg的又一作品，TypeScript是JavaScript的超集，但完全兼容JavaScript。相比于JavaScript，TypeScript增加了可选类型、类和模块，扩展了原有的语法，使得代码组织和复用变得更加有序，方便进行大型Web应用的开发。

### 安装

TypeScript可通过npm进行安装：
```
npm install -g typescript
```
查看TypeScript版本：
```
C:\quTemp>tsc -v
Version 2.1.6
```
我开发主要使用IntelliJ IDEA，它可以很好的编辑TypeScript文件。不过对于一些小练习，还是安装Sublime的TypeScript插件好了：![Sublime Typescript Plugin](/images/2017/02/sublimeTypescriptPlugin.png)
### 初体验

menu.ts源文件（来自参看一）：![menu.ts code](/images/2017/02/menu_ts.png)
编译：
```
tsc menu.ts
```
执行：![run Menu](/images/2017/02/runMenu.png)
编译结果menu.js：![generated menu.js](/images/2017/02/menu_js.png)
测试：![test menu.js](/images/2017/02/testMenuJs.png)
### 下一步计划

学习一下《TypeScript Essentials》和《Mastering TypeScript》这两本书。

### 参考
* * *
[Learn TypeScript in 30 Minutes](http://tutorialzine.com/2016/07/learn-typescript-in-30-minutes/)  
[Learn TypeScript in Y minutes](https://learnxinyminutes.com/docs/typescript/)  





