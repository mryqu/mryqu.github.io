---
title: '[C++]获取推文生成的SAS时间'
date: 2016-02-19 06:07:14
categories: 
- DataBuilder
- C++
tags: 
- C++
- string
- time
- sas
- tweet
---
写了一个小代码分析推文生成时间字符串，将其解析成SAS时间。
简而言之，time_t存储的是距00:00:00, Jan 1, 1970 UTC的秒数（epoch），其中tm_year存储的是当前年数减去1900；而SAS时间起始点为00:00:00, Jan 1, 1960UTC；转换主要使用difftime获取两者的时间差。
代码如下：![[c++]获取推文生成的SAS时间](/images/2016/2/0026uWfMgy6Zu60JP0Gce.png)

### 参考

[C++: time_t](http://www.cplusplus.com/reference/ctime/time_t/)    
[C++: time](http://www.cplusplus.com/reference/ctime/time/)    
[C++: gmtime](http://www.cplusplus.com/reference/ctime/gmtime/)    