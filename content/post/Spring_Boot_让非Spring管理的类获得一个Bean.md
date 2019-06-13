---
title: '[Spring Boot] 让非Spring管理的类获得一个Bean'
date: 2015-12-04 06:08:47
categories: 
- Service+JavaEE
- Spring
tags: 
- spring
- boot
- get
- bean
---
我有一个工具类，它既会被SpringBean调用，也会被非Spring管理的类调用。我想在这个工具类里获得Spring注入了拦截器的RestTemplate。一开始考虑了ApplicationContextAware、ContextLoaderListener和ContextLoaderServlet，最后采用了下面这种改动最小的解决方案。

### 示例代码

#### Application.java
```
@SpringBootApplication
public class Application{

  public static void main(String[] args) {
    final ApplicationContext applicationContext = 
                     SpringApplication.run(Application.class, args);
    MyUtil.setApplicationContext(applicationContext);
  }
  
  @Bean
  public RestTemplate restTemplate() { 
    return new RestTemplate(); 
  }
}
```

#### MyUtil.java
```
public class MyUtil {
  private static ApplicationContext applicationContext;

  public static void setApplicationContext(ApplicationContext context) {
    applicationContext = context;
  }
  
   public static void doSomething() {
    RestTemplate _restTemplate = applicationContext.getBean(RestTemplate.class);
    ........
  } 
}
```
