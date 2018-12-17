---
title: '尝试Artifactory'
date: 2015-06-30 06:28:36
categories: 
- Tool
tags: 
- artifactory
- packagemanagement
- jfrog
- repository
- gradle
---
### Artifactory简介

首先，JFrogArtifactory是统一构件仓库管理器，全面支持任何语言或技术创建的软件包。Artifactory是一个适合企业的仓库管理器，支持安全、集群和高可用的Docker注册。与所有主流CI/CD和DevOps工具进行集成，Artifactory提供了端到端的自动化的解决方案用以追踪从开发阶段到生产环境阶段中的构件。
![尝试Artifactory](/images/2015/6/0026uWfMzy74hynFSMRd5.jpg)

### 安装Artifactory

在[https://www.jfrog.com/open-source/](https://www.jfrog.com/open-source/)下载开源版的jFrogArtifactory，按照[JFrog Artifactory用户指南](http://wiki.jfrog.org/confluence/display/RTF)即可轻松安装和使用。
![尝试Artifactory](/images/2015/6/0026uWfMzy74hcyzM0Pbb.jpg)

### 发布构件

#### 使用Gradle构建脚本生成器

![尝试Artifactory](/images/2015/6/0026uWfMzy74j5LEjTf7d.jpg)

#### gradle.properties

```
artifactory_contextUrl=http://localhost:8081/artifactory
artifactory_user=admin
artifactory_password=password
group = com.yqu
version = 0.1.0-SNAPSHOT
description = Hello artifactory
```

#### build.gradle

```
buildscript {
    repositories {
        maven {
            url "https://plugins.gradle.org/m2/"
        }      
    }
    dependencies {
        //Check for the latest version here: 
        //    http://plugins.gradle.org/plugin/com.jfrog.artifactory
        classpath "org.jfrog.buildinfo:build-info-extractor-gradle:+"
    }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'
apply plugin: 'maven-publish'
apply plugin: "com.jfrog.artifactory"

jar {
    baseName = 'HelloArtifactory'
}

artifacts {
    archives jar
}

publishing {
    publications {
        maven {
            from components.java
        }
    }
}

artifactory {
    //The base Artifactory URL if not overridden by the publisher/resolver
    contextUrl = "${artifactory_contextUrl}" 
    publish {
        repository {
            repoKey = 'libs-snapshot-local'
            username = "${artifactory_user}"
            password = "${artifactory_password}"
            maven = true
            
        }
        defaults {
            publications ('maven
        }
    }
    resolve {
        repository {
            repoKey = 'libs-snapshot'
            username = "${artifactory_user}"
            password = "${artifactory_password}"
            maven = true
            
        }
    }    
}

repositories {
    maven {
        url 'http://localhost:8081/artifactory/plugins-release'
        credentials {
            username = "${artifactory_user}"
            password = "${artifactory_password}"
        }
    }
    mavenCentral()
}

sourceCompatibility = 1.7
targetCompatibility = 1.7
```

#### 发布结果

```
C:\test123\HelloArtifactory>gradlew clean build artifactoryPublish
[buildinfo] Not using buildInfo properties file for this build.
:clean
:compileJava
warning: [options] bootstrap class path not set in conjunction with -source 1.7
1 warning
:processResources UP-TO-DATE
:classes
:jar
:assemble
:compileTestJava UP-TO-DATE
:processTestResources UP-TO-DATE
:testClasses UP-TO-DATE
:test UP-TO-DATE
:check UP-TO-DATE
:build
:generatePomFileForMavenJavaPublication
:artifactoryPublish
Deploying artifact: http://localhost:8081/artifactory/libs-snapshot-local/com/yqu/HelloArtifactory/0.1.0-SNAPSHOT/HelloArtifactory-0.1.0-SNAPSHOT.jar
Deploying artifact: http://localhost:8081/artifactory/libs-snapshot-local/com/yqu/HelloArtifactory/0.1.0-SNAPSHOT/HelloArtifactory-0.1.0-SNAPSHOT.pom
Deploying build descriptor to: http://localhost:8081/artifactory/api/build
Build successfully deployed. Browse it in Artifactory under http://localhost:8081/artifactory/webapp/builds/HelloArtifactory/XXXXXXXX
```
![尝试Artifactory](/images/2015/6/0026uWfMzy74j77Wxf1a7.jpg)

### 参考

[Artifactory: Working with Gradle](https://www.jfrog.com/confluence/display/RTF/Working+with+Gradle)  
[Gradle: Publishing artifacts](https://docs.gradle.org/current/userguide/artifact_management.html)  
[Publish JAR artifact using Gradle to Artifactory](http://buransky.com/scala/publish-jar-artifact-using-gradle-to-artifactory/)  