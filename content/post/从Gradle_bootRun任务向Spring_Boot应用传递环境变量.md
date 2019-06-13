---
title: '从Gradle bootRun任务向Spring Boot应用传递环境变量'
date: 2015-09-08 06:32:44
categories: 
- Service+JavaEE
- Spring
tags: 
- gradle
- bootrun
- spring
- boot
- system_property
---
尝试了从Gradle bootRun任务中传递环境变量给Spring Boot应用，下面是示例代码和演示。

### 示例代码

#### Application.java
```
package com.yqu.gradlesysprop;
  
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class Application {
  private static final Logger log =
      LoggerFactory.getLogger(Application.class);

  public static void main(String[] args) {
    SpringApplication app = new SpringApplication(Application.class);
    app.setWebEnvironment(false);
    app.setShowBanner(false);
    app.run(args);
  }

  @Bean
  public CommandLineRunner demo1() {
    return (args) -> {
      log.info("mryqu.prop.test="+
          System.getProperty("mryqu.prop.test"));      
    };
  }
}
```

#### build.gradle
```
buildscript {
  repositories {
    mavenCentral()
  }
  dependencies {
    classpath("org.springframework.boot:spring-boot-gradle-plugin:1.2.6.RELEASE")
  }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'
apply plugin: 'spring-boot'

jar {
  baseName = 'hello-gradlesysprop'
  version =  '0.1.0'
}

repositories {
  mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
  compile("org.springframework.boot:spring-boot-starter-actuator")    
}
```

### 演示

![从Gradle bootRun任务向Spring Boot应用传递环境变量](/images/2015/9/0026uWfMgy6XbsnXA8sf4.jpg)

### 参考

[How to pass system property to gradle task](http://stackoverflow.com/questions/23367507/how-to-pass-system-property-to-gradle-task)  