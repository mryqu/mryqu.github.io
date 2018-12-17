---
title: '[Gradle] 创建含有依赖库的jar文件'
date: 2015-10-18 05:54:13
categories: 
- Tool
- Gradle
tags: 
- gradle
- dependencies
- jar
- build
- include
---
想把自己的Gradle项目打成jar文件，但是'gradle build jar'生成的jar文件不含依赖库。

按照[Gradle – Create a Jar file with dependencies](https://www.mkyong.com/gradle/gradle-create-a-jar-file-with-dependencies/)改写了自己的build.gradle，成功包含了依赖库。但是依赖库不再是原来的jar文件，而是以目录的形式存在。

我的build.gradle
```
buildscript {
  repositories {
    mavenCentral()
  }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'

jar {
  baseName = 'HelloTwitter4J'
  version =  '0.1.0'
}

task fatJar(type: Jar) {
  baseName = 'HelloTwitter4J-all'
  version =  '0.1.0'
  manifest { 
    attributes "Main-Class": "com.yqu.cdfwebtool.twitter.TwitterRateInfo"
  }
  from { configurations.compile.collect { it.isDirectory() ? it : zipTree(it) } }
  with jar
}

repositories {
  mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
  compile 'org.twitter4j:twitter4j-core:4.0+'
}

task wrapper(type: Wrapper) {
  gradleVersion = '2.3'
}
```

构建好的jar文件：
![[Gradle] 创建含有依赖库的jar文件](/images/2015/10/0026uWfMzy747EATzDm5c.png)