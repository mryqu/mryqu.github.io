---
title: 'Spring Boot Example：Rest Exception Handling'
date: 2015-06-02 00:14:40
categories: 
- Service及JavaEE
- Spring
tags: 
- spring
- boot
- rest
- exceptionhandler
- gradle
---
要给同事做个Rest异常处理的演示，顺便用用Spring Boot和Gradle构建。
![Spring Boot Example：Rest Exception Handling](/images/2015/6/0026uWfMgy6SNEKCMP40e.jpg)![Spring Boot Example：Rest Exception Handling](/images/2015/6/0026uWfMgy6SNEKFSTd0f.jpg)![Spring Boot Example：Rest Exception Handling](/images/2015/6/0026uWfMgy6SNEKIUf749.jpg)首先新建一个项目：rest-exception-handling。

### rest-exception-handling/src/main/java/com/yqu/rest目录

#### Application.java

```
package com.yqu.rest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {

  public static void main(String[] args) {
    SpringApplication.run(Application.class, args);
  }
}
```

#### GreetingController.java

```
package com.yqu.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class GreetingController {
  @Autowired
  private GreetingService service;

  @RequestMapping(value = "/", method = RequestMethod.GET)
  public ModelAndView home(Model m){
    System.out.println("home");
    return new ModelAndView("index");
  }

  @RequestMapping(value = "/greeting", method = RequestMethod.GET)
  public @ResponseBody
  GreetingVO greeting(@RequestParam(value="name") String name)
  throws GreetingException {
    System.out.println("greeting " + name);
    return service.getGreeing(name);
  }

  @ExceptionHandler(GreetingException.class)
  @ResponseStatus(HttpStatus.BAD_REQUEST)
  public @ResponseBody
  GreetingErrorMessage greetingExceptionHandler(GreetingException ex) {
    System.out.println("greetingExceptionHandler");
    return new GreetingErrorMessage(0,ex.getMessage());
  }
}
```

#### GreetingErrorMessage.java

```
package com.yqu.rest;

public class GreetingErrorMessage {
  private int errCode;
  private String errMsg;

  public GreetingErrorMessage(int errCode, String errMsg) {
    this.errCode = errCode;
    this.errMsg = errMsg;
  }

  public int getErrCode() {
    return errCode;
  }

  public void setErrCode(int errCode) {
    this.errCode = errCode;
  }

  public String getErrMsg() {
    return errMsg;
  }

  public void setErrMsg(String errMsg) {
    this.errMsg = errMsg;
  }
}
```

#### GreetingException.java

```
package com.yqu.rest;

public class GreetingException extends Exception {
  public GreetingException() {

  }

  public GreetingException(String msg) {
    super(msg);
  }
}
```

#### GreetingService.java

```
package com.yqu.rest;

public interface GreetingService {
  public GreetingVO getGreeing(String name) throws GreetingException;
}
```

#### GreetingServiceImpl.java

```
package com.yqu.rest;

import org.springframework.stereotype.Service;

import java.util.concurrent.atomic.AtomicLong;

@Service
public class GreetingServiceImpl implements GreetingService {
  private static final String template = "Hello, %s!";
  private final AtomicLong counter = new AtomicLong();

  @Override
  public GreetingVO getGreeing(String name) 
  throws GreetingException {
    if(name.equalsIgnoreCase("war"))
      throw new GreetingException("no greeting for "+name);
    else if(name.equalsIgnoreCase("hell"))
      throw new RuntimeException("no idea about "+name);
    return new GreetingVO(counter.incrementAndGet(),
        String.format(template, name));
  }
}
```

#### GreetingVO.java

```
package com.yqu.rest;

public class GreetingVO {

  private final long id;
  private final String content;

  public GreetingVO(long id, String content) {
    this.id = id;
    this.content = content;
  }

  public long getId() {
    return id;
  }

  public String getContent() {
    return content;
  }
}
```

### rest-exception-handling/src/main/resources目录

#### application.properties

```
spring.view.prefix: /WEB-INF/jsp/
spring.view.suffix: .jsp
```

### rest-exception-handling/src/main/webapp/WEB-INF/jsp目录

#### index.jsp
```
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Hello Rest Exception Handling</title> 
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <script src="webjars/jquery/2.1.4/jquery.min.js"></script>
  <script type="text/javascript">
    getGreeting = function() {
      $.ajax({
        url: "greeting?name="+$('#name').val(),
        type: "GET",
        success: function(res) {
          $('#greetingContent').text(JSON.stringify(res));
          $('#greetingError').text("");
        },
        error: function (res) {
          $('#greetingContent').text("");
          $('#greetingError').text(res.responseText);
        }
      });
    };
        
    $(document).ready(function() {
      getGreeting();
    });        
  </script>  
</head> 
<body>
  <div class="content">
    <input type="text" id="name" required onchange="getGreeting()" value="yqu"/>
    <div id="greetingContent"></div>
    <div id="greetingError" style="color: #D8000C;background-color: #FFBABA;"></div>
  </div>
</body>
</html>  
```

### rest-exception-handling目录

#### build.gradle

```
buildscript {
  repositories {
    mavenCentral()
    maven { url "http://repo.spring.io/libs-milestone" }
  }
  dependencies {
    classpath("org.springframework.boot:spring-boot-gradle-plugin:1.2.3.RELEASE")
  }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'
apply plugin: 'spring-boot'

jar {
  baseName = 'rest-exception-handling'
  version = '0.1.0'
}

repositories {
  mavenCentral()
  maven { url "http://repo.spring.io/libs-milestone" }
}

sourceCompatibility = 1.7
targetCompatibility = 1.7

dependencies {

 
  compile("org.springframework.boot:spring-boot-starter-actuator")
  compile("org.springframework.boot:spring-boot-starter-web")
  compile("org.webjars:jquery:2.1.4")  
  compile("org.apache.tomcat.embed:tomcat-embed-jasper")
  compile("javax.servlet:jstl")
  
  testCompile("junit:junit")
}

task wrapper(type: Wrapper) {
  gradleVersion = '2.3'
}
```

### 参考

[Spring Guide：Rest Service](https://spring.io/guides/gs/rest-service/)  
[Spring Boot Reference Guide](http://docs.spring.io/spring-boot/docs/current/reference/html/)  
[Utilizing WebJars in Spring Boot](https://spring.io/blog/2014/01/03/utilizing-webjars-in-spring-boot)  
[Exception Handling in Spring MVC](https://spring.io/blog/2013/11/01/exception-handling-in-spring-mvc)  
[Spring MVC @ExceptionHandler Example](http://www.mkyong.com/spring-mvc/spring-mvc-exceptionhandler-example/)  