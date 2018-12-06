---
title: '聊聊mavenCenter和JCenter'
date: 2015-07-03 06:22:25
categories: 
- Tool
tags: 
- mavencenter
- jcenter
- 中央仓库
---
Gradle支持从maven中央仓库和JCenter上获取构件，那这两者有什么区别呢？

maven中央仓库（[http://repo1.maven.org/maven2/](http://repo1.maven.org/maven2/)）是由Sonatype公司提供的服务，它是ApacheMaven、SBT和其他构建系统的默认仓库，并能很容易被ApacheAnt/Ivy、Gradle和其他工具所使用。开源组织例如Apache软件基金会、Eclipse基金会、JBoss和很多个人开源项目都将构件发布到中央仓库。maven中央仓库已经将内容浏览功能禁掉了，可在[http://search.maven.org/](http://search.maven.org/)查询构件。

[ https://jcenter.bintray.com](https://bintray.com/bintray/jcenter'%3EJCenter%3C/a%3E%EF%BC%88%3Ca%20href=)）是由JFrog公司提供的Bintray中的Java仓库。它是当前世界上最大的Java和Android开源软件构件仓库。所有内容都通过内容分发网络（CDN）使用加密https连接获取。JCenter是[Goovy Grape](http://groovy.codehaus.org/Grape)内的默认仓库，Gradle内建支持（jcenter()仓库），非常易于在（可能除了Maven之外的）其他构建工具内进行配置。

JCenter相比mavenCenter构件更多，性能也更好。但还是有些构件仅存在mavenCenter中。
