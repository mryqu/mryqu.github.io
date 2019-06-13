---
title: 'Tomcat中使用Connector/J连接MySQL的超时问题'
date: 2014-05-05 20:58:54
categories: 
- Service+JavaEE
- Web Application Server
tags: 
- tomcat
- mysql
- connector/j
- wait_timeout
- autoreconnect
---
最近玩的一个Web项目，上一个晚上做一些操作，第二天超时需要再登陆，却总是报密码不正确。需要重启tomcat才能解决。异常如下：
```
Caused by: com.mysql.jdbc.exceptions.jdbc4.CommunicationsException: The last packet successfully received from the server was 442,814,107 milliseconds ago.  The last packet sent successfully to the server was 442,814,107 milliseconds ago. is longer than the server configured value of 'wait_timeout'. You should consider either expiring and/or testing connection validity before use in your application, increasing the server configured values for client timeouts, or using the Co nnector/J connection property 'autoReconnect=true' to avoid this problem.
        at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
        at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:57)
        at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
        at java.lang.reflect.Constructor.newInstance(Constructor.java:526)
        at com.mysql.jdbc.Util.handleNewInstance(Util.java:408)
        at com.mysql.jdbc.SQLError.createCommunicationsException(SQLError.java:1137)
        at com.mysql.jdbc.MysqlIO.send(MysqlIO.java:3983)
        at com.mysql.jdbc.MysqlIO.sendCommand(MysqlIO.java:2596)
        at com.mysql.jdbc.MysqlIO.sqlQueryDirect(MysqlIO.java:2776)
        at com.mysql.jdbc.ConnectionImpl.execSQL(ConnectionImpl.java:2840)
        at com.mysql.jdbc.PreparedStatement.executeInternal(PreparedStatement.java:2082)
        at com.mysql.jdbc.PreparedStatement.executeQuery(PreparedStatement.java:2212)
        at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.extract(ResultSetReturnImpl.java:80)
        at org.hibernate.loader.Loader.getResultSet(Loader.java:2065)
        at org.hibernate.loader.Loader.executeQueryStatement(Loader.java:1862)
        at org.hibernate.loader.Loader.executeQueryStatement(Loader.java:1838)
        at org.hibernate.loader.Loader.doQuery(Loader.java:909)
        at org.hibernate.loader.Loader.doQueryAndInitializeNonLazyCollections(Loader.java:354)
        at org.hibernate.loader.Loader.doList(Loader.java:2553)
        at org.hibernate.loader.Loader.doList(Loader.java:2539)
        at org.hibernate.loader.Loader.listIgnoreQueryCache(Loader.java:2369)
        at org.hibernate.loader.Loader.list(Loader.java:2364)
        at org.hibernate.loader.hql.QueryLoader.list(QueryLoader.java:496)
        at org.hibernate.hql.internal.ast.QueryTranslatorImpl.list(QueryTranslatorImpl.java:387)
        at org.hibernate.engine.query.spi.HQLQueryPlan.performList(HQLQueryPlan.java:231)
        at org.hibernate.internal.SessionImpl.list(SessionImpl.java:1264)
        at org.hibernate.internal.QueryImpl.list(QueryImpl.java:103)
        at xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.lang.reflect.Method.invoke(Method.java:606)
        at org.springframework.web.bind.annotation.support.HandlerMethodInvoker.invokeHandlerMethod(HandlerMethodInvoker.java:175)
        at org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter.invokeHandlerMethod(AnnotationMethodHandlerAdapter.java:446)
        at org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter.handle(AnnotationMethodHandlerAdapter.java:434)
        at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:938)
        at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:870)
        at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:961)
        at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:863)
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:646)
        at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:837)
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:727)
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:303)
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
        at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
        at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:220)
        at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:122)
        at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:501)
        at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:171)
        at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:102)
        at org.apache.catalina.valves.AccessLogValve.invoke(AccessLogValve.java:950)
        at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:116)
        at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:408)
        at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1040)
        at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:607)
        at org.apache.tomcat.util.net.JIoEndpoint$SocketProcessor.run(JIoEndpoint.java:316)
        ... 4 more
Caused by: java.net.SocketException: Software caused connection abort: socket write error
        at java.net.SocketOutputStream.socketWrite0(Native Method)
        at java.net.SocketOutputStream.socketWrite(SocketOutputStream.java:113)
        at java.net.SocketOutputStream.write(SocketOutputStream.java:159)
        at java.io.BufferedOutputStream.flushBuffer(BufferedOutputStream.java:82)
        at java.io.BufferedOutputStream.flush(BufferedOutputStream.java:140)
        at com.mysql.jdbc.MysqlIO.send(MysqlIO.java:3964)
        ... 58 more
```

学习了如下帖子：
[MySQL Connector/J Developer Guide :: 10 Using Connector/J with Tomcat](http://dev.mysql.com/doc/connector-j/en/connector-j-usagenotes-tomcat.html)  
[java调用mysql获取不到连接的问题](http://aayy520.blog.163.com/blog/static/23182260201102994534777/)  
[ MySql autoReconnect=true 后连接超时](http://blog.163.com/huangfei_person/blog/static/58156675201092911507809)  
[Mysql 中的autoReconnect=true参数](http://duming115.iteye.com/blog/848254)  

最后决定采用如下方案：
#### hibernate增加如下设置:
![Tomcat中使用Connector/J连接MySQL的超时问题](/images/2014/5/0026uWfMzy6OK64J81K24.png)
#### 数据库连接池增加如下设置:
![Tomcat中使用Connector/J连接MySQL的超时问题](/images/2014/5/0026uWfMzy6OK5XM1ABf1.png)