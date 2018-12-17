---
title: '[Spring Data] 调试H2数据库'
date: 2015-06-28 01:00:55
categories: 
- Service及JavaEE
- Spring
tags: 
- spring
- boot
- h2
- database
- console
---
我将Spring的两个入门指南[Building a RESTful Web Service](https://spring.io/guides/gs/rest-service/)和[Accessing Data with JPA](https://spring.io/guides/gs/accessing-data-jpa/)融到一起，测试成功。那接下来的一个问题就是怎么查看H2数据库内容并进行调试？

### 配置H2 Web控制台

为了解决这个问题，我首先增加了src/resources/application.properties配置文件，内容如下：
```
spring.profiles.active=dev
spring.h2.console.enabled=true
```

### 在H2 Web控制台上操作

启动Spring Boot应用，在浏览器中进入[http://localhost:8080/h2_console/](http://localhost:8080/h2_console/)即可进入H2数据库的Web控制台了。
![[Spring Data] 调试H2数据库](/images/2015/6/0026uWfMzy769goUOCC22.jpg)
![[Spring Data] 调试H2数据库](/images/2015/6/0026uWfMzy769gpdKYmbe.jpg)
![[Spring Data] 调试H2数据库](/images/2015/6/0026uWfMzy769gpWTbUbe.jpg)

### 配置IDEA IntelliJ数据源

如果不使用H2 Web控制台的话，在IDEA IntelliJ集成开发环境中也可以通过配置H2数据源进行数据库操作。
![[Spring Data] 调试H2数据库](/images/2015/6/0026uWfMzy769gGJCWg2c.png)
![[Spring Data] 调试H2数据库](/images/2015/6/0026uWfMzy769hRntus8c.jpg)
![[Spring Data] 调试H2数据库](/images/2015/6/0026uWfMzy769hRANbDe5.jpg)

### 解决数据库表不存在问题

上面的玩法有个问题，那就是没看到[Accessing Data with JPA](https://spring.io/guides/gs/accessing-data-jpa/)里面创建的CUSTOMER表，对不对？为了解决这个问题，在src/resources/application.properties配置文件增加如下内容：
```
spring.profiles.active=dev
spring.h2.console.enabled=true

spring.datasource.url=jdbc:h2:~/test;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=
```
![[Spring Data] 调试H2数据库](/images/2015/6/0026uWfMzy769mHXIyV7d.jpg)
搞定，收工！

### 参考

[Using H2’s web console in Spring Boot](http://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-sql.html#boot-features-sql-h2-console)  
[Common application properties for Spring Boot](http://docs.spring.io/spring-boot/docs/current/reference/html/common-application-properties.html)  
[H2 Console](http://www.h2database.com/html/quickstart.html#h2_console)  