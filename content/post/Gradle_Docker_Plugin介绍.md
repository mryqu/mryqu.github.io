---
title: 'Gradle Docker Plugin介绍'
date: 2015-07-14 05:57:33
categories: 
- Tool
- Gradle
tags: 
- gradle
- docker
- plugin
- bmuschko
- devops
---
### gradle-docker-plugin

[gradle-docker-plugin](https://github.com/bmuschko/gradle-docker-plugin)是由《Gradle实战》作者BenjaminMuschko实现的Gradle插件，用来管理Docker镜像和容器。gradle-docker-plugin实际上包括两个插件：
- com.bmuschko.docker-remote-api:提供通过远程API与Docker进行交互的定制任务![Gradle Docker Plugin介绍](/images/2015/7/0026uWfMgy6TRzjjFXt03.jpg)
- com.bmuschko.docker-java-application:为Java应用创建和上传Docker镜像![Gradle Docker Plugin介绍](/images/2015/7/0026uWfMgy6TRzq1Epkba.jpg)

### build.gradle

```
buildscript {
  repositories {
    jcenter()
  }

  dependencies {
    classpath 'com.bmuschko:gradle-docker-plugin:2.4.1'
  }
}
apply plugin: 'java'
apply plugin: 'application'
apply plugin: 'com.bmuschko.docker-java-application'
apply plugin: 'com.bmuschko.docker-remote-api'
```

### 参考

[GitHub：bmuschko/gradle-docker-plugin](https://github.com/bmuschko/gradle-docker-plugin)  