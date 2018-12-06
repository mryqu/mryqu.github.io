---
title: '[Git] Git代理配置'
date: 2013-12-01 22:00:58
categories: 
- Tool
- Git
tags: 
- git
- proxy
- configuration
- http
- https
---
### 设置Git的http和https代理

```
git config --global http.proxy http://proxyUser:proxyPwd@proxyServer:proxyPort
git config --global https.proxy https://proxyUser:proxyPwd@proxyServer:proxyPort
```

### 查询Git的http和https代理

```
git config --global --get http.proxy
git config --global --get https.proxy
```

### 移除Git的http和https代理

```
git config --global --unset http.proxy
git config --global --unset https.proxy
```
