---
title: 'Servlet URL映射模式'
date: 2013-10-13 20:56:47
categories: 
- Service+JavaEE
tags: 
- servlet
- url
- mapping
- pattern
- 匹配
---

### Servlet 2.5规范中的映射规则:

- 完全匹配URL
- 匹配通配符路径
- 匹配扩展名
- 匹配默认servlet

### 特殊URL模式:

#### url-pattern:/*

servlet上的`/*` 会压制所有其他servlet。无论什么请求都会被该servlet处理。这是一种不好的URL模式。通常，仅将`/*` 用于[过滤器](http://download.oracle.com/javaee/6/api/javax/servlet/Filter.html)。它能通过调用<a href="http://download.oracle.com/javaee/6/api/javax/servlet/FilterChain.html#doFilter(javax.servlet.ServletRequest,%20javax.servlet.ServletResponse)">FilterChain#doFilter()</a>让请求继续由监听另外一个特定URL模式的任何servlet处理。

#### url-pattern:/

`/` 不会压制其他servlet。它仅会替换servlet容器内建的默认servlet，用于无法匹配任何已注册servlet的所有请求。一般仅调用在静态资源(CSS/JS/image/etc)和列举目录上。servlet容器内建默认servlet也能处理HTTP缓存请求、媒体（音视频）流和文件重新下载。由于必须负责默认servlet的所有任务，工作量不小，通常不会想要替换默认servlet。这也是一种不好的URL模式。关于为什么JSP页面不会调用这个servlet，是因为servlet容器的内建JSPservlet默认映射到`*.jsp`并被调用。

#### url-pattern:

这也有一个空字符串URL模式` `。当上下文根被请求时会被调用。这不同于welcome-file方法，因为它对任何子目录请求不会被调用，而welcome-file方法对任何局部有效但没有匹配上servlet的请求都会被调用。这更像需要“主页servlet”所要用到的URL模式。.
