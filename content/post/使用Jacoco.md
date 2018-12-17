---
title: '使用Jacoco'
date: 2016-06-16 05:41:19
categories: 
- Java
tags: 
- jacoco
- code coverage
- gradle
- 代码覆盖率
---
在以前的项目都是用Cobertura做代码覆盖率测试的，这次有机会接触了一下另一个代码覆盖率Java库[JaCoco](http://www.eclemma.org/jacoco/)。
JaCoCo拥有友好的授权形式。JaCoCo使用了Eclipse PublicLicense，方便个人用户和商业用户使用。JaCoCo/EclEmma项目除了提供JaCoCo库之外，还提供了Ant任务、Maven插件及EclEmmaEclipse插件，也可以使用JavaAgent技术监控Java程序。很多第三方的工具提供了对Jacoco的集成，如SonarQube、Jenkins、Netbeans、IntelliJIDEA、Gradle等。
JaCoCo包含多种级别的覆盖率计数器，包含指令级覆盖(Instructions，C0coverage)，分支（Branches，C1coverage）、圈复杂度(CyclomaticComplexity)、行覆盖(Lines)、方法覆盖(non-abstractmethods)、类覆盖(classes)。
- 指令覆盖：计数单元是单个java字节码指令，指令覆盖率提供了代码是否被执行的信息，该指标完全独立与源码格式。
- 分支覆盖率：度量if和switch语句的分支覆盖情况，计算一个方法里面的总分支数，确定执行和不执行的分支数量。
- 圈复杂度：在（线性）组合中，计算在一个方法里面所有可能路径的最小数目，缺失的复杂度同样表示测试案例没有完全覆盖到这个模块。
- 行覆盖率：度量被测程序的每行代码是否被执行，判断标准行中是否至少有一个指令被执行。
- 方法覆盖率：度量被测程序的方法执行情况，是否执行取决于方法中是否有至少一个指令被执行。
- 类覆盖率：度量计算class类文件是否被执行。

JaCoCo的一个主要优点是使用Java代理，可以动态（on-the-fly）对类进行插桩。这样代码覆盖率分析简化了预插桩过程，也无需考虑classpath的设置。但是还存在如下不适合动态插桩的情况，需要线下对字节码进行预插桩：
- 运行环境不支持java agent。
- 部署环境不允许设置JVM参数。
- 字节码需要被转换成其他的虚拟机如Android Dalvik VM。
- 动态修改字节码过程中和其他agent冲突。

### 示例

我这个懒人还是在[Building a Hypermedia-Driven RESTful Web Service](http://spring.io/guides/gs/rest-hateoas/)示例的基础上稍作修改，熟悉一下JaCoCo的使用。
#### build.gradle
```
buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:1.X.Y.RELEASE")
    }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'
apply plugin: 'spring-boot'
apply plugin: 'jacoco'

jar {
    baseName = 'hello-jacoco'
    version =  '0.1.0'
}

repositories {
    mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
    compile("org.springframework.boot:spring-boot-starter-hateoas")
    testCompile("com.jayway.jsonpath:json-path")
    testCompile("org.springframework.boot:spring-boot-starter-test")
}
```
#### 运行
```
gradle test jacocoTestReport
```
#### 测试结果
![使用Jacoco](/images/2016/6/0026uWfMzy7fezZK9431f.jpg)![使用Jacoco](/images/2016/6/0026uWfMzy7feA0RYrd5f.jpg)
投入少，产出多，这种工具我喜欢。

### 参考

[JaCoCo Java Code Coverage Library](http://www.eclemma.org/jacoco/)    
[JaCoCo Document](http://www.jacoco.org/jacoco/trunk/doc/)    
[Gradle JaCoCo Plugin](https://docs.gradle.org/current/userguide/jacoco_plugin.html)    
[GitHub: jacoco/jacoco](https://github.com/jacoco/jacoco)    