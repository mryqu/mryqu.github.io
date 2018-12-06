---
title: '[Hadoop] 安装protobuf'
date: 2013-09-21 16:23:17
categories: 
- Hadoop/Spark
- Hadoop
tags: 
- hadoop
- protobuf
- 安装
---
Protocol Buffers (即protobuf)是Google的语言无关、平台无关、结构数据序列化的可扩展机制。
在Window平台编译Hadoop需要protobuf，下载所需的[protoc-2.5.0-win32.zip](https://github.com/google/protobuf/releases/download/v2.5.0/protoc-2.5.0-win32.zip)，将protoc.exe复制到某目录，加入PATH变量即可。

### 参考

[Hadoop WIKI: How to Contribute to Hadoop](http://wiki.apache.org/hadoop/HowToContribute)    
[Hadoop WIKI: ProtocolBuffers](http://wiki.apache.org/hadoop/ProtocolBuffers)    
[protobuf releases](https://github.com/google/protobuf/releases)    
[GitHub: google/protobuf](https://github.com/google/protobuf)    
[protobuf documents](https://developers.google.com/protocol-buffers/)    