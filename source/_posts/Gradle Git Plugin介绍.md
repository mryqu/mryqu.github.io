---
title: 'Gradle Git Plugin介绍'
date: 2015-07-12 21:15:17
categories: 
- Tool
- Gradle
tags: 
- gradle
- git
- plugin
- ajoberstar
- devops
---
### Grgit和gradle-git

Git是一个很流行的分布式版本管理工具。能在构建过程中与Git进行交互，可以提供更强大和更一致的结果。

[JGit](https://eclipse.org/jgit/)提供了与Git仓库交互的强大JavaAPI。然而，在Groovy上下本使用它会笨重，需要在所要执行的表达式包一堆换七八糟的东东。[Grgit](https://github.com/ajoberstar/grgit)是Andre wOberstar实现的[JGit](https://eclipse.org/jgit/)封装器，为基于Groovy的工具与Git仓库交互提供了更简洁流畅的API。
gradle-git同样是由Andrew Oberstar实现的一系列Gradle插件：
- org.ajoberstar.grgit - 提供一个[Grgit](https://github.com/ajoberstar/grgit)实例，允许与Gradle项目所在的Git仓库交互
- org.ajoberstar.github-pages - 向Github仓库的gh-pages分支发布文件
- org.ajoberstar.release-base -提供用于从项目状态和所在Git仓库推断当前项目版本和创建新版本的通用结构
- org.ajoberstar.release-opinion -用于org.ajoberstar.release-base的默认选项，遵从[语义版本控制（Semantic Versioning）](http://semver.org/)下面是一个Gradle任务示例，用于从Git仓库克隆项目。

### build.gradle

```
buildscript {
  repositories {
    mavenCentral()
  }
  dependencies {
    classpath 'org.ajoberstar:gradle-git:1.2.0'
  }
}

import org.ajoberstar.gradle.git.tasks.*

task cloneGitRepo(type: GitClone) {
  def destination = file("destination_folder")
  uri = "your_git_repo_uri"
  destinationPath = destination
  bare = false
  enabled = !destination.exists() //to clone only once
}
```

### 参考

[GitHub：ajoberstar/gradle-git](https://github.com/ajoberstar/gradle-git)  
[GitHub：ajoberstar/grgit](https://github.com/ajoberstar/grgit)  