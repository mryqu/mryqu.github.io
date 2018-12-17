---
title: '[Gradle] 输出依赖包'
date: 2015-04-16 06:13:52
categories: 
- Tool
- Gradle
tags: 
- gradle
- dependencies
- jar
- output
---
下面我以[https://spring.io/guides/gs/spring-boot/](https://spring.io/guides/gs/spring-boot/)中的gs-spring-boot项目为例，使用Gradle输出依赖包。

首先对build.gradle做如下修改：
```
buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:1.2.2.RELEASE")
    }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'
apply plugin: 'spring-boot'

jar {
    baseName = 'gs-spring-boot'
    version =  '0.1.0'
}

repositories {
    mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

task copyToLib(type: Copy) {
    print configurations
    into "$buildDir/dep-libs"
    from configurations.runtime
}

build.dependsOn(copyToLib)

dependencies {
    compile("org.springframework.boot:spring-boot-starter-web")
    // tag::actuator[]
    compile("org.springframework.boot:spring-boot-starter-actuator")
    // end::actuator[]
    // tag::tests[]
    testCompile("org.springframework.boot:spring-boot-starter-test")
    // end::tests[]
}
```

首先可以在命令行中看到：
<pre>
[configuration ':archives', configuration ':compile', configuration ':default', configuration ':runtime', configuration ':testCompile', configur:clean':testRuntime', configuration ':versionManagement']
</pre>

跟下面[Java插件- 依赖配置](https://docs.gradle.org/current/userguide/java_plugin.html#sec:java_plugin_and_dependency_management)相比，少了一些，可能是根据build.gradle生成的configurations。
![[Gradle] 输出依赖包](/images/2015/4/0026uWfMzy74OGJdVGcc4.jpg)
此时在gs-spring-boot\complete\build\dep-libs目录下有32个jar文件；如果改成from configurations.testCompile，则该目录下会有48个jar文件。

最后要说的的是，我输出这些依赖包的目的是为了可以摆脱Gradle，通过java命令执行程序或进行测试。