---
title: 'Microsoft OneDrive认证和登录'
date: 2016-10-13 05:59:43
categories: 
- DataBuilder
tags: 
- microsoft
- onedrive
- authentication
- sign-in
- application
---
### 为OneDrive注册自己的应用
![Microsoft OneDrive认证和登录](/images/2016/10/0026uWfMzy75C8TOOOcd0.jpg) [Registering your app for OneDrive API](https://dev.onedrive.com/app-registration.htm)里面有提到，平台支持web和移动应用两种，而默认情况下是web应用，需要一或多个跳转URI。对于原生应用，可以选择移动应用。选择移动应用后跳转URI则变成urn:ietf:wg:oauth:2.0:oob（带外认证）了，正是我想要的结果！

### OneDrive认证

[OneDrive authentication and sign-in](https://dev.onedrive.com/auth/msa_oauth.htm)有个按钮可以获得测试Token，无需注册新的应用就可以请求到与登录账户绑定的、一个有效期1小时的开发者Token。从[https://dev.onedrive.com/auth/get-token.js](https://dev.onedrive.com/auth/get-token.js)中我们可以看到其所用的http请求为TokenFlow，其跳转URI设为https://dev.onedrive.com/auth/callback.htm。而 [OneDrive authentication and sign-in](https://dev.onedrive.com/auth/msa_oauth.htm) 中提到对于移动应用和桌面应用，跳转URI应设为**https://login.live.com/oauth20_desktop.srf** **（注：使用urn:ietf:wg:oauth:2.0:oob的话，MSA连响应都没有）。**

#### Token Flow测试
HTTP GET请求如下：
```
https://login.live.com/oauth20_authorize.srf?client_id=b9aaf3be-6892-42a5-8a04-4a87bc28ce7b&scope=onedrive.readonly+wl.signin&response_type=code&redirect_uri=https://login.live.com/oauth20_desktop.srf
```
响应如下，认证失败：
```
https://login.live.com/oauth20_desktop.srf?lc=1033#error=unsupported_response_type&error_description=The+provided+value+for+the+input+parameter+'response_type'+is+not+allowed+for+this+client.+Expected+value+is+'code'.
```
找了很久微软的帖子，也没说为什么Token Flow不要使，一直纠结是微软不支持还是我配置有问题。后来，看了[RFC6749 The OAuth 2.0 Authorization Framework](https://tools.ietf.org/html/rfc6749#section-4.2)，才明白Token Flow就是规范里的Implicit GrantFlow。如果我的应用配置为web应用，是可以看到Allow ImplicitFlow选择框的。好吧，当选择移动应用时微软不支持Token Flow，我的配置没问题！！！![Microsoft OneDrive认证和登录](/images/2016/10/0026uWfMzy75GMNBbS830.jpg)

#### Code Flow测试
- 用于用户登录的HTTP GET请求如下：
  ```
  https://login.live.com/oauth20_authorize.srf?client_id=b9aaf3be-6892-42a5-8a04-4a87bc28ce7b&scope=onedrive.readonly+wl.signin&response_type=token&redirect_uri=https://login.live.com/oauth20_desktop.srf
  ```
  ![Microsoft OneDrive认证和登录](/images/2016/10/0026uWfMzy75GLiDZur5b.jpg)请求用户授权：![Microsoft OneDrive认证和登录](/images/2016/10/0026uWfMzy75GLj08sE60.jpg)此时浏览器上地址变为：
  ```
  https://account.live.com/Consent/Update?ru=https://login.live.com/oauth20_authorize.srf?lc=1033&client_id=b9aaf3be-6892-42a5-8a04-4a87bc28ce7b&scope=onedrive.readonly+wl.signin&response_type=code&redirect_uri=https://login.live.com/oauth20_desktop.srf&uaid=78...e6&pid=...16&mkt=EN-US&scft=DSA...hfC&contextid=7F...D6&mkt=EN-US&uiflavor=host&id=27...69&uaid=78...e6&client_id=00...42&rd=none&scope=&cscope=onedrive.readonly+wl.signin
  ```
- 最终跳转的地址包含了code参数：![Microsoft OneDrive认证和登录](/images/2016/10/0026uWfMzy75GLjexhua0.jpg)
- 获取访问令牌的HTTP POST请求包含上面获得的code参数：
  ```
  POST https://login.live.com/oauth20_token.srf
  Content-Type: application/x-www-form-urlencoded
  client_id=b9aaf3be-6892-42a5-8a04-4a87bc28ce7b&redirect_uri=https://login.live.com/oauth20_desktop.srf&code=M9...5e-b...a-e...5-6685-d...06&grant_type=authorization_code
  ```
  ![Microsoft OneDrive认证和登录](/images/2016/10/0026uWfMzy75GLk1IGi46.jpg)
- 在OneDrive API中使用获得的访问令牌：![Microsoft OneDrive认证和登录](/images/2016/10/0026uWfMzy75GLki16B6d.jpg)

### 参考

[Getting started with OneDrive API](https://dev.onedrive.com/getting-started.htm)    
[SDKs for OneDrive integration](https://dev.onedrive.com/SDKs.htm)    
[Registering your app for OneDrive API](https://dev.onedrive.com/app-registration.htm)    
[OneDrive authentication and sign-in](https://dev.onedrive.com/auth/msa_oauth.htm)    
[Sign-in Microsoft Account &amp; Azure AD users in a single app](https://azure.microsoft.com/en-us/documentation/articles/active-directory-appmodel-v2-overview/)    
[Develop with the OneDrive API](https://dev.onedrive.com/README.htm)    
[getting #error=unsupported_response_type&amp;error_description=AADSTS70005: with token request](http://stackoverflow.com/questions/25511096/getting-error-unsupported-response-typeerror-description-aadsts70005-with-tok)    