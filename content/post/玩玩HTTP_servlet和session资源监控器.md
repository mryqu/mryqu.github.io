---
title: '玩玩HTTP servlet和session资源监控器'
date: 2013-11-07 22:40:45
categories: 
- Service+JavaEE
tags: 
- weblistener
- servletcontextlisten
- httpsessionlistener
- web
- javaee
---
[ WebListener](http://docs.oracle.com/javaee/6/api/javax/servlet/annotation/WebListener.html)是Servlet的监视器，它可以监听Http请求、会话生命周期事件等。其中包含如下接口：
- [ ServletContextListener](http://docs.oracle.com/javaee/6/api/javax/servlet/ServletContextListener.html):监视servlet上下文的初始化(启动Web应用的初始化过程)、销毁（关闭Web应用）。
- [ ServletContextAttributeListener](http://docs.oracle.com/javaee/6/api/javax/servlet/ServletContextAttributeListener.html):监视servlet上下文属性的添加、删除和替换。
- [ ServletRequestListener](http://docs.oracle.com/javaee/6/api/javax/servlet/ServletRequestListener.html):监视Http请求的初始化（进入第一个servlet或过滤器）、Web应用对请求处理结束（离开最后一个servlet或过滤器）。
- [ ServletRequestAttributeListener](http://docs.oracle.com/javaee/6/api/javax/servlet/ServletRequestAttributeListener.html):监视Http请求属性的添加、删除和替换。
- [ HttpSessionListener](http://docs.oracle.com/javaee/6/api/javax/servlet/http/HttpSessionListener.html):监视Http会话创建和失效操作。
- [ HttpSessionAttributeListener](http://docs.oracle.com/javaee/6/api/javax/servlet/http/HttpSessionAttributeListener.html):监视Http会话属性的添加、删除和替换。最近hello一个Web项目，其中有个向导上传文件进行处理，文件被保存在tomcat的临时目录，处理后再删除。过段时间发现临时目录里有一些未删除的临时文件，应该是上传文件后，在处理结束前有一段时间未进行操作，会话失效，临时文件没有被删除。后来添加了一个MyResourceMonitorListener完成这些未处理临时文件的删除操作，解决了这个问题。代码如下：

#### MyResourceMonitorListener
```
package com.yqu.http.session;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class MyResourceMonitorListener implements 
  ServletContextListener, HttpSessionListener {

 @Override
 public void sessionCreated(HttpSessionEvent event) {
  trace("sessionCreated!");

 }

 @Override
 public void sessionDestroyed(HttpSessionEvent event) {
  HttpSession session = event.getSession();
  if (session != null) {
   String sessionId = session.getId();
   trace("sessionDestroyed with sessionId=" + sessionId + "!");
   MyUtil.cleanSessionResources(session);
  }
 }

 @Override
 public void contextDestroyed(ServletContextEvent event) {
  MyUtil.cleanServletResources();

 }

 @Override
 public void contextInitialized(ServletContextEvent event) {
  MyUtil.cleanServletResources();
 }
 
 private void trace(String msg) {
  System.out.println(msg);
 }
}
```
#### MyUtil
```
package com.yqu.http.session;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;

import javax.servlet.http.HttpSession;

public class MyUtil {
 static final String PREFIX = "yqu-";
 static final String SUFFIX = ".tmp";
 public static final String FILEMETA = "yqu_resfile";

 public static File createTempFile() throws IOException {
  File tempFile = File.createTempFile(PREFIX, SUFFIX);
  return tempFile;
 }

 public static void cleanSessionResources(HttpSession session) {
  if (session != null) {
   String flName = (String) session.getAttribute(FILEMETA);
   if (flName != null) {
    File fl = new File(flName);
    if (fl.exists()) {
     try {
      fl.delete();
      trace(flName + " is deleted during cleanSessionResources().");
     } catch (Throwable t) {
      trace(t);
      fl.deleteOnExit();
     }
    }
   }
  }
 }

 public static void cleanServletResources() {
  try {
   File tempFile = File.createTempFile(PREFIX, SUFFIX);
   File tempFolder = tempFile.getParentFile();
   File[] files = tempFolder.listFiles(new TempFileFilter(PREFIX, SUFFIX));
   for (File fl : files) {
    try {
     fl.delete();
     trace(fl.getName() + " is deleted during cleanServletResources().");
    } catch (Exception e2) {
     trace(e2);
     fl.deleteOnExit();
    }
   }
  } catch (Exception e1) {
   trace(e1);
  }
 }
 
 private static void trace(String msg) {
  System.out.println(msg);
 }
 
 private static void trace(Throwable t) {
  t.printStackTrace();
 }
 
 private static class TempFileFilter implements FileFilter {
  private String prefix;
  private String suffix;

  public TempFileFilter(String prefix, String suffix) {
   this.prefix = prefix;
   this.suffix = suffix;
  }

  public boolean accept(File pathname) {
   if (pathname.exists() && pathname.isFile()) {
    String name = pathname.getName();
    return name.startsWith(prefix) && name.endsWith(suffix);
   } else {
    return false;
   }
  }
 }
}
```
#### web.xml
![玩玩HTTP servlet和session资源监控器](/images/2013/11/0026uWfMgy6OORNRcmBf1.png)