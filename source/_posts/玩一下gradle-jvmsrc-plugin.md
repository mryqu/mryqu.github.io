---
title: '玩一下gradle-jvmsrc-plugin'
date: 2015-05-27 05:51:01
categories: 
- Tool
- Gradle
tags: 
- gradle
- plugin
- jvmsrc
---
玩了一下[gradle-jvmsrc-plugin](https://github.com/adrianbk/gradle-jvmsrc-plugin)插件，使用这个插件后执行gradlecreateJvmSrcDirs可以根据Gradle项目的JVM语言插件（(java、groovy、scala、android等），自动创建默认的源代码、测试和资源包目录。例如：
- src/main/resources
- src/main/java/
- src/main/groovy/
- src/test/java/
- src/test/groovy/
- src/test/resources

刚上手总是报错，看了一下[CreateJvmSourceDirs.groovy](https://github.com/adrianbk/gradle-jvmsrc-plugin/blob/master/src/main/groovy/com/github/adrianbk/jvmsrc/tasks/CreateJvmSourceDirs.groovy)，定位到packageToDirectoryPath方法：
```
* What went wrong:
Execution failed for task ':HelloJvmsrc:createJvmSrcDirs'.
> character to be escaped is missing
```

按照如下[gradle-jvmsrc-plugin](https://github.com/adrianbk/gradle-jvmsrc-plugin)的说明，要配置基础包名。可是真按它介绍的带有.分割的包名就会出错，简单改成"com"这种没有.分割的包名就可以避免错误。
```
jvmsrc {
    packageName "com.mycompany.myproject.mymodule"
}
```

此外，[gradle-jvmsrc-plugin](https://github.com/adrianbk/gradle-jvmsrc-plugin)对空目录默认生成.gitkeep文件。
总体来说，用处不是很大，可以偷点懒！