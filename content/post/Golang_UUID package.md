---
title: '[Golang] UUID包'
date: 2017-10-17 15:12:12
categories: 
- Golang
tags: 
- golang
- uuid
- package
- rfc4122
---
最早Google的Go UUID包位于[https://code.google.com/archive/p/go-uuid/](https://code.google.com/archive/p/go-uuid/) ，后来移到了[https://github.com/pborman/uuid](https://github.com/pborman/uuid) 。而[https://github.com/google/uuid](https://github.com/google/uuid) 是基于pborman版的，区别于之前的实现在于用16字节数组取代了字节切片，缺点是无法表示无效UUID。上述UUID包采用BSD 3-Clause许可协议。 
此外还有采用MIT协议的[https://github.com/satori/go.uuid](https://github.com/satori/go.uuid) ，它支持UUID版本1-5，与RFC 4122和DCE 1.1兼容。通过https://golanglibs.com/top?q=uuid 可以看出，它是GitHub点星(star)最多的UUID包，远远超过了Google的。