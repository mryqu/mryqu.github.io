---
title: '制作JavaSE8的chm版本JavaDoc'
date: 2015-06-25 05:50:57
categories: 
- Tool
tags: 
- javadoc
- chm
- javadoc.chm
- java8
---
### Java8文档
在线版Java8文档: [http://docs.oracle.com/javase/8/docs/](http://docs.oracle.com/javase/8/docs/)
下载版Java文档链接：[http://www.oracle.com/technetwork/java/javase/downloads/index.html#docs](http://www.oracle.com/technetwork/java/javase/downloads/index.html#docs)
- JavaSE6文档下载链接: [http://www.oracle.com/technetwork/java/javase/downloads/jdk-6u25-doc-download-355137.html](http://www.oracle.com/technetwork/java/javase/downloads/jdk-6u25-doc-download-355137.html)
- JavaSE7文档下载链接: [http://www.oracle.com/technetwork/java/javase/documentation/java-se-7-doc-download-435117.html](http://www.oracle.com/technetwork/java/javase/documentation/java-se-7-doc-download-435117.html)
- JavaSE8文档下载链接: [http://www.oracle.com/technetwork/java/javase/documentation/jdk8-doc-downloads-2133158.html](http://www.oracle.com/technetwork/java/javase/documentation/jdk8-doc-downloads-2133158.html)

### 工具
[Github：subchen/javadoc.chm](https://github.com/subchen/javadoc.chm)

### 制作过程

1. 将javadoc.chm-master.zip的javadoc.chm-2.1.0.jar和lib目录解压缩到当前目录
2. 将jdk-8u45-docs-all.zip的docs目录解压缩到当前目录
   ```
   java -Xms256m -Xmx512m -cp javadoc.chm-2.1.0.jar;lib/commons-lang-2.6.jar;lib/commons-io-2.4.jar;lib/commons-collections-3.2.1.jar;lib/commons-logging-1.1.1.jar;lib/log4j-1.2.17.jar;lib/velocity-1.7.jar jerbrick.tools.chm.Application docs/api
   ```
3. 执行docs/api/build.bat生成chm文件
   ![制作JavaSE8的chm版本JavaDoc](/images/2015/6/0026uWfMgy6TmCkplvHb9.jpg)
