---
title: '[Gradle] 强制重新下载依赖'
date: 2015-04-13 05:49:35
categories: 
- Tool
- Gradle
tags: 
- gradle
- dependency
- refresh
- update
- --refresh-dependenci
---
强制Gradle重新下载依赖的方式有两种：
- 在Gradle命令中加入[--refresh-dependencies](http://www.gradle.org/docs/current/userguide/dependency_management.html#sec:cache_command_line_options)选项。该选项会让Gradle忽略已解析模块和构件的所有缓存项，对所配置的仓库重新进行解析，动态计算版本、更新模块和下载构件。
- 删除Gralde的缓存目录`~/.gradle/caches`。这个有点过于粗暴。

示例：
```
gradlew clean --refresh-dependencies build bootRun 
```