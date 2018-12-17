---
title: '[Spring Boot] Hello MethodInvokingFactoryBean and MethodInvokingBean'
date: 2015-11-05 05:58:07
categories: 
- Service及JavaEE
- Spring
tags: 
- spring
- methodinvokingfactor
- methodinvokingbean
---
### 简介

在用spring管理我们的类的时候有时候希望有些属性值是来源于一些配置文件，系统属性，或者一些方法调用的结果，对于前两种使用方式可以使用spring的PropertyPlaceholderConfigurer类来注入，对于后一种则可以使用org.springframework.beans.factory.config.MethodInvokingFactoryBean类来生成需要注入的bean的属性。

通过MethodInvokingFactory Bean类，可注入方法返回值。MethodInvokingFactoryBean用来获得某个方法的返回值，该方法既可以是静态方法，也可以是实例方法。该方法的返回值可以注入bean实例属性，也可以直接定义成bean实例。

MethodInvokingBean是MethodInvokingFactoryBean的父类，更为简单。跟MethodInvokingFactoryBean相比，不会对容器返回任何值。

### 类层次关系
![[Spring Boot] Hello MethodInvokingFactoryBean and MethodInvokingBean](/images/2015/11/0026uWfMgy6X1Fdzgqw04.png)
### 示例代码：
```
package com.yqu.methodinvoker;

import java.util.Arrays;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.config.MethodInvokingBean;
import org.springframework.beans.factory.config.MethodInvokingFactoryBean;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class Application {
  private static final Logger log =
      LoggerFactory.getLogger(Application.class);

  public static void main(String[] args) {
    SpringApplication app = new SpringApplication(Application.class);
    app.setWebEnvironment(false);
    app.setShowBanner(false);
    app.run(args);
    log.info("sysProp http.proxyHost:"+System.getProperty("http.proxyHost"));
    log.info("sysProp http.proxyPort:"+System.getProperty("http.proxyPort"));
    
    
  }
  
  @Bean 
  public MethodInvokingFactoryBean methodInvokingFactoryBean() {
    MethodInvokingFactoryBean mfBean = new MethodInvokingFactoryBean();
    mfBean.setStaticMethod("java.lang.System.setProperties");
    Properties props = System.getProperties();
    props.setProperty("http.proxyHost", "proxy.yqu.com");
    props.setProperty("http.proxyPort", "80");
    mfBean.setArguments(new Object[] { props });
    return mfBean;
  }
  
  @Bean 
  public MethodInvokingBean methodInvokingBean() {
    MethodInvokingBean mBean = new MethodInvokingBean();
    mBean.setStaticMethod("com.yqu.methodinvoker.Application.finish");
    mBean.setArguments(
        new String[] {
            "--url", "jdbc:hsqldb:mem:testdb",
            "--user", "sa", "--password", ""
            }
        );
    return mBean;
  }
  
  public static void finish(String[] args) {
    log.info("finish "+Arrays.toString(args));
  }
  
  private String getStacks() {
    StringBuilder sb = new StringBuilder();
    StackTraceElement[] elements = Thread.currentThread().getStackTrace();
    sb.append("========================\n");

    for (int i = 0; i < elements.length; i++) {
      sb.append(elements[i]).append("\n");
    }
    return sb.toString();
  }  
}
```

### 输出：
![[Spring Boot] Hello MethodInvokingFactoryBean and MethodInvokingBean](/images/2015/11/0026uWfMgy6X1GVrxwx9d.jpg)
### 参考

[MethodInvokingFactoryBean JavaDoc](http://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/beans/factory/config/MethodInvokingFactoryBean.html)  
[MethodInvokingBean JavaDoc](http://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/beans/factory/config/MethodInvokingBean.html)  
[Spring MethodInvokingFactoryBean Example](http://www.mkyong.com/spring/spring-methodinvokingfactorybean-example/)  
[Set System Property With Spring Configuration File](http://stackoverflow.com/questions/3339736/set-system-property-with-spring-configuration-file)  
[Proxy Workaround for M3](http://forum.spring.io/forum/spring-projects/web/social/101030-proxy-workaround-for-m3)  