---
title: 'Spring Social合集'
date: 2015-11-01 06:03:04
categories: 
- DataBuilder
tags: 
- spring
- social
- facebook
- twitter
- linkedin
- crawler
---

### Hello Spring Social Twitter

学习了[Spring Accessing Twitter Data Guide](http://spring.io/guides/gs/accessing-twitter/) ，稍作修改，练习一下用Spring Social Twitter搜索推文。

#### 代码

src/main/java/com/yqu/springtwitter/Application.java  
```
package com.yqu.springtwitter;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {

  public static void main(String[] args) {
    SpringApplication.run(Application.class, args);
  }

} 
```

src/main/java/com/yqu/springtwitter/HelloController.java  
```
package com.yqu.springtwitter;

import javax.inject.Inject;

import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.twitter.api.SearchResults;
import org.springframework.social.twitter.api.Twitter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/")
public class HelloController {

  private Twitter twitter;

  private ConnectionRepository connectionRepository;

  @Inject
  public HelloController(Twitter twitter, 
      ConnectionRepository connectionRepository) {
    this.twitter = twitter;
    this.connectionRepository = connectionRepository;
  }

  @RequestMapping(method=RequestMethod.GET)
  public String helloTwitter(Model model, 
      @RequestParam(
          value = "searchTerm", 
          defaultValue = "mryqu", 
          required = false) String searchTerm,
      @RequestParam(
          value = "limit", 
          defaultValue = "20", 
          required = false) int limit) {
    if (connectionRepository.findPrimaryConnection(
        Twitter.class) == null) {
      return "redirect:/connect/twitter";
    }

    //OAuth1Connection conn = (OAuth1Connection) 
    //    connectionRepository.findPrimaryConnection(Twitter.class);
    //System.out.println(conn);

    model.addAttribute(twitter.userOperations().getUserProfile());
    SearchResults res = twitter.searchOperations().search(searchTerm, limit);
    model.addAttribute("tweets", res.getTweets());
    return "hello";
  }
}
```

src/main/resources/templates/connect/twitterConnect.html  
![twitterConnect.html](/images/2015/11/0026uWfMgy6XfJASEnP95.jpg)

src/main/resources/templates/connect/twitterConnected.html  
![twitterConnected.html](/images/2015/11/0026uWfMgy6XfJDaz598b.png)

src/main/resources/templates/hello.html  
![hello.html](/images/2015/11/0026uWfMgy6XfJETpsXcf.png)

src/main/resources/application.properties  
```
spring.social.twitter.appId={{put app ID here}}
spring.social.twitter.appSecret={{put app secret here}}
```

build.gradle  
```
buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:1.2.7.RELEASE")
    }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'
apply plugin: 'spring-boot'

jar {
    baseName = 'hello-spring-twitter'
    version =  '0.1.0'
}

repositories {
    mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
    compile("org.springframework.boot:spring-boot-starter-thymeleaf")
    compile("org.springframework.social:spring-social-twitter")
}

task wrapper(type: Wrapper) {
    gradleVersion = '2.3'
}
```

#### 测试

![Hello Spring Social Twitter](/images/2015/11/0026uWfMgy6XfIQgc3973.jpg)![Hello Spring Social Twitter](/images/2015/11/0026uWfMgy6XfJ1cQzAbe.jpg)

#### 参考

[Spring Social Twitter Project](http://projects.spring.io/spring-social-twitter/)  
[Spring Social Twitter Reference](http://docs.spring.io/spring-social-twitter/docs/current/reference/htmlsingle/)  
[Spring Social Project](http://projects.spring.io/spring-social/)  
[Spring Guide: Registering an Application with Twitter](http://spring.io/guides/gs/register-twitter-app/)  
[Spring Guide: Accessing Twitter Data](http://spring.io/guides/gs/accessing-twitter/)  
[Spring Guide: Creating a stream of live twitter data using Spring XD](http://spring.io/guides/gs/spring-xd/)  

### Hello Spring Social LinkedIn

本想玩玩Spring SocialLinkedIn，看看能从LinkedIn哪里获得什么有价值的数据。可是LinkedIn现在放开的只有r_basicprofile、r_emailaddress、rw_company_admin、w_share权限，如[LinkedIn developer program transition](https://developer.linkedin.com/support/developer-program-transition) 所说的不要在认证中请求r_fullprofile、r_network、r_contactinfo、rw_nus、rw_groups和w_messages权限了。
![Hello Spring Social LinkedIn](/images/2015/11/0026uWfMgy6XhM9H4GX6f.jpg)
在[LinkedIn API Console](https://apigee.com/console/linkedin) 中可试最多的是CompaniesAPI，可是我在LinkedIn上没有公司主页可以创建。所以浅尝则止，没什么太多可分享的。

#### 参考

[Spring Social LinkedIn Project](http://projects.spring.io/spring-social-linkedin/)  
[Spring Social Project](http://projects.spring.io/spring-social/)  
[GitHub: spring-projects/spring-social-samples](https://github.com/spring-projects/spring-social-samples)  
[LinkedIn Developer](https://developer.linkedin.com/)  
[LinkedIn API Console](https://apigee.com/console/linkedin)  
[LinkedIn developer program transition](https://developer.linkedin.com/support/developer-program-transition)  

### Spring Accessing Twitter Data Guide调试笔记

尝试[Spring Accessing Twitter Data Guide](http://spring.io/guides/gs/accessing-twitter/) 时碰到几个问题，这里记录一下。

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

由于我是在国内连接Twitter，所以需要代理。[Spring Social:SOCIAL-146: Enable use of Spring Social behind proxy](https://jira.spring.io/browse/SOCIAL-146) 任务对[org.springframework.social.support.ClientHttpRequestFactorySelector](https://github.com/spring-projects/spring-social/blob/master/spring-social-core/src/main/java/org/springframework/social/support/ClientHttpRequestFactorySelector.java) 类做了修改，现在可以通过设置系统变量http.proxyHost和http.proxyPort来解决连接超时失败这个问题。
![Spring Accessing Twitter Data Guide调试笔记](/images/2015/11/0026uWfMgy6WYc50DOLb7.jpg)

#### 401 (Authorization Required)问题

遇到POST request for "https://api.twitter.com/oauth/request_token"resulted in 401 (Authorization Required); invoking errorhandler错误，根据[stackoverflow的一个帖子](http://stackoverflow.com/questions/27642773/keep-getting-401-authorization-required-with-spring-social-twitter) ，将我的Twitter应用的CallbackURL随便设一个就解决了。Callback URL为空时，我用Twitter4J也没问题。帖子说Sping SocialFacebook/LinkedIn没这问题，应该是Sping Social Twitter处理有缺陷。
![Spring Accessing Twitter Data Guide调试笔记](/images/2015/11/0026uWfMgy6WYekJUDw8a.jpg)

### Spring Accessing Facebook Data Guide调试笔记

尝试[Spring Accessing Facebook Data Guide](http://spring.io/guides/gs/accessing-facebook/) 时，除了要像Spring Accessing Twitter Data Guide调试笔记中那样设置代理，还碰到几个其他问题，这里记录一下。

#### Null Pointer Exception

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

#### redirect_uri is not allowed

**描述：**Given URL is not allowed by the Applicationconfiguration: One or more of the given URLs is not allowed by theApp's settings. It must match the Website URL or Canvas URL, or thedomain must be a subdomain of one of the App's domains.

解决方案：
- Basci setting - Add platform - Website -http://localhost:8080/connect/facebook
  ![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6XgcCDiK99d.jpg)
- Advanced setting - Embedded browser OAuth Login
  ![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6XgcCQDZi34.jpg)

#### Invalid Scopes: read_stream

描述：read_stream在Facebook SDK2.4还是有效的，在SDK2.5时废弃了。 
![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6Xgdk4PBYfe.png)![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6XgdkwUWL3b.jpg)![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6Xgdl2S0w18.jpg)
解决方案：将facebookConnect.html中表单scope字段的内容由"read_stream"改成"email,public_profile"。 
![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6XgdlkTFM8a.jpg)

#### Facebook error: API calls from the server require anappsecret_proof argument

**描述：**org.springframework.social.UncategorizedApiException:API calls from the server require an appsecret_proof argument.

解决方案：禁止掉Require App Secret
![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6XgUIhYmq16.png)

#### The operation requires 'read_stream' permission.

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

解决方案：要想玩[Spring Accessing Facebook Data Guide](http://spring.io/guides/gs/accessing-facebook/) ，必须为应用申请read_stream权限。
![Spring Accessing Facebook Data Guide调试笔记](/images/2015/11/0026uWfMgy6Xh5u2mx64c.jpg)
