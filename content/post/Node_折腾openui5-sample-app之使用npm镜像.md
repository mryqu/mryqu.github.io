---
title: '折腾openui5-sample-app之使用npm镜像'
date: 2018-09-12
categories: 
- FrontEnd
tags: 
- build
- nodejs
- npm
---

学习了一下[SAP/openui5-sample-app](https://github.com/SAP/openui5-sample-app)，看看SAP是如何使用构建前端的。
[SAP/openui5-sample-app](https://github.com/SAP/openui5-sample-app)中npm安装模块是从https://www.npmjs.com/下载的，不知道从[淘宝NPM镜像](https://npm.taobao.org/)下载是否会快些。

对npm使用镜像有以下几种方式，这里我使用第三种：
1. 通过config命令
```
npm config set registry https://registry.npm.taobao.org npm info underscore
```
2. 命令行指定
```
npm --registry https://registry.npm.taobao.org info underscore
```
3. 在.npmrc文件中指定
```
registry = https://registry.npm.taobao.org
```

结果，速度上没什么感觉，都不快！