---
title: 'Spring Cloud Consul Config'
date: 2017-06-23 05:40:36
categories:
- Service及JavaEE 
- Spring
tags: 
- spring
- cloud
- consul
- config
- distrituted
---
[Spring Cloud](http://projects.spring.io/spring-cloud/)是在Spring Boot的基础上构建的，用于简化分布式系统构建的工具集，为开发人员提供快速建立分布式系统中的一些常见的模式。例如：分布式版本可控配置(Distributed/versioned configuration)，服务注册与发现(Service registration and discovery)、智能路由(intelligent routing)、服务间调用、负载均衡、断路器(circuit breakers)、微代理(micro-proxy)、控制总线(control bus)、一次性令牌(one-time tokens)、全局锁(global locks)、领导选举和集群状态(leadership election and cluster state)、分布式消息、分布式会话等。
[Spring Cloud Config项目](http://cloud.spring.io/spring-cloud-config/)快速入门示例展示了用于分布式系统中由Git仓库支持的中央外部配置。但是偶在项目中是用Consul的，而[Spring Cloud Consul项目](http://cloud.spring.io/spring-cloud-consul/)的快速入门示例并没有展示如何使用Consul进行配置管理，所以还是自己攒一下吧。

### Spring Cloud Consul简介

HashiCorp公司的Consul是用于基础架构中服务发现和配置的工具，支持服务发现、健康检查、用于不同用途的键值对存储、多数据中心支持。
Spring Cloud Consul通过自动配置及Spring环境和其他Spring编程模型进行绑定实现Cosul与Spring Boot应用的集成。通过一些简单的注释，即可激活应用内的通用模式，使用Hashicorp的Consul构建大型分布式系统。其功能如下：
*   **服务发现**: 实例可以向Consul agent注册，客户端可以使用Spring管理的bean发现这些实例
*   **支持Ribbon**: 通过Spring Cloud Netflix提供的客户端负载均衡
*   **支持Zuul**: 通过Spring Cloud Netflix提供的动态路由和过滤
*   **分布式配置**: 使用Consul键值对存储
*   **控制总线**: 使用Consul事件的分布式控制事件

![Spring Cloud Consul](/images/2017/06/SpringCloudConsul.png)

### 安装并启动Consul

每个集群需要最少三台Consul server，以建立仲裁(quorum)，每个机器上必须运行一个consul agent。
![Consul Environment](/images/2017/06/ConsulEnv.png)

Consul Agent:
- 健康检查  
- 转发查询

Consul Server:
- 存储数据  
- 响应查询  
- 领导选举

根据参考二[Consul安装指南](https://www.consul.io/intro/getting-started/install.html)，可以很轻松地在本机安装Consul。用于开发环境启动本地单Consul实例的脚本可以使用参考一[Spring Cloud Consul指南](http://cloud.spring.io/spring-cloud-consul/multi/multi_spring-cloud-consul.html)中所提到的[src/main/bash/local_run_consul.sh](https://github.com/spring-cloud/spring-cloud-consul/blob/master/src/main/bash/local_run_consul.sh)。本文中采用如下命令：
```
consul agent -dev -ui
```

### consul-config-demo

#### build.gradle
```
buildscript {
  repositories {
    mavenCentral()
    maven { url "http://repo.spring.io/libs-milestone" }
  }
  dependencies {
    classpath("org.springframework.boot:spring-boot-gradle-plugin:1.5.7.RELEASE")
    classpath "io.spring.gradle:dependency-management-plugin:0.5.6.RELEASE"
  }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'
apply plugin: 'org.springframework.boot'
apply plugin: "io.spring.dependency-management"

dependencyManagement {
  imports { 
    mavenBom "org.springframework.cloud:spring-cloud-consul-dependencies:1.2.1.RELEASE" 
  }
}

jar {
  baseName = 'hello-spring-consul-configdemo'
  version =  '0.1.0'
}

repositories {
  mavenCentral()
  maven { url "http://repo.spring.io/libs-milestone" }
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
  compile("org.springframework.boot:spring-boot-starter-actuator")
  compile("org.springframework.boot:spring-boot-starter-web")
  //compile("org.springframework.cloud:spring-cloud-consul-config")
  //compile("org.springframework.cloud:spring-cloud-starter-consul-discovery")
  compile('org.springframework.cloud:spring-cloud-starter-consul-all')
}
```
Maven依赖管理包含"物料清单式"（BOM）概念。BOM可以控制项目依赖的版本，并可以集中定义和更新。由[Better dependency management for Gradle](https://spring.io/blog/2015/02/23/better-dependency-management-for-gradle)可知，Gradle依赖管理插件可以使用Maven的BOM管理项目依赖。build.gradle中指定了spring-cloud-consul-dependencies版本，实质上是指定了下列Spring cloud consul依赖(不管直接还是传递依赖)的版本，并且在dependencies中无需指定这些依赖的version属性：
![Dependencies Specified By BOM](/images/2017/06/DependenciesSpecifiedByBOM.png)

#### src/main/java/com/yqu/consul/Application.java
```
package com.yqu.consul;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@EnableDiscoveryClient
@SpringBootApplication
@RestController
@RefreshScope
public class Application {
  @Value("${greets}")
  String name = "World";

  @RequestMapping("/")
  public String home() {
    return "Hello " + name;
  }

  public static void main(String[] args) {
    SpringApplication.run(Application.class, args);
  }
}
```
@EnableDiscoveryClient注释用于服务自动注、客户端发现服务。具体实现可详见[EnableDiscoveryClient.java](https://github.com/spring-cloud/spring-cloud-commons/blob/master/spring-cloud-commons/src/main/java/org/springframework/cloud/client/discovery/EnableDiscoveryClient.java)、[EnableDiscoveryClientImportSelector.java](https://github.com/spring-cloud/spring-cloud-commons/blob/master/spring-cloud-commons/src/main/java/org/springframework/cloud/client/discovery/EnableDiscoveryClientImportSelector.java)、[AutoServiceRegistrationConfiguration.java](https://github.com/spring-cloud/spring-cloud-commons/blob/master/spring-cloud-commons/src/main/java/org/springframework/cloud/client/serviceregistry/AutoServiceRegistrationConfiguration.java)、[AutoServiceRegistrationProperties.java](https://github.com/spring-cloud/spring-cloud-commons/blob/master/spring-cloud-commons/src/main/java/org/springframework/cloud/client/serviceregistry/AutoServiceRegistrationProperties.java)和[spring-cloud-consul-discovery的/META-INF/spring.factories](https://github.com/spring-cloud/spring-cloud-consul/blob/master/spring-cloud-consul-discovery/src/main/resources/META-INF/spring.factories)及其中所指定的RibbonConsulAutoConfiguration、ConsulConfigServerAutoConfiguration、ConsulAutoServiceRegistrationAutoConfiguration、ConsulServiceRegistryAutoConfiguration、ConsulDiscoveryClientConfigServiceBootstrapConfiguration类实现。
@Value注释用于获取配置。更多内容详见[Spring Boot - Externalized Configuration](https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html)和[A Quick Guide to Spring @Value](http://www.baeldung.com/spring-value-annotation)。
@RefreshScope注释使Spring Bean在配置变化后动态刷新。没有该注释的Bean仅在初始化时获取配置。具体实现可详见[org.springframework.cloud.context.config.annotation.RefreshScope.java](https://github.com/spring-cloud/spring-cloud-commons/blob/master/spring-cloud-context/src/main/java/org/springframework/cloud/context/config/annotation/RefreshScope.java)和[org.springframework.cloud.context.scope.refresh.RefreshScope.java](https://github.com/spring-cloud/spring-cloud-commons/blob/master/spring-cloud-context/src/main/java/org/springframework/cloud/context/scope/refresh/RefreshScope.java)。

#### src/main/resources/bootstrap.yml
```
spring:
  cloud:
    consul:
      config:
        watch:
          enabled: true
      port: 8500
      discovery:
        register-health-check: true
        instanceId: ${spring.application.name}:${vcap.application.instance_id:${spring.application.instance_id:${random.value}}}
  application:
    name: consul-config-demo
server:
  port: 0
```
spring.cloud.consul.config.watch.enabled用于激活对Consul配置变更的检查。具体实现可详见[ConsulConfigAutoConfiguration.java](https://github.com/spring-cloud/spring-cloud-consul/blob/master/spring-cloud-consul-config/src/main/java/org/springframework/cloud/consul/config/ConsulConfigAutoConfiguration.java)和[ConfigWatch.java](https://github.com/spring-cloud/spring-cloud-consul/blob/master/spring-cloud-consul-config/src/main/java/org/springframework/cloud/consul/config/ConfigWatch.java)。

### 配置Consul存储

在Consul上添加Application.java所需的配置greets：
![Consul KV Store](/images/2017/06/ConsulKVStore.png)

### 测试

#### 服务注册
当对consul-config-demo执行完gradle bootrun命令后，即可在Consul UI上看到注册的consul-config-demo服务了。
![Consul Services](/images/2017/06/ConsulServices.png)
#### 健康检查
Spring Cloud Consul对Spring Boot应用的健康检查是借助Spring Boot Actuator完成的。
![Consul Health Check](/images/2017/06/ConsulHealthCheck.png)
#### 服务测试
![Spring Cloud Consul Test](/images/2017/06/SpringCloudConsulTest.png)
服务返回结果为Hello mryqu，即greets配置从Consul获取成功。当在Consul上更新greets配置，再次调用服务，会发现服务返回结果也会随greets配置而变更，这说明cloud.consul.config.watch配置和@RefreshScope注释生效。
注：Consul中的server.port配置可以覆盖掉bootstrap.yml，但是初始化后并不能更新（有次莫名其妙地可以更新，但不可重现）。

### Spring Cloud Consul 优点

<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr style="text-align:center;color:white;background-color:black"><th>监控</th><th>部署</th><th>配置</th></tr><tr><td><ul><li>发现待监控的服务</li><li>服务监控状态比单个实例健康状态更重要</li></ul></td><td><ul><li>启动次序无关紧要</li><li>部署简单</li><li>环境隔离</li></ul></td><td><ul><li>运行时更新</li><li>无本地配置</li><li>端点动态发现</li></ul></td></tr></tbody></table>

### 参考
* * *
[Spring Cloud Consul指南](http://cloud.spring.io/spring-cloud-consul/multi/multi_spring-cloud-consul.html)  
[Consul安装指南](https://www.consul.io/intro/getting-started/install.html)  
[Advanced Spring Boot with Consul](https://content.pivotal.io/slides/advanced-spring-boot-consul)  
[spring cloud集成 consul源码分析](http://www.cnblogs.com/davidwang456/p/6734995.html)  