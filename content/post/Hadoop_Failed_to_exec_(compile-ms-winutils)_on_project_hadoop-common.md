---
title: '[Hadoop] Failed to exec (compile-ms-winutils) on project hadoop-common'
date: 2014-04-15 22:16:23
categories: 
- BigData
tags: 
- hadoop
- vs2013
- winutils
- compile
- windows
---
在Windows平台编译Hadoop时遇到了compile-ms-winutils执行失败的问题。Hadoop默认需要用VS2010编译，但是我的环境只有VS2013。

问题及解决方案如下：
- Cannot run program "msbuild"
  将C:\Windows\Microsoft.NET\Framework\v4.0.30319放入PATH环境变量
- Command execution failed. Process exited with an error: 1(Exitvalue: 1) -> [Help 1]
  打开hadoop-common\hadoop-hdfs-project\hadoop-hdfs\pom.xml，将'VisualStudio 10 Win64'改成'Visual Studio 12 Win64'。
  将如下两个Visual Studio项目用VS2013打开，手动编译。
  - hadoop-common\hadoop-common-project\hadoop-common\src\main\winutils\winutils.sln
  - hadoop-common\hadoop-common-project\hadoop-common\src\main\native\winutils.sln

重新执行：
```
C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools\VsDevCmd.bat
mvn install -DskipTests
```

上述问题不再出现。
