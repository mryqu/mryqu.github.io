---
title: 'Node.js npm代理设置'
date: 2015-09-30 06:06:46
categories: 
- Tool
tags: 
- node.js
- npm
- proxy
- configuration
---
用Gradle编译当前一个项目，总是报告Node.js的包管理工具npm安装node包失败。美国那边没有问题，不知道是否跟防火墙有关。

npm的代理设置为：
```
npm config set proxy http://proxyServer:proxyPort
npm config set https-proxy http://proxyServer:proxyPort
```

操作显示能解决我的部分问题！

### 参考

[NPM小结](http://www.cnblogs.com/chyingp/p/npm.html)  