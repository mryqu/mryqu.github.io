---
title: 'Hello Android!'
date: 2014-01-25 12:31:21
categories: 
- Tech
tags: 
- android
- coursera
- homework
- adt
- emulator
---
第一次再简陋总比不做强！
![Hello Android!](/images/2014/1/0026uWfMgy6G3ZAFBsb7f.jpg)

-----

# ADT安装

不经常装ADT （Android development tool），第二次装又犯晕了。
ADT要跟JDK平台一致：
- 对应32位JDK的adt-bundle-windows-x86-20131030.zip
- 对应64位JDK的adt-bundle-windows-x86_64-20131030.zip

JDK装好久了，不知道是32位还是64位的了，可以跑一下下面的代码：
```
public class JdkPlatformTest {
  public static voidmain(String[] args) {
   String arch =System.getProperty("sun.arch.data.model");  
   System.out.println(arch+"-bit");
  }
}
```

此外Windows平台可以通过下列命令获取：`wmic os get osarchitecture`

-----

# Android虚拟设备仿真器操作命令

http://developer.android.com/tools/devices/emulator.html  
