---
title: 'Use proxy on Google Analytics API'
date: 2015-10-09 05:34:55
categories: 
- DataBuilder
tags: 
- google
- analytics
- api
- proxy
- httptransport
---
使用Google API创建HTTP传输层是这样子的，没有可以传入代理的地方。
```
HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
```

仔细研究一下com.google.api.client.googleapis.javanet.GoogleNetHttpTransport，发现其实现是使用com.google.api.client.http.javanet.NetHttpTransport.Builder生成一个com.google.api.client.http.javanet.NetHttpTransport对象。![Use proxy on Google Analytics API](/images/2015/10/0026uWfMzy74cHklZvwce.jpg)

com.google.api.client.http.javanet.NetHttpTransport.Builder和com.google.api.client.http.javanet.NetHttpTransport是都支持代理的。不用GoogleNetHttpTransport这个封装，直接对com.google.api.client.http.javanet.NetHttpTransport.Builder设置代理即可生成使用代理的HttpTransport对象。
```
Proxy proxy = new Proxy(Proxy.Type.HTTP, new InetSocketAddress("XXXX", 80));
HttpTransport httpTransport = new NetHttpTransport.Builder().setProxy(proxy).
    trustCertificates(GoogleUtils.getCertificateTrustStore()).build();
```
