---
title: '[C++] Compile JsonCpp library using CMake'
date: 2017-03-23 06:14:57
categories: 
- C++
tags: 
- jsoncpp
- cmake
- gcc
- linux
- windows
- C++
---
本文为升级[JsonCpp](https://github.com/open-source-parsers/jsoncpp/)库操作过程的备份笔记。

### Linux/Unix平台

#### 下载[JsonCpp](https://github.com/open-source-parsers/jsoncpp/)
从[JsonCpp releases](https://github.com/open-source-parsers/jsoncpp/releases)页面可知，当前最高版本为1.8.0。
```
wget https://github.com/open-source-parsers/jsoncpp/archive/1.8.0.tar.gz
tar xzvf 1.8.0.tar.gz
cd jsoncpp-1.8.0
mkdir build/release
```
#### 升级gcc
这里我选择使用gcc 5:
```
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install gcc-5 g++-5

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 1
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 1
```
![Linux: gcc version](/images/2017/03/gccVer.png)
#### 升级cmake
[JsonCpp](https://github.com/open-source-parsers/jsoncpp/) 1.8.0要求cmake>=3.1
```
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:george-edison55/cmake-3.x
sudo apt-get update

sudo apt-get upgrade cmake
```
![Linux: cmake version](/images/2017/03/cmakeLinuxVer.png)
#### 编译[JsonCpp](https://github.com/open-source-parsers/jsoncpp/)
```
cmake -DCMAKE_BUILD_TYPE=release -DBUILD_STATIC_LIBS=ON -DBUILD_SHARED_LIBS=OFF -DARCHIVE_INSTALL_DIR=. -G "Unix Makefiles" ../..
make
```
![Linux: build jsoncpp](/images/2017/03/jsoncppLinuxBuild.png)
### Windows平台

#### 准备环境
首先下载[JsonCpp](https://github.com/open-source-parsers/jsoncpp/) 1.8.0源码，并解压缩。我的机器已经部署了VS2013和CMake。
![Windows: cmake version](/images/2017/03/cmakeWinVer.png)
#### 编译[JsonCpp](https://github.com/open-source-parsers/jsoncpp/)
```
cmake -DBUILD_STATIC_LIBS=ON -DBUILD_SHARED_LIBS=OFF -G "Visual Studio 12 2013 Win64" ..
cmake --build . --config Release
```
![Windows: cmake GenBuildFile](/images/2017/03/cmakeWinGenBuildFile.png) ![Windows: build jsoncpp](/images/2017/03/jsoncppWinBuild.png) ![Windows: check lib](/images/2017/03/checkWinJsoncppLib.png)
注：如果编译32位库，则上述过程改用下列命令
```
cmake -DBUILD_STATIC_LIBS=ON -DBUILD_SHARED_LIBS=OFF -G "Visual Studio 12 2013" ..
```

### 参考
* * *
[CMake WiKi](https://cmake.org/Wiki/CMake)  
[CMake command manual](https://cmake.org/cmake/help/v3.2/manual/cmake.1.html)  
[CMake Useful Variables](https://cmake.org/Wiki/CMake_Useful_Variables)  
[g++ man page](https://linux.die.net/man/1/g++)  