---
title: '[Spring Boot] 访问JSP'
date: 2015-05-08 05:53:04
categories: 
- Service+JavaEE
- Spring
tags: 
- spring
- boot
- jsp
- tomcat-embed-jasper
- jstl
---
### 需求

我的Spring Boot web应用中用到了JSP，可是访问始终404。
```
@Controller
public class TestController {
    @RequestMapping("/test")
    public String webapp(Map model) {
        return "WEB-INF/index.jsp";
    }
}
```
解决方案是增加tomcat-embed-jasper依赖，此外可选性地增加了jstl依赖。

### Gradle

```
dependencies {
  ......
     
  // jsps
  providedRuntime ('org.apache.tomcat.embed:tomcat-embed-jasper')
}
```

### Maven

![[Spring Boot] 访问JSP](/images/2015/5/0026uWfMzy761wmNF8mc2.png)