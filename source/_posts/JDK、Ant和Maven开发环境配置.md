---
title: 'JDK、Ant和Maven开发环境配置'
date: 2008-12-07 00:00:04
categories: 
- Tool
tags: 
- jdk
- ant
- maven
- 配置
---
### JDK
1. 下载JDK并安装到c:\tools下
2. 设置Java环境变量：JAVA_HOME = c:\tools\Java\jdk1.x.0_xxCLASSPATH =.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;path变量 %JAVA_HOME%\bin
3. 运行"java -version"进行验证

### Ant
1. 下载Ant并解压缩到c:\tools下
2. 设置Ant环境变量：ANT_HOME = c:\tools\apache-ant-1.x.xpath变量 %ANT_HOME%\bin
3. 运行"ant -version"进行验证

### maven
1. 下载Maven并解压缩到c:\tools下
2. 设置Maven环境变量：M2_HOME = c:\tools\apache-maven-x.x.xpath变量 %M2_HOME%\bin
3. 运行"mvn --version"进行验证

### m2eclipse
1. 通过下列update site安装:http://download.eclipse.org/technology/m2e/releases
2. 在Window - Preferences - Maven - Installations添加上一步安装的Maven