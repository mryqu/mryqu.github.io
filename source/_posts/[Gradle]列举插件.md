---
title: '[Gradle] 列举插件'
date: 2015-07-27 06:17:30
categories: 
- Tool
- Gradle
tags: 
- gradle
- devops
- list
- plugin
---
下列方法可以列举出当前build.gradle牵涉的插件:
```
project.plugins.each {
   println it
}
```
