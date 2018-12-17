---
title: 'Git+Gerrit+Gradle+Jenkins持续集成'
date: 2015-04-26 07:45:11
categories: 
- Tool
tags: 
- git
- gerrit
- gradle
- jenkins
- 持续集成
---
随着软件开发复杂度的不断提高，团队开发成员间如何更好地协同工作以确保软件开发的质量已经慢慢成为开发过程中不可回避的问题。尤其是近些年来，敏捷（Agile）在软件工程领域越来越红火，如何能再不断变化的需求中快速适应和保证软件的质量也显得尤其的重要。持续集成正是针对这一类问题的一种软件开发实践。它倡导团队开发成员必须经常集成他们的工作，甚至每天都可能发生多次集成。而每次的集成都是通过自动化的构建来验证，包括自动编译、发布和测试，从而尽快地发现集成错误，让团队能够更快的开发内聚的软件。

### Gerrit

![Git+Gerrit+Gradle+Jenkins持续集成](/images/2015/4/0026uWfMgy6S740PrKz5b.png)
[Gerrit](http://code.google.com/p/gerrit/)是基于[GWT](http://code.google.com/webtoolkit/) web应用的开源代码审查系统，为使用Git版本控制系统的项目提供在线代码审查。安卓开源项目（AOSP）用其来管理多代码库的庞大项目。Gerrit通过在自身代码库跟踪提交的Git变更集来提供代码审查的。它并排显示新旧文件，让审查者更容易对变更进行审查，并允许审查者添加内嵌注释。
提交的变更既可以被Jenkins这样的自动系统进行审查，也可以由同事进行审查。每个审查者检查代码变更、添加注释，然后将变更标记为“在我看来代码不错”(“没有打分”或“我期望你不要提交代码”)。验证者(例如Jenkins或其他人)通过构建和测试代码来验证变更。如果他们认为代码可行，则设置“在我看来代码不错”标记，Gerrit将尝试将变更合并到公开的“权威”代码库。文章[Life of a Patch](http://source.android.com/source/life-of-a-patch.html)描述了这一工作流:
![Git+Gerrit+Gradle+Jenkins持续集成](/images/2015/4/0026uWfMgy6S74FyWTi0c.png)

### Gradle

![Git+Gerrit+Gradle+Jenkins持续集成](/images/2015/4/0026uWfMgy6S77XQY2E84.jpg)
在Java构建工具的世界里，先有了Ant，然后有了Maven。Maven的CoC（约定优于配置）、依赖管理以及项目构建规则重用性等特点，让Maven几乎成为Java构建工具的事实标准。然而，冗余的依赖管理配置、复杂并且难以扩展的构建生命周期，都成为使用Maven的困扰。[Gradle](https://gradle.org/)作为新的构建工具，是基于Groovy语言的构建工具，既保持了Maven的优点，又通过使用Groovy定义的DSL克服了Maven中使用XML繁冗以及不灵活等缺点，支持依赖管理和多项目，而且它有非常完善的说明文档。目前，SpringSource、Hibernate等都采用Gradle来构建。


### Jenkins

![Git+Gerrit+Gradle+Jenkins持续集成](/images/2015/4/0026uWfMgy6S75J4qKt79.png)
[Jenkins](http://jenkins-ci.org/)，之前叫做Hudson，是一个开源项目，提供了一种易于使用的持续集成系统，使开发者从繁杂的集成中解脱出来，专注于更为重要的业务逻辑实现上。同时Jenkins能实施监控集成中存在的错误，提供详细的日志文件和提醒功能，还能用图表的形式形象地展示项目构建的趋势和稳定性。[Jenkins](http://jenkins-ci.org/)通过[Gerrit触发器插件](https://wiki.jenkins-ci.org/display/JENKINS/Gerrit+Trigger)可在新的Gerrit补丁集创建时开始使用Gerrit代码库中的代码进行构建项目，通过[Gradle插件](https://wiki.jenkins-ci.org/display/JENKINS/Gradle+Plugin)调用Gradle构建脚本，以帮助变更验证。

### 参考

[Git权威指南-第5篇-第32章 Gerrit 代码审核服务器](http://wenku.baidu.com/view/e7784e4f2e3f5727a5e96254.html)    
[Git+Gerrit+Gradle+Jenkins持续集成设置](http://openwares.net/linux/git_gerrit_gradle_jenkins_integration.html)    