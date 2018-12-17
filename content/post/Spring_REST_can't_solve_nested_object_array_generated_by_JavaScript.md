---
title: "Spring REST can't solve nested object array generated by JavaScript"
date: 2015-01-15 21:27:22
categories: 
- Service及JavaEE
- Spring
tags: 
- spring
- rest
- javascript
- json
- 解析
---
最近遭遇SpringREST无法解析嵌套对象数组这么一个问题。为了排除客户端Javascript代码嫌疑，我通过GET操作从Spring RestfulWeb服务获取一个复杂对象，然后通过POST操作将其原封不动返给Spring Restful Web服务，问题依旧重现。

### 所操作的复杂对象

![Spring REST can't solve nested object array generated by JavaScript](/images/2015/1/0026uWfMgy6SPjKDVO20a.jpg)

### 客户端POST响应

![Spring REST can't solve nested object array generated by JavaScript](/images/2015/1/0026uWfMgy6SPMJGnGxe9.jpg)![Spring REST can't solve nested object array generated by JavaScript](/images/2015/1/0026uWfMgy6SPMJJgbC38.jpg)

### 中间层代码

```
package com.yqu.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@RestController
public class ConfigurationController {
  @RequestMapping(value = "/", method = RequestMethod.GET)
  public ModelAndView home(Model m){
    System.out.println("home");
    return new ModelAndView("index");
  }

  @RequestMapping(value = "/configure", method = RequestMethod.GET)
  public @ResponseBody
  SheetVO getConfiguration() {
    List columns = new ArrayList();
    columns.add(new ColumnVO("id","The Id",1));
    columns.add(new ColumnVO("name","The Name",2));
    columns.add(new ColumnVO("age","The Age",3));

    SheetVO metadata = new SheetVO(SheetVO.TITLE_MATCHING, 1,0, columns);
    System.out.println("getConfiguration:"+metadata);
    return metadata;
  }

  @RequestMapping(value = "/configure", method = RequestMethod.POST)
  public @ResponseBody
  SheetVO setConfiguration(@ModelAttribute("metadata") SheetVO metadata) {
    System.out.println(metadata);
    return metadata;
  }
}
```

### 中间层异常

```
org.springframework.beans.InvalidPropertyException: Invalid property 'columns[0][varIndex]' of bean class [com.yqu.rest.SheetVO]: Property referenced in indexed property path 'columns[0][varIndex]' is neither an array nor a List nor a Map; returned value was [1]
  at org.springframework.beans.BeanWrapperImpl.setPropertyValue(BeanWrapperImpl.java:1058)
  at org.springframework.beans.BeanWrapperImpl.setPropertyValue(BeanWrapperImpl.java:927)
  at org.springframework.beans.AbstractPropertyAccessor.setPropertyValues(AbstractPropertyAccessor.java:95)
  at org.springframework.validation.DataBinder.applyPropertyValues(DataBinder.java:749)
  at org.springframework.validation.DataBinder.doBind(DataBinder.java:645)
  at org.springframework.web.bind.WebDataBinder.doBind(WebDataBinder.java:189)
  at org.springframework.web.bind.ServletRequestDataBinder.bind(ServletRequestDataBinder.java:106)
  at org.springframework.web.servlet.mvc.method.annotation.ServletModelAttributeMethodProcessor.bindRequestParameters(ServletModelAttributeMethodProcessor.java:150)
  at org.springframework.web.method.annotation.ModelAttributeMethodProcessor.resolveArgument(ModelAttributeMethodProcessor.java:110)
  at org.springframework.web.method.support.HandlerMethodArgumentResolverComposite.resolveArgument(HandlerMethodArgumentResolverComposite.java:77)
  at org.springframework.web.method.support.InvocableHandlerMethod.getMethodArgumentValues(InvocableHandlerMethod.java:162)
  at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:129)
  at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:110)
  at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandleMethod(RequestMappingHandlerAdapter.java:776)
  at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:705)
  at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)
  at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:959)
  at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:893)
  at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:966)
  at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:868)
  at javax.servlet.http.HttpServlet.service(HttpServlet.java:644)
  at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:842)
  at javax.servlet.http.HttpServlet.service(HttpServlet.java:725)
  at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:291)
  at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
  at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)
  at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239)
  at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
  at org.springframework.boot.actuate.autoconfigure.EndpointWebMvcAutoConfiguration$ApplicationContextHeaderFilter.doFilterInternal(EndpointWebMvcAutoConfiguration.java:291)
  at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
  at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239)
  at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
  at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:77)
  at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
  at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239)
  at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
  at org.springframework.boot.actuate.trace.WebRequestTraceFilter.doFilterInternal(WebRequestTraceFilter.java:102)
  at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
  at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239)
  at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
  at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:85)
  at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
  at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239)
  at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
  at org.springframework.boot.actuate.autoconfigure.MetricFilterAutoConfiguration$MetricsFilter.doFilterInternal(MetricFilterAutoConfiguration.java:90)
  at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
  at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239)
  at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
  at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:219)
  at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:106)
  at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:501)
  at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:142)
  at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:79)
  at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:88)
  at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:516)
  at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1086)
  at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:659)
  at org.apache.coyote.http11.Http11NioProtocol$Http11ConnectionHandler.process(Http11NioProtocol.java:223)
  at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1558)
  at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.run(NioEndpoint.java:1515)
  at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
  at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
  at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
  at java.lang.Thread.run(Thread.java:745)
```

### 问题原因
通过阅读两篇参考帖子，可知对于下列对象：
```
{ 
  "columnMatchMethod": 2,
  "ignoredHeaderCount": 1,
  "ignoredFooterCount": 0,
  "columns": [{
      "varName": "id",
      "varTitle": "The Id",
      "varIndex": 1
    }, {
      "varName": "name",
      "varTitle": "The Name",
      "varIndex": 2
    }, {
      "varName": "age",
      "varTitle": "The Age",
      "varIndex": 3
    }
  ]
}
```

JQuery是进行如下：
```
columnMatchMethod: 2,
ignoredHeaderCount: 1,
ignoredFooterCount: 0,
columns[0][varName]: "id",
columns[0][varTitle]: "The Id",
columns[0][varIndex]: 1
columns[1][varName]: "name",
columns[1][varTitle]: "The Name",
columns[1][varIndex]: 2
columns[2][varName]: "age",
columns[2][varTitle]: "The Age",
columns[2][varIndex]: 3
```

但是Spring MVC期望的是如下参数格式：
````
columnMatchMethod: 2,
ignoredHeaderCount: 1,
ignoredFooterCount: 0,
columns[0].varName: "id",
columns[0].varTitle: "The Id",
columns[0].varIndex: 1
columns[1].varName: "name",
columns[1].varTitle: "The Name",
columns[1].varIndex: 2
columns[2].varName: "age",
columns[2].varTitle: "The Age",
columns[2].varIndex: 3
```

### 解决方案

通过资料查找，采用参考帖子中的第二种方案解决问题。
- 客户端代码：
  ```
  setConf = function (event) {
    $.ajax({
      url: "configure",
      type: "POST",
      data: **JSON.stringify(metadata)**,
      **dataType: "json",
      contentType: "application/json",**
      success: function (res) {
        $('#cfgContent').text(JSON.stringify(res));
        $('#cfgError').text("");
      },
      error: function (res) {
        $('#cfgContent').text("");
        $('#cfgError').text(res.responseText);
      }
    });
  };
  ```
- 中间层代码：
   ```
   package com.yqu.rest;
   
   import org.springframework.beans.factory.annotation.Autowired;
   import org.springframework.http.HttpStatus;
   import org.springframework.ui.Model;
   import org.springframework.web.bind.annotation.*;
   import org.springframework.web.servlet.ModelAndView;
   
   import java.util.ArrayList;
   import java.util.List;
   
   @RestController
   public class ConfigurationController {
     @RequestMapping(value = "/", method = RequestMethod.GET)
     public ModelAndView home(Model m){
       System.out.println("home");
       return new ModelAndView("index");
     }
   
     @RequestMapping(value = "/configure", method = RequestMethod.GET)
     public @ResponseBody
     SheetVO getConfiguration() {
       List columns = new ArrayList();
       columns.add(new ColumnVO("id","The Id",1));
       columns.add(new ColumnVO("name","The Name",2));
       columns.add(new ColumnVO("age","The Age",3));
   
       SheetVO metadata = new SheetVO(SheetVO.TITLE_MATCHING, 1,0, columns);
       System.out.println("getConfiguration:"+metadata);
       return metadata;
     }
   
     @RequestMapping(value = "/configure", method = RequestMethod.POST)
     public @ResponseBody
     SheetVO setConfiguration(**@RequestBody** SheetVO metadata) {
       System.out.println(metadata);
       return metadata;
     }
   }
   ```

### 参考

[Spring MVC 3: Property referenced in indexed property path is neither an array nor a List nor a Map](http://www.bmchild.com/2014/02/spring-mvc-3-property-referenced-in.html)  
[Post Nested Object to Spring MVC controller using JSON](http://stackoverflow.com/questions/5900840/post-nested-object-to-spring-mvc-controller-using-json)  