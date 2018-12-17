---
title: '为Artifactory设置proxy和remote repository'
date: 2015-07-19 00:09:58
categories: 
- Tool
tags: 
- artifacotry
- proxy
- remote
- reposiotry
---
### 设置proxy

我一上来先设置代理，否则连不上远程仓库呀。
![为Artifactory设置proxy和remote repository](/images/2015/7/0026uWfMzy74kkY10jie4.jpg)
### 设置remote repository

远程仓库已经默认设置了jcenter，估计很少需要其他仓库了。
![为Artifactory设置proxy和remote repository](/images/2015/7/0026uWfMzy74kkGmn7g8e.jpg)
但不管三七二十一，还是把mavenCentral和gradlePlugins加上吧。全部勾选了Suppress POMConsistency Checks，取消勾选Handle Snapshots。
- mavenCentral: http://repo1.maven.org/maven2/
- gradlePlugins: https://plugins.gradle.org/m2/

测试结果显示，所需构件实际上都是从jcenter下载的，其他两个暂时还没用到。
