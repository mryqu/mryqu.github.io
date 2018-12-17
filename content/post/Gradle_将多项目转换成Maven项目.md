---
title: '[Gradle] 将多项目转换成Maven项目'
date: 2016-09-02 05:46:07
categories: 
- Tool
- Gradle
tags: 
- gradle
- maven
- multiple-project
- convert
---
手头有一个构建多项目的Gradle构建脚本，但是一个哥们问我能不能换成Maven的，搜到一篇[gradle项目与maven项目相互转化](http://www.cnblogs.com/yjmyzz/p/gradle-to-maven.html)，照着实践，证明多项目构建也是可行的。

#### 文件结构介绍

- ts-demo目录
  - setting.gradle
  - build.gradle
  - ts-service目录
    - build.gradle
    - src目录
  - ts-webapp目录
    - build.gradle
    - src目录

#### ts-demo/setting.gradle
```
rootProject.name = 'ts-demo'

include "ts-service"
include "ts-webapp"

project(":ts-service").name = "ts-service"
project(":ts-webapp").name = "ts-webapp"
```

#### ts-demo/build.gradle
```
buildscript {
  repositories {
    mavenCentral()
  }
}

allprojects {
  apply plugin: 'java'
  apply plugin: 'eclipse'
  apply plugin: 'idea'
  apply plugin: 'maven'
 
  repositories {
    mavenCentral()
  }
    
  group = 'com.yqu'
  version =  '0.1.0'
  
  task writeNewPom {
  pom {
    project {
        inceptionYear '2016'
        licenses {
          license {
            name 'The Apache Software License, Version 2.0'
            url 'http://www.apache.org/licenses/LICENSE-2.0.txt'
            distribution 'repo'
          }
        }
      }
    }.writeTo("$buildDir/pom.xml")
  }
  
  sourceCompatibility = 1.8
  targetCompatibility = 1.8  
}
```

#### ts-demo/ts-service/build.gradle
```
jar {
    baseName = 'ts-service'
    version =  '0.1.0'
}

dependencies {
    compile("org.springframework.boot:spring-boot-starter-actuator")
    compile("org.springframework.boot:spring-boot-starter-web")
    compile("com.fasterxml.jackson.core:jackson-databind:2.6.0")
    compile("org.springframework.hateoas:spring-hateoas")
    compile("org.springframework.plugin:spring-plugin-core:1.1.0.RELEASE")
    compile("com.jayway.jsonpath:json-path:0.9.1")
}

```

#### ts-demo/ts-webapp/build.gradle
```
......
```

#### 转换

在ts-demo目录下执行gradlewriteNewPom，即可在父目录和两个子项目目录下的build目录找到生成的pom.xml文件了。
