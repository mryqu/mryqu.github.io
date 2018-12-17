---
title: '[Gradle] buildScript块与allprojects块及根级别的repositories区别'
date: 2015-06-29 00:03:59
categories: 
- Tool
- Gradle
tags: 
- gradle
- buildscript
- repositories
- difference
- allprojects
---
一直对为什么buildScript块里定义了repositories而allprojects段或根还定义repositories没有思考过，偶然有了念头想要探究一下。

**build.gradle**：
<table><tbody><tr><td valian="top"><pre>buildscript {  
     repositories {
         ...
     }
     dependencies {
         ...
     }
}
</pre></td><td valian="top"><pre>allprojects { 
     repositories {
         ...
     }
     dependencies {
         ...
     }
}</pre></td><td valian="top"><pre>repositories {
     ...
}
dependencies {
     ...
}</pre></td></tr></tbody></table>

buildScript块主要是为了Gradle脚本自身的执行，获取脚本依赖插件。我在写的一篇博客[《尝试Artifactory》](/post/尝试artifactory)中Gradle脚本需要com.jfrog.artifactory插件才能执行成功，而这个插件是从URL为https://plugins.gradle.org/m2/的Maven仓库获得。
根级别的repositories主要是为了当前项目提供所需依赖包，比如log4j、spring-core等依赖包可从mavenCentral仓库获得。
allprojects块的repositories用于多项目构建，为所有项目提供共同所需依赖包。而子项目可以配置自己的repositories以获取自己独需的依赖包。

### 参考

[What's the difference between buildscript and allprojects in build.gradle?](http://stackoverflow.com/questions/30158971/whats-the-difference-between-buildscript-and-allprojects-in-build-gradle)  
[Gradle buildscript dependencies](http://stackoverflow.com/questions/13923766/gradle-buildscript-dependencies)  
[Gradle: Project](https://docs.gradle.org/current/dsl/org.gradle.api.Project.html)  