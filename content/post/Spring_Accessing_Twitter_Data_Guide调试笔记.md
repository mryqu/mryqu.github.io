---
title: 'Spring Accessing Twitter Data Guide调试笔记'
date: 2015-11-04 05:57:55
categories: 
- DataBuilder
tags: 
- spring
- social
- twitter
- timeout
- 401
---
尝试[Spring Accessing Twitter Data Guide](http://spring.io/guides/gs/accessing-twitter/)时碰到几个问题，这里记录一下。

### 连接超时问题

遇到I/O error on POST request for"https://api.twitter.com/oauth/request_token"错误:
```
org.springframework.web.client.ResourceAccessException: I/O error on POST request for "https://api.twitter.com/oauth/request_token":Connection timed out: connect; nested exception is java.net.ConnectException: Connection timed out: connect
        at org.springframework.web.client.RestTemplate.doExecute(RestTemplate.java:582)
        at org.springframework.web.client.RestTemplate.execute(RestTemplate.java:547)
        at org.springframework.web.client.RestTemplate.exchange(RestTemplate.java:468)
        at org.springframework.social.oauth1.OAuth1Template.exchangeForToken(OAuth1Template.java:187)
        at org.springframework.social.oauth1.OAuth1Template.fetchRequestToken(OAuth1Template.java:115)
        at org.springframework.social.connect.web.ConnectSupport.fetchRequestToken(ConnectSupport.java:212)
        at org.springframework.social.connect.web.ConnectSupport.buildOAuth1Url(ConnectSupport.java:199)
        at org.springframework.social.connect.web.ConnectSupport.buildOAuthUrl(ConnectSupport.java:126)
        at org.springframework.social.connect.web.ConnectController.connect(ConnectController.java:226)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.lang.reflect.Method.invoke(Method.java:497)
        at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:221)
        at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:137)
        at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:110)
        at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:775)
        at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:705)
        at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)
        at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:959)
        at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:893)
        at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:967)
        at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:869)
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:648)
        at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:843)
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:729)
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
        at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:217)
        at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:106)
        at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:502)
        at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:142)
        at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:79)
        at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:88)
        at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:518)
        at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1091)
        at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:673)
        at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1500)
        at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.run(NioEndpoint.java:1456)
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
        at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
        at java.lang.Thread.run(Thread.java:745)
Caused by: java.net.ConnectException: Connection timed out: connect
        at java.net.DualStackPlainSocketImpl.connect0(Native Method)
        at java.net.DualStackPlainSocketImpl.socketConnect(DualStackPlainSocketImpl.java:79)
        at java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:345)
        at java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:206)
        at java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:188)
        at java.net.PlainSocketImpl.connect(PlainSocketImpl.java:172)
        at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:392)
        at java.net.Socket.connect(Socket.java:589)
        at sun.security.ssl.SSLSocketImpl.connect(SSLSocketImpl.java:668)
        at sun.security.ssl.BaseSSLSocketImpl.connect(BaseSSLSocketImpl.java:173)
        at sun.net.NetworkClient.doConnect(NetworkClient.java:180)
        at sun.net.www.http.HttpClient.openServer(HttpClient.java:432)
        at sun.net.www.http.HttpClient.openServer(HttpClient.java:527)
        at sun.net.www.protocol.https.HttpsClient.(HttpsClient.java:275)
        at sun.net.www.protocol.https.HttpsClient.New(HttpsClient.java:371)
        at sun.net.www.protocol.https.AbstractDelegateHttpsURLConnection.getNewHttpClient(AbstractDelegateHttpsURLConnection.java:191)
        at sun.net.www.protocol.http.HttpURLConnection.plainConnect0(HttpURLConnection.java:1104)
        at sun.net.www.protocol.http.HttpURLConnection.plainConnect(HttpURLConnection.java:998)
        at sun.net.www.protocol.https.AbstractDelegateHttpsURLConnection.connect(AbstractDelegateHttpsURLConnection.java:177)
        at sun.net.www.protocol.https.HttpsURLConnectionImpl.connect(HttpsURLConnectionImpl.java:153)
        at org.springframework.http.client.SimpleBufferingClientHttpRequest.executeInternal(SimpleBufferingClientHttpRequest.java:81)
        at org.springframework.http.client.AbstractBufferingClientHttpRequest.executeInternal(AbstractBufferingClientHttpRequest.java:48)
        at org.springframework.http.client.AbstractClientHttpRequest.execute(AbstractClientHttpRequest.java:53)
        at org.springframework.web.client.RestTemplate.doExecute(RestTemplate.java:571)
        ... 53 more

```

由于我是在国内连接Twitter，所以需要代理。[Spring Social:SOCIAL-146: Enable use of Spring Social behind proxy](https://jira.spring.io/browse/SOCIAL-146)任务对[org.springframework.social.support.ClientHttpRequestFactorySelector](https://github.com/spring-projects/spring-social/blob/master/spring-social-core/src/main/java/org/springframework/social/support/ClientHttpRequestFactorySelector.java)类做了修改，现在可以通过设置系统变量http.proxyHost和http.proxyPort来解决连接超时失败这个问题。
![Spring Accessing Twitter Data Guide调试笔记](/images/2015/11/0026uWfMgy6WYc50DOLb7.jpg)
### 401 (Authorization Required)问题

遇到POST request for "https://api.twitter.com/oauth/request_token"resulted in 401 (Authorization Required); invoking errorhandler错误，根据[stackoverflow的一个帖子](http://stackoverflow.com/questions/27642773/keep-getting-401-authorization-required-with-spring-social-twitter)，将我的Twitter应用的CallbackURL随便设一个就解决了。Callback URL为空时，我用Twitter4J也没问题。帖子说Sping SocialFacebook/LinkedIn没这问题，应该是Sping Social Twitter处理有缺陷。
![Spring Accessing Twitter Data Guide调试笔记](/images/2015/11/0026uWfMgy6WYekJUDw8a.jpg)