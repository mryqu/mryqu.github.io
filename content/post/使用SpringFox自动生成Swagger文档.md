---
title: '使用SpringFox自动生成Swagger文档'
date: 2016-04-28 06:03:36
categories: 
- Service及JavaEE
- Swagger
tags: 
- springfox
- swagger
- rest
- api
- document
---
前面的博文[Swagger实践和总结](/post/swagger实践和总结)总体上探索了一下Swagger，这里着重研究Springfox。
Springfox Java库源自MartyPitt创建的swagger-springmvc项目。Swagger是一系列对RESTful接口进行规范描述和页面展示的工具，而通过Springfox将Swagger与Spring-MVC整合,可以将代码中的注解转换为符合Swagger开放API声明(OpenAPI Specification，OAS)的swagger.json文件,springfox-swagger-ui提供了将swagger.json转换为html页面的服务。

### HelloSpringfox示例

尽管[springfox-demos](https://github.com/springfox/springfox-demos)中的[boot-swagger](https://github.com/springfox/springfox-demos/tree/master/boot-swagger)很全面了。但是对于一个写程序的人来说，不亲自写一遍，总觉得可能会有陷阱和漏洞，缺乏那么一点点自信。
我的示例是以[Building a Hypermedia-Driven RESTful Web Service](http://spring.io/guides/gs/rest-hateoas/)为基础修改的，懒人总是要找个肩膀。![使用SpringFox自动生成Swagger文档](/images/2016/4/0026uWfMzy7f3qIQ5oj17.png)
#### build.gradle
```
jar {
    baseName = 'hello-springfox'
    version =  '0.1.0'
}

dependencies {
    compile("org.springframework.boot:spring-boot-starter-actuator")
    compile("org.springframework.boot:spring-boot-starter-web")
    compile("org.springframework.boot:spring-boot-starter-hateoas")
    compile("io.springfox:springfox-swagger2:${springfoxVersion}")
    compile("io.springfox:springfox-swagger1:${springfoxVersion}")
    compile("io.springfox:springfox-swagger-ui:${springfoxVersion}")
    testCompile("com.jayway.jsonpath:json-path")
    testCompile("org.springframework.boot:spring-boot-starter-test")
}
```
#### Application.java
```
package com.yqu.hellospringfox;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {
  public static void main(String[] args) {
    SpringApplication.run(Application.class, args);
  }
}
```
#### Greeting.java
```
package com.yqu.hellospringfox;

import org.springframework.hateoas.ResourceSupport;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class Greeting extends ResourceSupport {

  private final String content;

  @JsonCreator
  public Greeting(@JsonProperty("content") String content) {
    this.content = content;
  }

  public String getContent() {
    return content;
  }
}
```

#### GreetingController.java
```
package com.yqu.hellospringfox;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.*;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Api(value="Greeting Controller")
@RestController
public class GreetingController {

  private static final String TEMPLATE = "Hello, %s!";

  @ApiOperation(value = "Get greeting information", 
                httpMethod = "GET", 
                produces = "application/json")
  @ApiResponse(code = 200, message = "OK", response = Greeting.class)
  @RequestMapping("/greeting")
  public HttpEntity<Greeting> greeting(
          @ApiParam(name = "name", required = true, value = "User Name")
          @RequestParam(value = "name", 
                        required = false, 
                        defaultValue = "World")
          String name) {
    Greeting greeting = new Greeting(String.format(TEMPLATE, name));
    greeting.add(linkTo(methodOn(GreetingController.class).
                  greeting(name)).withSelfRel());
    return new ResponseEntity(greeting, HttpStatus.OK);
  }
}
```

#### MySwaggerConfig.java
```
package com.yqu.hellospringfox;

import com.google.common.base.Predicate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.annotations.ApiIgnore;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger1.annotations.EnableSwagger;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import static springfox.documentation.builders.PathSelectors.regex;

@Configuration
@EnableSwagger //Enable swagger 1.2 spec
@EnableSwagger2 //Enable swagger 2.0 spec
@ComponentScan("hello.GreetingController")
public class MySwaggerConfig {
  @Bean
  public Docket greetingApi() {
    return new Docket(DocumentationType.SWAGGER_2)
            .groupName("greeting-api")
            .apiInfo(apiInfo())
            .select()
            .paths(greetingPaths())
            .build()
            .ignoredParameterTypes(ApiIgnore.class)
            .enableUrlTemplating(true);
  }

  private ApiInfo apiInfo() {
    return new ApiInfoBuilder()
            .title("mryqu's REST API Demo")
            .description("Just a SpringFox demo")
            .contact("mryqu")
            .license("Apache License Version 2.0")
            .licenseUrl("https://github.com/mryqu/")
            .version("2.0")
            .build();
  }

  private Predicate<String> greetingPaths() {
    return regex("/greeting");
  }
}
```
#### application.properties
```
server.contextPath=/hellospringfox
management.security.enabled=false
```
#### 测试
首先测试gretting API功能：![使用SpringFox自动生成Swagger文档](/images/2016/4/0026uWfMzy7f3qKhjO6c6.jpg)
/swagger-ui.html界面：![使用SpringFox自动生成Swagger文档](/images/2016/4/0026uWfMzy7f3qKW7Eae6.jpg)
/v2/api-docs?group=greeting-api：![使用SpringFox自动生成Swagger文档](/images/2016/4/0026uWfMzy7f3qLIE3D11.jpg)

### Springfox用法

Docket对象为Springfox提供配置信息，ApiInfo为生成的文档提供了元数据信息。
常用的几个用于生成文档的注解如下:
- @Api 表示该类是一个Swagger的Resource, 是对Controller进行注解的
- @ApiOperation 表示对应一个RESTful接口, 对方法进行注解
- @ApiResponse 表示对不同 HTTP 状态码的意义进行描述
- @ApiParam 表示对传入参数进行注解

### 参考

[SpringFox](http://springfox.github.io/springfox/)    
[GitHub: springfox/springfox](https://github.com/springfox/springfox)    