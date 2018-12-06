---
title: '[Gradle] 在build.gradle中添加本地包依赖'
date: 2014-04-16 22:17:45
categories: 
- Tool
- Gradle
tags: 
- gradle
- local
- package
- dependencies
---
一直在Gradle中用的依赖包都是来自仓库，头一次添加本地包依赖。
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
    baseName = 'HelloAlgs'
    version =  '0.1.0'
}

repositories {
    mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
  runtime files('libs/algs4.jar')
}

task wrapper(type: Wrapper) {
  gradleVersion = '2.3'
}
```
