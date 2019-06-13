---
title: '尝试Protocol Buffers支持的各种数据类型'
date: 2013-09-22 22:45:14
categories: 
- Service+JavaEE
tags: 
- protobuf
- protocol
- buffers
- google
- 序列化
---
Protocol Buffers(即protobuf)是Google开源的序列化库，是一种轻便高效的结构化数据存储格式，可以用于结构化数据序列化/反序列化。它很适合做数据存储或RPC的数据交换格式，常用作通信协议、数据存储等领域。
相比于常见的XML格式，ProtocolBuffers官方网站这样描述它的优点：
- 平台无关、语言无关；
- 高性能；
- 体积小；
- 使用简单；
- 兼容性好。

现在尝试一下Protocol Buffers支持的各种数据类型。

#### test.proto

```
package com.yqu.proto;
option java_package = "com.yqu.proto";
option java_outer_classname="TestProtos";

message Test {
  required double   doubleVar   = 1;
  required float    floatVar    = 2;
  required int32    int32Var    = 3;
  required int64    int64Var    = 4;
  required uint32   uint32Var   = 5;
  required uint64   uint64Var   = 6;
  required sint32   sint32Var   = 7;
  required sint64   sint64Var   = 8;
  required fixed32  fixed32Var  = 9;
  required fixed64  fixed64Var  = 10;
  required sfixed32 sfixed32Var = 11;
  required sfixed64 sfixed64Var = 12;
  required bool     booleanVar  = 13;    
  required string   stringVar   = 14;
  required bytes    bytesVar    = 15;
  enum Suit {
    SPADES = 0;
    HEARTS = 1;
    DIAMONDS = 2;
    CLUBS = 3;
  }
  required Suit enumVar = 16 [default = HEARTS];
  repeated int32 int32ArrayVar = 17;
  repeated uint32 uint32ArrayVar = 18 [packed=true];
  repeated string stringArrayVar = 19;
  message MsgVar {
    required string url = 1;
    optional string title = 2;    
  }
  repeated MsgVar msgVar = 20; 
}
```

使用Google提供的Protocol Buffers编译器生成Java语言：
```
protoc -java_ out=. person. proto
```

#### TestProtos.java
![尝试Protocol Buffers支持的各种数据类型](/images/2013/9/0026uWfMzy77GWCHrj8d6.jpg)![尝试Protocol Buffers支持的各种数据类型](/images/2013/9/0026uWfMzy77GWD1aER35.jpg)

### 参考

[Protocol Buffers官网](https://developers.google.com/protocol-buffers/)    