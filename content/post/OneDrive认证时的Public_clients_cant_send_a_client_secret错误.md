---
title: OneDrive认证时的"Public clients can't send a client secret."错误
date: 2016-10-14 05:40:38
categories: 
- DataBuilder
tags: 
- onedrive
- authentication
- public
- client
- secret
---
在进行[Microsoft OneDrive认证和登录](/post/microsoft_onedrive认证和登录)实验的过程中，曾经用下列命令过去访问令牌：
```
POST https://login.live.com/oauth20_token.srf
Content-Type: application/x-www-form-urlencoded

client_id={client_id}&redirect_uri=https://login.live.com/oauth20_desktop.srf&client_secret={client_secret}
&code={code}&grant_type=authorization_code
```

结果返回：
```
{"error":"invalid_request","error_description":"Public clients can't send a client secret."}
```
一个"public client"指的是移动或桌面应用(web服务则是"confidentialclient")。由于跳转URI是https://login.live.com/oauth20_desktop.srf，因而MSA返回该错误响应。这种情况下，不应该提供client_secret，使用下列请求即可。
```
POST https://login.live.com/oauth20_token.srf
Content-Type: application/x-www-form-urlencoded

client_id={client_id}&redirect_uri=https://login.live.com/oauth20_desktop.srf&code={code}&grant_type=authorization_code
```
