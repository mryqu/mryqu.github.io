---
title: '遭遇“GsonFactory cannot be resolved”'
date: 2015-09-18 05:07:00
categories: 
- Service+JavaEE
tags: 
- gsonfactory
- google
- gson
- httpclient
- gradle
---
遭遇GsonFactory无法解析的错误：
```
...\HelloAnalytics.java:7: error: package com.google.api.client.json.gson does not exist
import com.google.api.client.json.gson.GsonFactory;
                                      ^
...\HelloAnalytics.java:28: error: cannot find symbol
  private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
                                                  ^
  symbol:   variable GsonFactory
  location: class HelloAnalytics
2 errors
:compileJava FAILED
```

解决方案为在_gradle.build_中添加：
```
compile 'com.google.api-client:google-api-client-gson:1.20.0' exclude module: 'httpclient'
```

### 参考

[GsonFactory cannot be found](http://havanko.tumblr.com/post/86680980076/gsonfactory-cannot-be-found)  