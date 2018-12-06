---
title: 'Spring FileUpload限制调整笔记'
date: 2015-06-08 06:42:28
categories: 
- Service及JavaEE
- Spring
tags: 
- fileupload
- limit
- tuning
- tomcat
- spring
---
### Tomcat配置

#### HTTP Connector - maxPostSize配置

**maxPostSize**: 在POST请求中容器FORMURL参数解析所能处理的最大字节数。该参数可以通过设置为小于零的负值禁掉该限制。如果没有设置，该属性为2097152(2M字节)。
该配置可在$CATALINA_BASE/conf/server.xml内修改:
![Spring FileUpload限制调整笔记](/content/images/2015/6/0026uWfMgy6WoVANiyD43.png)
Tomcat 7.0.63之前maxPostSzie="0"视为禁掉该限制。

#### multipart-config配置

**max-file-size**: 单个上传文件允许的最大字节数。默认-1，无限制。
**max-request-size**: 真个请求允许的最大字节数。默认-1，无限制。

这两个配置可在web.xml内修改：
![Spring FileUpload限制调整笔记](/content/images/2015/6/0026uWfMgy6WoXdlU4faf.png)
如果上传文件超过限制，则会抛出Exception。示例：
```
org.apache.tomcat.util.http.fileupload.FileUploadBase$SizeLimitExceededException: the request was rejected because its size (61198097) exceeds the configured maximum (20971520)
  at org.apache.tomcat.util.http.fileupload.FileUploadBase$FileItemIteratorImpl.(FileUploadBase.java:811)
  at org.apache.tomcat.util.http.fileupload.FileUploadBase.getItemIterator(FileUploadBase.java:256)
  at org.apache.tomcat.util.http.fileupload.FileUploadBase.parseRequest(FileUploadBase.java:280)
  at org.apache.catalina.connector.Request.parseParts(Request.java:2730)
  at org.apache.catalina.connector.Request.parseParameters(Request.java:3064)
  at org.apache.catalina.connector.Request.getParameter(Request.java:1093)
  at org.apache.catalina.connector.RequestFacade.getParameter(RequestFacade.java:380)
  at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:70)
  at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
  at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239)
  at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
  at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:85)
  at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
  at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239)
  at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
  at org.springframework.boot.actuate.autoconfigure.MetricsFilter.doFilterInternal(MetricsFilter.java:68)
  at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
  at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:239)
  at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
  at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:219)
  at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:106)
  at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:502)
  at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:142)
  at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:79)
  at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:88)
  at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:518)
  at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1091)
  at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:668)
  at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1521)
  at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.run(NioEndpoint.java:1478)
  at java.util.concurrent.ThreadPoolExecutor.runWorker(Unknown Source)
  at java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)
  at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
  at java.lang.Thread.run(Unknown Source)
```

通过[org.apache.tomcat.util.http.fileupload.FileUploadBase源代码](http://grepcode.com/file/repo1.maven.org/maven2/org.apache.tomcat.embed/tomcat-embed-core/8.0.23/org/apache/tomcat/util/http/fileupload/FileUploadBase.java#FileUploadBase)可知，Tomcat中对应属性为fileSizeMax和sizeMax。
这两个参数也可以在Spring代码通过annotation设置：
```
@WebServlet(name = "fileUploadServlet", urlPatterns = {"/upload"})
@MultipartConfig(location="/tmp",
                 fileSizeThreshold=0,    
                 maxFileSize=5242880,       // 5 MB
                 maxRequestSize=20971520)   // 20 MB
public class FileUploadServlet extends HttpServlet {
   protected void doPost(
              HttpServletRequest request, HttpServletResponse response)
   throws ServletException, IOException {
        //handle file upload
    }
```

### Spring Boot与Embeded Tomcat

通过[org.springframework.boot.autoconfigure.web.MultipartProperties源代码](https://github.com/spring-projects/spring-boot/blob/master/spring-boot-autoconfigure/src/main/java/org/springframework/boot/autoconfigure/web/MultipartProperties.java)可知，其maxFileSize默认为"1Mb"， maxRequestSize默认为"10Mb"。
通过[org.springframework.boot.context.embedded.MultipartConfigFactory源代码](https://github.com/spring-projects/spring-boot/blob/master/spring-boot/src/main/java/org/springframework/boot/context/embedded/MultipartConfigFactory.java)可知，其maxFileSize默认为-1，maxRequestSize默认为-1。
**值得注意的是，这两个默认值与[The Java EE 6 Tutorial](https://docs.oracle.com/javaee/6/tutorial/doc/gmhal.html)描述一致，与[org.springframework.boot.autoconfigure.web.MultipartProperties源代码](https://github.com/spring-projects/spring-boot/blob/master/spring-boot-autoconfigure/src/main/java/org/springframework/boot/autoconfigure/web/MultipartProperties.java)是不一致的。**
可以通过如下代码，完成HTTP Connector - maxPostSize配置和MultiPartConfig配置。
```
@SpringBootApplication
public class Application {
 @Autowired
 private MultipartConfigElement _multipartConfigElement;

 public static void main(String[] args) {
  SpringApplication.run(Application.class, args);
 }

 @Bean
 public ServletRegistrationBean dispatcherRegistration(
       DispatcherServlet dispatcherServlet) {
   ServletRegistrationBean registration = 
     new ServletRegistrationBean(
     dispatcherServlet);
   registration.addUrlMappings("/tmp");
   registration.setMultipartConfig(_multipartConfigElement);
   return registration;
 }


  @Bean
  public EmbeddedServletContainerCustomizer containerCustomizer()
  throws FileNotFoundException {
   return new EmbeddedServletContainerCustomizer() {
   @Override
   public void customize(ConfigurableEmbeddedServletContainer container) {
   if(container instanceof TomcatEmbeddedServletContainerFactory) {
     TomcatEmbeddedServletContainerFactory containerFactory = 
       (TomcatEmbeddedServletContainerFactory) container;
     containerFactory.addConnectorCustomizers(
       new TomcatConnectorCustomizer(){
         @Override
         public void customize(Connector connector) {
          connector.setMaxPostSize(-1);
         }
       });
     }
   };
  };
 }
  
 @Bean
 public MultipartConfigElement multipartConfigElement() {
  MultipartConfigElement retval = null;
  MultipartConfigFactory factory = new MultipartConfigFactory();
  factory.setMaxFileSize("5M");
  factory.setMaxRequestSize("20M");
  retval =  factory.createMultipartConfig();
  return retval;
 }
}
```

### 参考

[Apache Tomcat Configuration Reference - The HTTP Connector](https://tomcat.apache.org/tomcat-8.0-doc/config/http.html)  
[Tomcat settings: maxPostSize](http://www.captaincasademo.com/forum/posts/list/262.page)  
[Spring guides：uploading files](https://spring.io/guides/gs/uploading-files/)  
[Spring MVC 4 File Upload Example using Servlet 3 MultiPartConfigElement](http://websystique.com/springmvc/spring-mvc-4-file-upload-example-using-multipartconfigelement/)  
[Spring 4 Java Config for MultipartResolver for Servlet 3.0](http://stackoverflow.com/questions/23570014/spring-4-java-config-for-multipartresolver-for-servlet-3-0)  