---
title: 'Spring 框架: @RestController vs @Controller'
date: 2015-10-23 05:57:46
categories: 
- Service+JavaEE
- Spring
tags: 
- spring
- restcontroller
- controller
- difference
- 区别
---
今天扫了一眼RestController注解的实现，它是@Controller和@ResponseBody的合体。
```
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Controller
@ResponseBody
public @interface RestController {
        String value() default "";
}
```

至于@RestController与@Controller的所有区别，还不是完全明了。看了Srivatsan	Sundararajan和Swapna Sagi的大作[Spring Framework: @RestController vs @Controller](https://www.genuitec.com/spring-frameworkrestcontroller-vs-controller/)，感觉豁然开朗。

## Spring MVC框架和REST

Spring基于MVC框架的注解简化了创建RESTful web服务流程。传统MVS控制器和RESTfulweb服务控制器关键区别在于HTTP响应体创建方式。传统MVC控制器依赖试图技术，而RESTfulweb服务控制器仅仅返回对象并将对象数据作为JSON/XML直接写到HTTP响应中。关于使用Spring框架创建RESTfulWEB服务的技术细节，点击[这里](http://docs.spring.io/spring-framework/docs/current/spring-framework-reference/html/mvc.html)。
![Spring MVC传统工作流](/images/2015/10/0026uWfMzy7evDAilis5c.png)_图1: Spring MVC传统工作流_

### Spring MVC REST工作流

传统Spring MVC REST工作流步骤如下:
- 客户端以URI形式向web服务发送一个请求。The client sends a request to a webservice in URI form.
- 请求被DispatcherServlet拦截用于查找处理器映射（Handler Mappings）及类型。
  - 在应用上下文文件中定义的处理器映射会告知DispatcherServlet用于基于请求查找控制器的策略。
  - Spring MVC支持三种类型的请求URI与控制器间的映射：注解、名称转换和显式映射。
- 请求由控制器处理后，响应返回给DispatcherServlet后分发给视图。

在图1中，注意在传统工作流中ModelAndView对象由控制器转发给客户端。在方法上使用@ResponseBody注解，Spring可让应用直接从控制器返回数据，不再查找视图。从第4版起，引入@RestController注解进一步简化处理流程。两种使用方式解释如下。

## 使用@ResponseBody注解

当对一个方法使用@ResponseBody注解后，Spring将返回值进行转换并自动写入Http响应中。控制器类的每个方法必须使用@ResponseBody进行注解。
![Spring 3.x MVC RESTful web服务工作流](/images/2015/10/0026uWfMzy7evNBnXfSfc.png)_图2: Spring 3.x MVC RESTful web服务工作流_

### 幕后工作

Spring在幕后注册了一系列HttpMessageConverters。HTTPMessageConverter负责根据预先定义的MIME类型将请求体转换成特定类及将特定类转换成响应体。每次一个请求匹配上@ResponseBody，Spring遍历所有已注册的HTTPMessageConverter，查找到第一个匹配上给定MIME类型和类的HTTPMessageConverter用之进行实际转换。

### 代码示例

下面过一个使用@ResponseBody的简单示例。

1. 创建名为Employee的Java POJO类。
   ```
   package com.example.spring.model;
    
   import javax.xml.bind.annotation.XmlRootElement;
    
   @XmlRootElement(name = "Employee")
   public class Employee {
    
     String name;
     String email;
    
     public String getName() {
           return name;
     }
    
     public void setName(String name) {
       this.name = name;
     }
    
     public String getEmail() {
       return email;
     }
    
     public void setEmail(String email) {
           this.email = email;
     }
    
     public Employee() {
     }
   }
   ```
2. 创建如下@Controller类：
   ```
   package com.example.spring.rest;
    
   import org.springframework.stereotype.Controller;
   import org.springframework.web.bind.annotation.PathVariable;
   import org.springframework.web.bind.annotation.RequestMapping;
   import org.springframework.web.bind.annotation.RequestMethod;
   import org.springframework.web.bind.annotation.ResponseBody;
    
   import com.example.spring.model.Employee;
    
   @Controller
   @RequestMapping("employees")
   public class EmployeeController {
    
     Employee employee = new Employee();
    
     @RequestMapping(value = "/{name}", method = RequestMethod.GET, 
                     produces = "application/json")
     public @ResponseBody Employee getEmployeeInJSON(
                     @PathVariable String name) {
       employee.setName(name);
       employee.setEmail("employee1@genuitec.com");
       return employee;
     }
    
     @RequestMapping(value = "/{name}.xml", method = RequestMethod.GET, 
                     produces = "application/xml")
     public @ResponseBody Employee getEmployeeInXML(
                     @PathVariable String name) {
           employee.setName(name);
           employee.setEmail("employee1@genuitec.com");
           return employee;
     }
   }
   ```
   注意@ResponseBody被添加到每个@RequestMapping方法的返回值中。

3. 将`<context:component-scan>`和`<mvc:annotation-driven/>`添加到Spring配置文件中。
    - 激活注解并扫描包以查找并在应用上下文中注册bean。
    - `<mvc:annotation-driven/>`在classpath包含ackson/JAXB库文件时添加对JSON/XML读写的支持。
    - 在项目classpath上添加用于JSON格式的jackson-databindjar包和用于XML格式的jaxb-api-osgi jar包。
4. 在任何服务器上部署和运行应用。
   **JSON**—使用URL：`http://localhost:8080/SpringRestControllerExample/rest/employees/Bob` 输出显示如下:
   ![JSON输出](/images/2015/10/0026uWfMzy7evNZL66i96.png)
   _图3:JSON输出_
   **XML**—使用URL：`http://localhost:8080/SpringRestControllerExample/rest/employees/Bob.xml`
   输出显示如下:![Spring 框架: @RestController vs @Controller](/images/2015/10/0026uWfMzy7evNUZcX7b9.jpg)
   _图4:XML输出_

## 使用@RestController注解

Spring4.0引入@RestController，一个特殊版本的控制器，除了添加@Controller和@ResponseBody外与一般控制器无异。通过对控制器类使用@RestController注解，无需对其请求映射方法添加@ResponseBody注解。默认@ResponseBody注解已被激活。点击[这里](http://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/web/bind/annotation/RestController.html)获取更多细节。
![Spring 4.x MVC RESTful Web服务工作流](/images/2015/10/0026uWfMzy7evOq7K6c20.png)_图5: Spring 4.x MVC RESTful Web服务工作流_
为了在示例中使用@RestController，继续将@Controller改为@RestController且移除每个方法上的@ResponseBody注解。改动后代码如下：
```
package com.example.spring.rest;
 
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
 
import com.example.spring.model.Employee;
 
@RestController
@RequestMapping("employees")
public class EmployeeController {
  Employee employee = new Employee();
 
  @RequestMapping(value = "/{name}", method = RequestMethod.GET, 
                  produces = "application/json")
  public Employee getEmployeeInJSON(@PathVariable String name) {
          employee.setName(name);
          employee.setEmail("employee1@genuitec.com");
        return employee; 
  }
 
  @RequestMapping(value = "/{name}.xml", method = RequestMethod.GET, 
                  produces = "application/xml")
  public Employee getEmployeeInXML(@PathVariable String name) {
        employee.setName(name);
        employee.setEmail("employee1@genuitec.com");
        return employee;
  }
}
```
注意每个请求映射方法不再需要@ResponseBody注解。重新运行改动后应用，其输出与之前的结果没有变化。

## 结论

如大家所看到的一样，使用@RestController更加简单，是Spring v4.0之后用于创建MVC RESTfulweb服务的首选方法。

## 源码分析

[RequestMappingHandlerAdapter](https://github.com/spring-projects/spring-framework/blob/master/spring-webmvc/src/main/java/org/springframework/web/servlet/mvc/method/annotation/RequestResponseBodyMethodProcessor.java)类的supportsReturnType方法同时对类和方法检查是否支持@ResponseBody注解，如果支持，则handleReturnValue方法会选择合适的HttpMessageConverter处理控制器方法返回值。而@RestController注解继承了@ResponseBody，所以肯定会命中上述[RequestMappingHandlerAdapter](https://github.com/spring-projects/spring-framework/blob/master/spring-webmvc/src/main/java/org/springframework/web/servlet/mvc/method/annotation/RequestResponseBodyMethodProcessor.java)类的方法。

### 参考

[Spring MVC之@RequestBody, @ResponseBody 详解](http://blog.csdn.net/kobejayandy/article/details/12690555)  