---
title: '[Gradle] 在子项目中共享项目属性'
date: 2015-05-22 06:09:34
categories: 
- Tool
- Gradle
tags: 
- gradle
- ext
- share
- property
- variable
---
build.gradle:
```
buildscript {
  repositories {
    mavenCentral()
  }
}

subprojects {
  apply plugin: 'java'
  apply plugin: 'eclipse'
  apply plugin: 'idea'
 
  repositories {
    mavenCentral()
  }
        
  sourceCompatibility = 1.8
  targetCompatibility = 1.8
  
  ext {
     HadoopVersion = '2.7.x'
     JUnitVersion = '4.11'
     ......
  }
}
```

HelloHadoopClient/build.gradle：
```
jar {
  baseName = 'hello-hadoopclient'
  version =  '0.1.0'
}

dependencies {
  compile "org.apache.hadoop:hadoop-common:${HadoopVersion}"
  testCompile "junit:junit:${JUnitVersion}"
}
```

HelloMapReduce/build.gradle：
```
jar {
  baseName = 'hello-mapreduce'
  version =  '0.1.0'
}

dependencies {
  compile "org.apache.hadoop:hadoop-common:${HadoopVersion}"
  compile "org.apache.hadoop:hadoop-mapreduce-client-jobclient:${HadoopVersion}"
  testCompile "junit:junit:${JUnitVersion}"
  testCompile "org.apache.mrunit:mrunit:${MRUnitVersion}:hadoop2"
}
```

通过在子项目共享项目属性HadoopVersion，所有子项目全都依赖一个版本的Hadoop库了。当Hadoop库版本需要更新时，仅修改根项目的build.gradle即可。
