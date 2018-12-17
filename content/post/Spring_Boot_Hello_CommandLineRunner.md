---
title: '[Spring Boot] Hello CommandLineRunner'
date: 2015-07-08 06:02:53
categories: 
- Service及JavaEE
- Spring
tags: 
- spring
- boot
- commandlinerunner
- order
- dependson
---
通过CommandLineRunner，可在所有Spring Bean和`ApplicationContext`被创建后执行一些可以访问命令行参数的任务。如想指定多个`CommandLineRunner`Bean的执行顺序，可以实现`org.springframework.core.Ordered`接口或添加`org.springframework.core.annotation.Order`注解。

### 示例代码

#### Application.java
```
package com.yqu.cmdlinerunner;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.Banner;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.DependsOn;
import org.springframework.core.annotation.Order;
import org.springframework.core.annotation.OrderUtils;

import java.util.Arrays;

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

    @Bean(name="demo1")
    @DependsOn("demo2")
    @Order(8)
    public CommandLineRunner demo1() {
        return (args) -> {
            log.info("demo1:order="+
                    OrderUtils.getOrder(this.getClass())+
                    ":args="+Arrays.toString(args));
            //log.info(getStacks());
        };
    }

    @Bean(name="demo2")
    @Order(1)
    public CommandLineRunner demo2() {
        return (args) -> {
            log.info("demo2:order="+
                    OrderUtils.getOrder(this.getClass())+
                    ":args="+ Arrays.toString(args));
        };
    }

    private String getStacks() {
        StringBuilder sb = new StringBuilder();
        StackTraceElement[] elements = Thread.currentThread().getStackTrace();
        sb.append("========================\n");

        for (int i = 0; i < elements.length; i++) {
            sb.append(elements[i]).append("\n");
        }
        return sb.toString();
    }
}
```

#### MyCmdLineRunner1.java
```
package com.yqu.cmdlinerunner;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.core.annotation.OrderUtils;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Component
@Order(6)
public class MyCmdLineRunner1 implements CommandLineRunner {
    private static final Logger log =
            LoggerFactory.getLogger(MyCmdLineRunner1.class);

    private String getStacks() {
        StringBuilder sb = new StringBuilder();
        StackTraceElement[] elements = Thread.currentThread().getStackTrace();
        sb.append("========================\n");

        for (int i = 0; i < elements.length; i++) {
            sb.append(elements[i]).append("\n");
        }
        return sb.toString();
    }

    public void run(String... args) {
        log.info("MyCmdLineRunner1:order="+
                OrderUtils.getOrder(this.getClass())+
                ":args="+ Arrays.toString(args));
        //log.info(getStacks());
    }
}
```

#### MyCmdLineRunner2.java
```
package com.yqu.cmdlinerunner;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.core.annotation.OrderUtils;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Component
@Order(5)
public class MyCmdLineRunner2 implements CommandLineRunner {
    private static final Logger log =
            LoggerFactory.getLogger(MyCmdLineRunner2.class);

    public void run(String... args) {
        log.info("MyCmdLineRunner2::order="+
                OrderUtils.getOrder(this.getClass())+
                ":args="+ Arrays.toString(args));
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
    baseName = 'hello-springboot-commandlinerunner'
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

task wrapper(type: Wrapper) {
    gradleVersion = '2.3'
}
```

### 测试

```
java -jar build/libs/hello-commandlinerunner-0.1.0.jar.jar --spring.yquopt1=k --spring.yquopt2=x
```

结果如下：
![[Spring Boot] Hello CommandLineRunner](/images/2015/7/0026uWfMgy6WLrPcQITdf.jpg)

### CommandLineRunner分析
通过如下调用堆栈可知，`CommandLineRunner`Bean都是由org.springframework.boot.SpringApplication.runCommandLineRunners调用执行的。
```
org.springframework.boot.SpringApplication.runCommandLineRunners(SpringApplication.java:673)
org.springframework.boot.SpringApplication.afterRefresh(SpringApplication.java:691)
org.springframework.boot.SpringApplication.run(SpringApplication.java:322)
com.yqu.cmdlinerunner.Application.main(Application.java:25)
```

org.springframework.core.annotation.AnnotationAwareOrderComparator负责对`CommandLineRunner`Bean进行排序。排序规则为：

- 如果有一方是`org.springframework.core.PriorityOrdered`接口实现，而另一方不是，则PriorityOrdered接口实现一方获胜；
- 检查`org.springframework.core.Ordered`接口或`org.springframework.core.annotation.Order`注解获得order，值小者胜；
- 其他没有order的则置为Ordered.LOWEST_PRECEDENCE，顺序不定。

在上述测试中，MyCmdLineRunner2的order为5，MyCmdLineRunner1的order为6，因此MyCmdLineRunner2在MyCmdLineRunner1之前执行。
Application的demo1和demo2方法设置了@order注解，但是调试可知lamda表达式生成类并没有@order注解信息，因此执行顺序排在后面。**这是需要注意的地方。**
此外，Bean初始化顺序跟`CommandLineRunner`执行顺序也没有关系。

### 参考

[Spring Boot Reference Guide](http://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#boot-features-command-line-runner)  