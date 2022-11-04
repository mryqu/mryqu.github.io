---
title: '获取Facebook App Token'
date: 2015-10-08 06:06:04
categories: 
- DataBuilder
tags: 
- facebook
- appid
- appsecret
- apptoken
- client_credentials
---
今天看了一下如何用Facebook的App Id和App Secret获取App Token。

可以使用RestFB，一行搞定：
```
FacebookClient.AccessToken ac = new DefaultFacebookClient(Version.LATEST)
    .obtainAppAccessToken(appId, appSecret);
```

curl命令也超简单：
```
curl "https://graph.facebook.com/v2.5/oauth/access_token?client_id={appId}&client_secret={appSecret}&grant_type=client_credentials"
```

我的一个Facebook应用YquTest如下：
![获取Facebook App Token](/images/2015/10/0026uWfMzy73W7olg5u8c.jpg)
通过其App Id和App Secret进行实验，获得结果可以用上一篇博文[Facebook开发调试工具](/post/facebook开发调试工具)提到的访问口令工具验证，完全一致！

### 参考

[Facebook Login - Access Tokens](https://developers.facebook.com/docs/facebook-login/access-tokens)  
[Facebook Login - Access Tokens - App Access Tokens](https://developers.facebook.com/docs/facebook-login/access-tokens#apptokens)  