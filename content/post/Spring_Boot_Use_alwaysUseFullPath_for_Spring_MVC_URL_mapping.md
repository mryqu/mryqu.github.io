---
title: '[Spring Boot] Use alwaysUseFullPath for Spring MVC URL mapping'
date: 2015-12-03 06:38:56
categories: 
- Service+JavaEE
- Spring
tags: 
- spring
- boot
- url
- mapping
- alwaysusefullpath
---
### 简介

SpringMVC的URL映射有一个控制路径匹配的参数alwaysUseFullPath。当它被设置为true后，总是使用当前servlet上下文中的全路径进行URL查找，否则使用当前servlet映射内的路径。默认为false。下面示例一下当一个请求的全路径通过servlet映射找到所服务的RequestDispatcherservelet后alwaysUseFullPath为false时URL映射表现：

|   |    |
| --- | --- 
|servlet mapping = "/*";|request URI = "/test/a" -> "/test/a"
|servlet mapping = "/";|request URI = "/test/a" -> "/test/a"
|servlet mapping = "/test/*";|request URI = "/test/a" -> "/a"
|servlet mapping = "/test";|request URI = "/test" -> ""
|servlet mapping = "/*.test";|request URI = "/a.test" -> ""

从[org.springframework.web.util.UrlPathHelper](https://github.com/spring-projects/spring-framework/blob/master/spring-web/src/main/java/org/springframework/web/util/UrlPathHelper.java)的getLookupPathForRequest方法可知，当alwaysUseFullPath为true时使用getPathWithinApplication获得待查找的全路径，否则使用getPathWithinServletMapping获得待查找的剩余路径。
如果对alwaysUseFullPath的设置进行修改，对RestController的请求映射也要做相应的设置修改。
```
@RequestMapping(value = {"**/test/dosomething**"}, method = RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE })
```
假设servlet映射为"/test/*"且RestControoler仅在方法级别进行请求映射，如果alwaysUseFullPath为true时请求映射为上面的"/test/dosomething"。则在alwaysUseFullPath改为false后，请求映射相应改为"/dosomething"即可。

### alwaysUseFullPath设置范例

想在SpringBoot应用中设定alwaysUseFullPath为true，可通过BeanPostProcessor完成其设置。
```
@SpringBootApplication
public class Application implements BeanPostProcessor {
   

  public static void main(String[] args) {
    final ApplicationContext applicationContext = 
                     SpringApplication.run(Application.class, args);
  }

  @Override
  public Object postProcessBeforeInitialization(Object bean, String beanName) 
  throws BeansException {
    if (bean instanceof RequestMappingHandlerMapping) {
      ((RequestMappingHandlerMapping) bean).setAlwaysUseFullPath(true);
    }
    return bean;
  }

  @Overrid
  public Object postProcessAfterInitialization(Object bean, String beanName) 
  throws BeansException {
    return bean;
  }
}
```

在我的范例中是使用了RestController和RequestMapping，如果使用simple URLmapping的话则需要将RequestMappingHandlerMapping相应替换为SimpleUrlHandlerMapping。
