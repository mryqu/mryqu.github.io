---
title: 'Tomcat JNDI 数据源配置'
date: 2012-08-22 09:19:36
categories: 
- Service+JavaEE
- Web Application Server
tags: 
- tomcat
- datasource
- jndi
- global naming resource
- context
---
学写一下[Tomcat:JNDI Datasource HOW-TO](http://tomcat.apache.org/tomcat-5.5-doc/jndi-datasource-examples-howto.html)，JNDI数据源可以配置到两个位置。Tomcat详细介绍了第二种方式，我目前的项目使用的是第一种方式。第一种方式的好处是，多个Web应用程序可以共享Tomcat全局命名空间里的资源。
- Tomcat全局命名空间
  $CATALINA_HOME$/conf/server.xml
  ![Tomcat:JNDI数据源配置](/images/2012/8/0026uWfMgy6OTI3IELI3e.jpg)
  $CATALINA_HOME$/conf/localhost/javatest.xml
  ![Tomcat:JNDI数据源配置](/images/2012/8/0026uWfMgy6OTIlpNN46e.png)
- Web应用程序环境(Context)![Tomcat:JNDI数据源配置](/images/2012/8/0026uWfMgy6OTIx4xLj29.jpg)