---
title: '[Spring Boot] 监控和管理Spring Boot应用'
date: 2015-07-11 06:53:41
categories: 
- Service+JavaEE
- Spring
tags: 
- spring
- boot
- management
- monitoring
---
本博文在[[Spring Boot] Hello Spring LDAP](/post/spring_boot_hello_spring_ldap) 基础上稍作修改，尝试一下监控和管理Spring Boot应用。

### application.properties改动
```
server.context-path=/HelloSpringLdapOdm
server.port=8080

spring.profiles.active=test,dev

# spring.dao.exceptiontranslation.enabled=false
yqu.ldap.url=ldap://127.0.0.1:18880
yqu.ldap.userDN=uid=admin,ou=system
yqu.ldap.password=secret
yqu.ldap.base=dc=jayway,dc=se
yqu.ldap.clean=true

management.port=8081
management.address=127.0.0.1
endpoints.shutdown.enabled=true

applicationDefaultJvmArgs: [
    "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=55558"
]
```

### 测试

- autoconfig: Displays an auto-configuration report showing allauto-configuration candidates and the reason why they ‘were’ or‘were not’ applied.![[Spring Boot] 监控和管理Spring Boot应用](/images/2015/7/0026uWfMgy6XA6SJD8C6a.jpg)
- beans: Displays a complete list of all the Spring beans in yourapplication.![[Spring Boot] 监控和管理Spring Boot应用](/images/2015/7/0026uWfMgy6XA6TxXtU52.jpg)
- configprops: Displays a collated list of all@ConfigurationProperties.![[Spring Boot] 监控和管理Spring Boot应用](/images/2015/7/0026uWfMgy6XA6TQq2z97.jpg)
- dump: Performs a thread dump.![[Spring Boot] 监控和管理Spring Boot应用](/images/2015/7/0026uWfMgy6XA6U3tpgba.jpg)
- env: Exposes properties from Spring’sConfigurableEnvironment.![[Spring Boot] 监控和管理Spring Boot应用](/images/2015/7/0026uWfMgy6XA6UeBXfbd.jpg)
- health: Shows application health information (when theapplication is secure, a simple ‘status’ when accessed over anunauthenticated connection or full message details whenauthenticated).![[Spring Boot] 监控和管理Spring Boot应用](/images/2015/7/0026uWfMgy6XA6UnaC9ed.jpg)
- info: Displays arbitrary application info.![[Spring Boot] 监控和管理Spring Boot应用](/images/2015/7/0026uWfMgy6XA6UuTJF3b.jpg)
- mappings: Displays a collated list of all @RequestMappingpaths.![[Spring Boot] 监控和管理Spring Boot应用](/images/2015/7/0026uWfMgy6XA6UFnlSa0.jpg)
- metrics: Shows ‘metrics’ information for the currentapplication.![[Spring Boot] 监控和管理Spring Boot应用](/images/2015/7/0026uWfMgy6XA6UP7ny78.jpg)
- trace: Displays trace information (by default the last few HTTPrequests).![[Spring Boot] 监控和管理Spring Boot应用](/images/2015/7/0026uWfMgy6XA6VxZs60a.jpg)
- shutdown: Allows the application to be gracefully shutdown (notenabled by default).![[Spring Boot] 监控和管理Spring Boot应用](/images/2015/7/0026uWfMgy6XA7CG51a0c.png)

### 参考

[Spring Boot: Monitoring and management over HTTP](http://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-monitoring.html)  
[Spring Boot Actuator：Production-ready features](http://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#production-ready-customizing-endpoints)  