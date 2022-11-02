---
title: '[Hadoop] Windows平台编译Hadoop2.6.0笔记'
date: 2015-04-02 05:25:54
categories: 
- BigData
tags: 
- windows
- hadoop
- 2.6.0
- build
---
### 环境

64位虚拟机及64位 Windows Server 2008 R2

### 所需工具

- JDK7
- [Maven](http://maven.apache.org/download.cgi)
- [.NET Framework 4](http://www.microsoft.com/en-us/download/details.aspx?id=17851)
- [Microsoft Windows SDK 7.1](http://www.microsoft.com/en-in/download/confirmation.aspx?id=8279)
  **安装前一定要先卸载比Microsoft Visual C++ 2010 x86Redistributable - 10.0.30319 更高的版本。**
- [Microsoft Visual C++ 2010 Service Pack 1 Compiler Update for the Windows SDK 7.1](https://www.microsoft.com/en-us/download/details.aspx?id=4422)
- [Cygwin (x64)](http://cygwin.com/install.html)
- [Protocol Buffers 2.5.0](http://protobuf.googlecode.com/files/protoc-2.5.0-win32.zip)
- [CMake 3.2.1](http://www.cmake.org/files/v3.2/cmake-3.2.1-win32-x86.exe)
  **安装时选择添加CMake到所有用户的PATH环境变量。**
- [hadoop-2.6.0源文件压缩包](http://mirror.cc.columbia.edu/pub/software/apache/hadoop/common/hadoop-2.6.0/hadoop-2.6.0-src.tar.gz)
  解压至c:\hadoop-2.6.0-src
  
### 编译Hadoop2.6.0

1. 进入Windows SDK 7.1 Command Prompt
2. 在c:\执行buildHadoop.bat，其内容如下：
    ```
    setlocal
    
    set Platform=x64
    set CYGWIN_ROOT=C:\cygwin64
    set JAVA_HOME=C:\tools\Java\jdk7
    set M2_HOME=C:\tools\apache-maven
    set MS_BUILD_PATH=C:\Windows\Microsoft.NET\Framework64\v4.0.30319
    set MS_SDK=C:\Program Files\Microsoft SDKs\Windows\v7.1
    set CMAKE_PATH=C:\tools\CMake
    set PROTOBUF_PATH=C:\tools\protoc-2.5.0-win32
    set PATH=%PROTOBUF_PATH%;%CMAKE_PATH%\bin;%MS_BUILD_PATH%;%MS_SDK%\bin\;%MS_SDK%\Include\;%M2_HOME%\bin;%CYGWIN_ROOT%\bin;%PATH%
    set HADOOP_SRC=hadoop-2.6.0-src
    pushd hadoop-2.6.0-src
    attrib * -R /S
    icacls * /grant Everyone:(OI)(CI)F
    set log=..\mvn.log
    mvn package -Pdist,native-win -DskipTests -Dtar -e -X >> %log% 2>&1
    popd
    ```
    
![[Hadoop] Windows平台编译Hadoop2.6.0笔记](/images/2015/4/0026uWfMzy73aud4HGTff.png)
编译结果：
- C:\hadoop-2.6.0-src\hadoop-dist\target/hadoop-2.6.0.tar.gz
- C:\hadoop-2.6.0-src\hadoop-dist\target\hadoop-dist-2.6.0-javadoc.jar

### 解决故障

#### 缺ammintrin.h文件
```
c:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\include\intrin.h(26): fatal error C1083: Cannot open include file: 'ammintrin.h': No such file or directory [C:\hadoop-2.6.0-src\hadoop-common-project\hadoop-common\src\main\native\native.vcxproj]
```

解决方法：
将此[ammintrin.m](https://www.mathworks.com/matlabcentral/answers/uploaded_files/735/ammintrin.m)下载改名为ammintrin.h，置于C:\ProgramFiles (x86)\Microsoft Visual Studio 10.0\VC\INCLUDE\目录下。

### 参考

[Hadoop 2.6.0 Installation Guide (Windows)](https://drive.google.com/file/d/0BweVwq32koypYm1QWHNvRTZWTm8/view)    
[Yet Another Hadoop Build Tutorial for Windows](http://qamichaelpeng.github.io/2015/01/15/hadoop_build.html)    
[Build instructions for Hadoop](https://svn.apache.org/repos/asf/hadoop/common/trunk/BUILDING.txt)    
[Fix problem when mex .cpp file](https://www.mathworks.com/matlabcentral/answers/90383-fix-problem-when-mex-cpp-file?requestedDomain=www.mathworks.com)    
[](http://stackoverflow.com/questions/30485525/missing-ammintrin-h-when-compiling-hadoop-on-windows)    