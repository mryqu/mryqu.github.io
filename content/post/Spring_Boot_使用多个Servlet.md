---
title: '[Spring Boot] 使用多个Servlet'
date: 2015-10-28 06:07:53
categories: 
- Service+JavaEE
- Spring
tags: 
- spring
- boot
- multiple
- servlet
---
当使用Spring boot的嵌入式servlet容器时，可以通过Springbean或扫描Servlet组件的方式注册Servlet、Filter和Servlet规范的所有监听器(例如`HttpSessionListener`)。
- 当urlMapping不是很复杂时，可以通过`ServletRegistrationBean`、`FilterRegistrationBean`和`ServletListenerRegistrationBean`获得完整控制。如果bean实现了`ServletContextInitializer`接口的话则可以直接注册。
- 当使用`@ServletComponentScan`扫描Servlet组件时，Servlet、过滤器和监听器可以是通过`@WebServlet`、`@WebFilter`和`@WebListener`自动注册

### 示例代码

#### Application.java
```
package com.yqu.multiservlet;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.embedded.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.DispatcherServlet;

@SpringBootApplication
public class Application {

  public static void main(String[] args) {
    SpringApplication.run(Application.class, args);
  }

  @Bean
  public ServletRegistrationBean dispatcherRegistration(
      DispatcherServlet dispatcherServlet) {
    ServletRegistrationBean registration =
        new ServletRegistrationBean(dispatcherServlet);
    registration.addUrlMappings("/hirest/*");
    printStacks();
    return registration;
  }

  @Bean
  public ServletRegistrationBean servletRegistrationBean() {
    printStacks();
    return new ServletRegistrationBean(
        new SigninServlet(), "/signin");
  }

  private void printStacks() {
    StackTraceElement[] elements = Thread.currentThread().getStackTrace();
    System.out.println("========================");

    for (int i = 0; i < elements.length; i++) {
      System.out.println(elements[i]);
    }
  }
}
```

#### SigninServlet.java
```
package com.yqu.multiservlet;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SigninServlet extends HttpServlet {
  public void init(ServletConfig config)
      throws ServletException {
    super.init(config);

  }

  protected void doGet(
      HttpServletRequest request,
      HttpServletResponse response)
      throws ServletException, IOException {
    response.sendRedirect("http://blog.sina.com.cn/yandongqu");
  }
}
```

#### HelloController.java
```
package com.yqu.multiservlet;

import org.springframework.hateoas.ResourceSupport;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;
import static org.springframework.hateoas.mvc.ControllerLinkBuilder.methodOn;

@RestController
public class HelloController {
  @RequestMapping(value = "/", method = RequestMethod.GET)
  @ResponseBody
  public HttpEntity  home() {
    ResourceSupport home = new ResourceSupport();
    home.add(linkTo(methodOn(HelloController.class).home()).withSelfRel());
    return new ResponseEntity(home, HttpStatus.OK);
  }
}
```

#### application.properties
```
server.context-path=/HelloMultiServlet
server.port=8080

applicationDefaultJvmArgs: [
    "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=55558"
]
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
    baseName = 'hello-multiservlet'
    version =  '0.1.0'
}

repositories {
    mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
    compile("org.springframework.boot:spring-boot-starter-actuator")
    compile("org.springframework.boot:spring-boot-starter-web")
    compile("com.fasterxml.jackson.core:jackson-databind")
    compile("org.springframework.hateoas:spring-hateoas")
    compile("org.springframework.plugin:spring-plugin-core:1.1.0.RELEASE")
    compile("com.jayway.jsonpath:json-path:0.9.1")
}

task wrapper(type: Wrapper) {
    gradleVersion = '2.3'
}
```

### 日志
![[Spring Boot] 使用多个Servlet](/images/2015/10/0026uWfMgy6WyqjAe1Z03.jpg)![[Spring Boot] 使用多个Servlet](/images/2015/10/0026uWfMgy6WyqjWqKG56.jpg)

### 测试

- 通过REST访问http://localhost:8080/HelloMultiServlet/hirest/
  ![[Spring Boot] 使用多个Servlet](/images/2015/10/0026uWfMgy6WyqxNe3Ke8.jpg)
- 浏览器访问http://localhost:8080/HelloMultiServlet/signin ，则会跳转到本博客。

### 参考

[Spring Boot Reference Guide](http://docs.spring.io/spring-boot/docs/current-SNAPSHOT/reference/htmlsingle/#boot-features-embedded-container)  
[Using multiple dispatcher servlets / web contexts with spring boot](http://stackoverflow.com/questions/29096511/using-multiple-dispatcher-servlets-web-contexts-with-spring-boot)  
[How to configure spring-boot servlet like in web.xml?](http://stackoverflow.com/questions/22389996/how-to-configure-spring-boot-servlet-like-in-web-xml)  
[GitHub：spring-boot/spring-boot-samples/spring-boot-sample-servlet](https://github.com/spring-projects/spring-boot/tree/master/spring-boot-samples/spring-boot-sample-servlet)  