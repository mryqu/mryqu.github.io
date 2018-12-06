---
title: '[GoLang]add proxy for dep'
date: 2017-10-25 06:06:40
categories: 
- Golang
tags: 
- golang
- dep
- proxy
---
玩一下[goquery](https://github.com/PuerkitoBio/goquery)，dep总是报错，无法解析[golang.org/x/net](https://godoc.org/golang.org/x/net)和[cascadia](https://github.com/andybalholm/cascadia)，添加代理后搞定。

#### Windows
```
set https_proxy=http://username:password@[proxy_host]:[proxy_port]
set http_proxy=http://username:password@[proxy_host]:[proxy_port]
dep init -v
```

#### Linux
```
$https_proxy=http://username:password@[proxy_host]:[proxy_port] http_proxy=http://username:password@[proxy_host]:[proxy_port] dep init -v
```
