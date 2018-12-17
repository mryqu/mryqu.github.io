---
title: '[Gradle] 阻止build任务执行测试任务'
date: 2015-04-14 05:53:30
categories: 
- Tool
- Gradle
tags: 
- gradle
- skip
- task
---
在执行gradle build时想要阻止执行测试任务，方法如下：

- 第一种方法：如[Gradle用户指南的14.8 Skipping tasks](https://docs.gradle.org/current/userguide/more_about_tasks.html#N10E33)所说，在build.gradle里设置"test.enabled=false"，执行`gradle build`
- 第二种方法：在build.gradle里设置"check.dependsOn.remove(test)"，执行`gradle build`
- 第三种方法：执行`gradle build -x test`