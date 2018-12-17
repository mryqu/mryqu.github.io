---
title: '了解CAS（集中式认证服务）'
date: 2014-07-11 21:25:29
categories: 
- Tech
tags: 
- cas
- 集中式认证服务
- sso
- security
---
**集中式认证服务**（Central AuthenticationService，缩写CAS）是一种针对万维网的单点登录协议。它的目的是允许一个用户访问多个应用程序，而只需提供一次凭证（如用户名和密码）。它还允许web应用程序在没有获得用户的安全凭据（如密码）的情况下对用户进行身份验证。“CAS”也指实现了该协议的软件包。
CAS协议涉及到至少三个方面：客户端Web浏览器、Web应用请求的身份验证和CAS服务器。它还可能涉及一个后台服务（例如数据库服务器），它并没有自己的HTTP接口，但与一个Web应用程序进行通信。
当客户端访问访问应用程序，请求身份验证时，应用程序重定向到CAS。CAS验证客户端是否被授权，通常通过在数据库对用户名和密码进行检查（例如Kerberos、LDAP或ActiveDirectory）。
如果身份验证成功，CAS令客户端返回到应用程序，并传递身份验证票（Securityticket）。然后，应用程序通过安全连接连接CAS，并提供自己的服务标识和验证票。之后CAS给出了关于特定用户是否已成功通过身份验证的应用程序授信信息。
CAS允许通过代理服务器进行多层身份验证。后端服务（如数据库或邮件服务器）可以组成CAS，通过从Web应用程序接收到的信息验证用户是否被授权。因此，网页邮件客户端和邮件服务器都可以实现CAS。
![了解CAS（集中式认证服务）](/images/2014/7/0026uWfMgy6WqIwsVWC36.jpg)

### 历史

CAS是由耶鲁大学的Shawn Bayern创始的，后来由耶鲁大学的Drew Mazurek维护。CAS1.0实现了单点登录。CAS2.0引入了多级代理认证（Multi-tier proxyauthentication）。CAS其他几个版本已经有了新的功能。
2004年12月，CAS成为Jasig（Java in Administration Special InterestGroup）的一个项目，2008年该组织负责CAS的维护和发展。CAS原名“Yale CAS”，现在则被称为“JasigCAS”。

### 参考

[Wiki：Central Authentication Service](https://en.wikipedia.org/wiki/Central_Authentication_Service)  
[Jasig CAS主页](http://jasig.github.io/cas/index.html)  
[GitHub：Jasig/java-cas-client](https://github.com/Jasig/java-cas-client)  
[GitHub：Jasig/cas](https://github.com/Jasig/cas)  
[CAS协议规范 3.0](https://github.com/Jasig/cas/blob/master/cas-server-documentation/protocol/CAS-Protocol.md)  