---
title: '显示jar文件中某个类的公开方法'
date: 2013-07-26 20:58:28
categories: 
- Java
tags: 
- jar
- jarp
- 类
- 公开方法
---

### 使用jar命令显示jar文件的内容
```
C:\>jar tvf log4j.jar
     0 SatAug 25 00:29:46 GMT+08:00 2007 META-INF/
   262 Sat Aug 25 00:29:44GMT+08:00 2007 META-INF/MANIFEST.MF
     0 SatAug 25 00:10:04 GMT+08:00 2007 org/
     0 SatAug 25 00:10:04 GMT+08:00 2007 org/apache/
     0 SatAug 25 00:10:06 GMT+08:00 2007 org/apache/log4j/
   .................
   676 Sat Aug 25 00:10:04GMT+08:00 2007 org/apache/log4j/Appender.class
  2567 Sat Aug 25 00:10:04 GMT+08:00 2007org/apache/log4j/Logger.class
  1038 Sat Aug 25 00:10:04 GMT+08:00 2007org/apache/log4j/Layout.class
   .................
     0 SatAug 25 00:29:46 GMT+08:00 2007 META-INF/maven/
     0 SatAug 25 00:29:46 GMT+08:00 2007 META-INF/maven/log4j/
     0 SatAug 25 00:29:46 GMT+08:00 2007 META-INF/maven/log4j/log4j/
 17780 Sat Aug 25 00:09:44 GMT+08:00 2007META-INF/maven/log4j/log4j/pom.xml
    96 Sat Aug 25 00:29:44GMT+08:00 2007 META-INF/maven/log4j/log4j/pom.properties
```

### 使用javap命令显示jar文件中某个类的公开方法
```
C:\>%JAVA_HOME%\bin\javap -classpath log4j.jarorg.apache.log4j.Appender
Compiled from "Appender.java"
public interface org.apache.log4j.Appender{
    public abstract voidaddFilter(org.apache.log4j.spi.Filter);
    public abstractorg.apache.log4j.spi.Filter getFilter();
    public abstract voidclearFilters();
    public abstract voidclose();
    public abstract voiddoAppend(org.apache.log4j.spi.LoggingEvent);
    public abstractjava.lang.String getName();
    public abstract voidsetErrorHandler(org.apache.log4j.spi.ErrorHandler);
    public abstractorg.apache.log4j.spi.ErrorHandler getErrorHandler();
    public abstract voidsetLayout(org.apache.log4j.Layout);
    public abstractorg.apache.log4j.Layout getLayout();
    public abstract voidsetName(java.lang.String);
    public abstract booleanrequiresLayout();
}
```