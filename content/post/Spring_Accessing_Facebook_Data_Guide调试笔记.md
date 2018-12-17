---
title: 'Spring Accessing Facebook Data Guide调试笔记'
date: 2015-11-06 05:45:40
categories: 
- DataBuilder
tags: 
- spring
- social
- facebook
- read_stream
- appsecret_proof
---
尝试[Spring Accessing Facebook Data Guide](http://spring.io/guides/gs/accessing-facebook/)时，除了要像[Spring Accessing Twitter Data Guide调试笔记](/post/spring_accessing_twitter_data_guide调试笔记)中那样设置代理，还碰到几个其他问题，这里记录一下。

### Null Pointer Exception

描述
```
java.lang.NullPointerException: null
   at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:1.8.0_51]
   at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[na:1.8.0_51]
   at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:1.8.0_51]
   at java.lang.reflect.Method.invoke(Method.java:497) ~[na:1.8.0_51]
   at org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:302) ~[spring-aop-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190) ~[spring-aop-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157) ~[spring-aop-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:133) ~[spring-aop-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:121) ~[spring-aop-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179) ~[spring-aop-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.aop.framework.JdkDynamicAopProxy.invoke(JdkDynamicAopProxy.java:208) ~[spring-aop-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at com.sun.proxy.$Proxy49.isAuthorized(Unknown Source) ~[na:na]
   at hello.HelloController.helloFacebook(HelloController.java:26) ~[bin/:na]
   at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:1.8.0_51]
   at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[na:1.8.0_51]
   at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:1.8.0_51]
   at java.lang.reflect.Method.invoke(Method.java:497) ~[na:1.8.0_51]
   at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:222) ~[spring-web-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:137) ~[spring-web-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:110) ~[spring-webmvc-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:814) ~[spring-webmvc-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:737) ~[spring-webmvc-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85) ~[spring-webmvc-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:959) ~[spring-webmvc-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:893) ~[spring-webmvc-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:970) ~[spring-webmvc-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:861) ~[spring-webmvc-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at javax.servlet.http.HttpServlet.service(HttpServlet.java:622) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:846) ~[spring-webmvc-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at javax.servlet.http.HttpServlet.service(HttpServlet.java:729) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:291) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52) ~[tomcat-embed-websocket-8.0.28.jar:8.0.28]
   at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99) ~[spring-web-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107) ~[spring-web-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:87) ~[spring-web-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107) ~[spring-web-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:77) ~[spring-web-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107) ~[spring-web-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:121) ~[spring-web-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107) ~[spring-web-4.2.3.RELEASE.jar:4.2.3.RELEASE]
   at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:217) ~[tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:106) [tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:502) [tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:142) [tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:79) [tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:88) [tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:518) [tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1091) [tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:673) [tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1500) [tomcat-embed-core-8.0.28.jar:8.0.28]
   at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.run(NioEndpoint.java:1456) [tomcat-embed-core-8.0.28.jar:8.0.28]
   at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142) [na:1.8.0_51]
   at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617) [na:1.8.0_51]
   at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61) [tomcat-embed-core-8.0.28.jar:8.0.28]
   at java.lang.Thread.run(Thread.java:745) [na:1.8.0_51]
```

解决方案：将classpath("org.springframework.boot:spring-boot-gradle-plugin:1.3.0.RELEASE")替换成classpath("org.springframework.boot:spring-boot-gradle-plugin:1.2.3.RELEASE")

### redirect_uri is not allowed

**描述：**Given URL is not allowed by the Applicationconfiguration: One or more of the given URLs is not allowed by theApp's settings. It must match the Website URL or Canvas URL, or thedomain must be a subdomain of one of the App's domains.

解决方案：
- Basci setting - Add platform - Website -http://localhost:8080/connect/facebook
  ![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6XgcCDiK99d.jpg)
- Advanced setting - Embedded browser OAuth Login
  ![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6XgcCQDZi34.jpg)

### Invalid Scopes: read_stream

描述：read_stream在Facebook SDK2.4还是有效的，在SDK2.5时废弃了。
![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6Xgdk4PBYfe.png)![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6XgdkwUWL3b.jpg)![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6Xgdl2S0w18.jpg)
解决方案：将facebookConnect.html中表单scope字段的内容由"read_stream"改成"email,public_profile"。
![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6XgdlkTFM8a.jpg)

### Facebook error: API calls from the server require anappsecret_proof argument

**描述：**org.springframework.social.UncategorizedApiException:API calls from the server require an appsecret_proof argument.

解决方案：禁止掉Require App Secret
![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6XgUIhYmq16.png)

### The operation requires 'read_stream' permission.

facebook.feedOperations().getHomeFeed()操作就是要read_stream权限，看来是绕不开了。
```
org.springframework.social.InsufficientPermissionException: The operation requires 'read_stream' permission.
   at org.springframework.social.facebook.api.impl.FacebookErrorHandler.handleFacebookError(FacebookErrorHandler.java:116)
   at org.springframework.social.facebook.api.impl.FacebookErrorHandler.handleError(FacebookErrorHandler.java:65)
   at org.springframework.web.client.RestTemplate.handleResponse(RestTemplate.java:614)
   at org.springframework.web.client.RestTemplate.doExecute(RestTemplate.java:570)
   at org.springframework.web.client.RestTemplate.execute(RestTemplate.java:545)
   at org.springframework.web.client.RestTemplate.getForObject(RestTemplate.java:253)
   at org.springframework.social.facebook.api.impl.FeedTemplate.fetchConnectionList(FeedTemplate.java:367)
   at org.springframework.social.facebook.api.impl.FeedTemplate.getHomeFeed(FeedTemplate.java:106)
   at org.springframework.social.facebook.api.impl.FeedTemplate.getHomeFeed(FeedTemplate.java:95)
   at hello.HelloController.helloFacebook(HelloController.java:31)
   at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
   at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
   at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
   at java.lang.reflect.Method.invoke(Method.java:497)
   at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:221)
   at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:137)
   at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:110)
   at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandleMethod(RequestMappingHandlerAdapter.java:776)
   at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:705)
   at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)
   at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:959)
   at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:893)
   at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:966)
   at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:857)
   at javax.servlet.http.HttpServlet.service(HttpServlet.java:618)
   at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:842)
   at javax.servlet.http.HttpServlet.service(HttpServlet.java:725)
   at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:291)
   at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
   at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)
   at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239)
   at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
   at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:77)
   at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
   at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239)
   at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
   at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:85)
   at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
   at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239)
   at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
   at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:219)
   at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:106)
   at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:501)
   at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:142)
   at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:79)
   at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:88)
   at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:516)
   at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1086)
   at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:659)
   at org.apache.coyote.http11.Http11NioProtocol$Http11ConnectionHandler.process(Http11NioProtocol.java:223)
   at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1558)
   at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.run(NioEndpoint.java:1515)
   at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
   at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
   at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
   at java.lang.Thread.run(Thread.java:745)
```

解决方案：要想玩[Spring Accessing Facebook Data Guide](http://spring.io/guides/gs/accessing-facebook/)，必须为应用申请read_stream权限。
![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6Xh5u2mx64c.jpg)