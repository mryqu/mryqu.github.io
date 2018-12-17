---
title: '[C++] 编译OpenSSL和libCurl'
date: 2015-03-01 23:05:26
categories: 
- C++
tags: 
- curl
- libcurl
- openssl
- build
- library
---
### 准备工作

登录一台Linux服务器，并完成下列工作：
- 在目录/home/mryqu/创建子目录out，在out目录下创建子目录ssl和curl；
- 从[OpenSSL项目](https://www.openssl.org/source/)下载openssl-1.0.2.tar.gz，并解压；
- 从[curl项目](https://curl.haxx.se/download.html)下载curl-7.40.0.tar.gz，并解压

### 编译OpenSSL

- 进入openssl-1.0.2目录;
- 完成OpenSSL配置，仅支持静态库不支持动态库：
    ```
    ./config no-shared --openssldir=/home/mryqu/out/ssl
    ```
- 对Makefile文件中的FGLAG和DEPFLAG变量进行修改，增加-fPIC。![[C++] 编译OpenSSL和libCurl](/images/2015/3/0026uWfMzy7bGLedy9Q82.jpg)
- 编译：
   ```
   make depend
   make
   make install
   ```

编译产生如下内容：
![[C++] 编译OpenSSL和libCurl](/images/2015/3/0026uWfMzy7bGLgoaR967.png)

### 编译libCurl

- 进入curl-7.40.0目录;
- 首先设定pkg-config路径，指定为上一步OpenSSL编译结果。由于我们的OpenSSL编译结果不在编译器/链接器默认搜索路径，通过pkg-config路径和--with-ssl让libCurl查找到OpenSSL。通过--without-zlib禁止掉即时解压缩。
   ```
   export PKG_CONFIG_PATH=/home/mryqu/out/ssl/lib/pkgconfig
   ./configure --prefix=/home/mryqu/out/curl --with-ssl --without-zlib
   make
   make install
   ```

编译产生如下内容：
![[C++] 编译OpenSSL和libCurl](/images/2015/3/0026uWfMzy7bGLhhT6h09.png)

### 参考

[OpenSSL Compilation and Installation](https://wiki.openssl.org/index.php/Compilation_and_Installation)    
[how to install curl and libcurl](https://curl.haxx.se/docs/install.html)    
[OpenSSL Cookbook](https://www.feistyduck.com/library/openssl-cookbook/online/)    
[Everything curl](https://ec.haxx.se/)    