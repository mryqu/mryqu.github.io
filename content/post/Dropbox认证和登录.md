---
title: 'Dropbox认证和登录'
date: 2016-10-03 05:44:29
categories: 
- DataBuilder
tags: 
- dropbox
- authentication
- oauth2
- application
- sign-in
---
### 为Dropbox申请自己的应用

![Dropbox认证和登录](/images/2016/10/0026uWfMzy75TeB4RP0de.jpg) [Dropbox OAuth Guide](https:///developers/reference/oauth-guide)提到：对于命令行或桌面应用，没办法让浏览器重定向回你的应用。这种情况下，你的应用无需包含redirect_uri参数。Dropbox将向用户显示认证码，以用于复制到你的应用来获得可重用的访问令牌。基于此，对于桌面应用，redirect_uri不用设置；对于web应用，我选择了http://localhost以便测试。Dropbox网站没有提及urn:ietf:wg:oauth:2.0:oob。
![Dropbox认证和登录](/images/2016/10/0026uWfMzy75TghEHYu62.jpg)![Dropbox认证和登录](/images/2016/10/0026uWfMzy75TeClvhP05.jpg)

### Dropbox认证

#### Token Flow测试
HTTP GET请求如下：
```
https://www.dropbox.com/oauth2/authorize?client_id=**3t...hi**&redirect_uri=http://localhost&response_type=token&state=dsxoekdmpyt
```
成功跳转到如下URI：
```
http://localhost/#access_token=
```
连App secret都不用，仅凭App Key就可以获得访问令牌！看来还是认证码方式更安全一些。最后把应用的Allowimplicit grant选项改成Disallow以确保安全。

#### Code Flow测试

HTTP GET请求如下：
```
https://www.dropbox.com/oauth2/authorize?client_id=3t...hi&response_type=code&state=wecidskklsxpxl123
```
请求用户授权：![Dropbox认证和登录](/images/2016/10/0026uWfMzy75ThTu23m78.jpg)
显示认证码：![Dropbox认证和登录](/images/2016/10/0026uWfMzy75Ti324NW48.jpg)
获取访问令牌的HTTP POST请求包含上面获得的code参数：
```
POST https://api.dropboxapi.com/1/oauth2/token
Content-Type: application/x-www-form-urlencoded
Cache-Control: no-cache

code=oV...9I&amp;client_id=3t...hi&amp;client_secret=j...7&amp;grant_type=authorization_code
```
![Dropbox认证和登录](/images/2016/10/0026uWfMzy75ThUOJkVd5.jpg)

### 参考

[Dropbox API](https://www.dropbox.com/developers)   
[Dropbox OAuth Guide](https://www.dropbox.com/developers/reference/oauth-guide)    
[Dropbox authorize API](https://www.dropbox.com/developers-v1/core/docs#oa2-authorize)    
[Dropbox token API](https://www.dropbox.com/developers-v1/core/docs#oa2-token)    