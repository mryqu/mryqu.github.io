---
title: 'Postman使用笔记'
date: 2015-09-15 06:15:18
categories: 
- Tool
- NetWork
tags: 
- postman
- rest
- api
- 工具
- 测试
---
以前用过cURL和rest-shell进行RESTAPI测试，最近偶然看到了Postman。Postman是一款Chrome插件，强大、便利，可以在浏览器里直接测试RESTAPI。

### 安装

在Chrome浏览器里进入[Postman插件安装地址](https://chrome.google.com/webstore/detail/postman-rest-client/fdmmgilgnpjigdojojpjoooidkmcomcm)即可安装Postman。
![Postman使用笔记](/images/2015/9/0026uWfMgy6Vs7MGFN1d3.jpg)

### 使用

Postman可以模拟各种Http请求，并且可以额外设置特殊的URL参数、Http头以及Basic Auth、DigestAuth、OAuth 1.0等认证信息。在展现Http响应上，Postman支持完美打印，JSON、XML或是HTML都会整理成人类阅读的格式，有助于我们更清楚地查看响应内容。![Postman使用笔记](/images/2015/9/0026uWfMgy6VtgqXkfXb5.jpg)![Postman使用笔记](/images/2015/9/0026uWfMgy6Vti0NGNTb5.jpg)

### 特色功能

- **更多的Http方法**：Postman除了支持GET、POST、PUT、PATCH、DELETE、HEAD、OPTIONS这些常用Http方法，还支持COPY、LINK、UNLINK、PURGE。
- **集合（Collection）功能**：Postman可以管理Http请求的集合，在做完单个测试时，可以将该请求存入特定集合内。这样在后继的重复测试，无需重新输入Http请求，就可以快速测试并获得结果。集合支持输入或导出，便于团队共享。
- **设置环境变量（Environment）**：Postman可以管理环境变量。一般我们有可能有多种环境：development、staging或local，每种环境下的请求URL有可能各不相同。通过环境变量，在切换环境测试时无需重写Http请求。

### 参考

[Postman插件安装地址](https://chrome.google.com/webstore/detail/postman-rest-client/fdmmgilgnpjigdojojpjoooidkmcomcm)  
[Github：postmanlabs](https://github.com/postmanlabs/)  
[Postman官方博客](http://blog.getpostman.com/)  
[HTTP Link and Unlink Methods](http://tools.ietf.org/id/draft-snell-link-method-01.html)  