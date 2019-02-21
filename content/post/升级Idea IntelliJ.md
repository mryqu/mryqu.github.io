---
title: '升级Idea IntelliJ'
date: 2019-02-21 15:30:23
categories: 
- Tool
- IntelliJ
tags: 
- intellij
- idea
- gradle
---
上次重装机器时，看看自己用的IntelliJ是ideaIU-2016.3.5，而可以升级的最新版本是ideaIU-2018.3.3。犹豫了一下，害怕万一将来跟公司的插件、设置冲突没法用，就没敢升级那么大，只升到ideaIU-2016.3.8而已。  
结果从已有项目导入Idea，不仅报错"Failed to notify progress listener."，而且依赖库也找不到。上网查了查才发现ideaIU-2018.2之前的版本不支持Gradle 5。  
好吧，升级到ideaIU-2018.3.4了。
