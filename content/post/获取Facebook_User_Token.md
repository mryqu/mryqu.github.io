---
title: '获取Facebook User Token'
date: 2016-08-09 05:25:47
categories: 
- DataBuilder
tags: 
- facebook
- user
- token
- curl
- 分析
---
使用Facebook Graph API搜索主页数据，可以用App Token也可以用User Token。
[获取Facebook App Token](/post/获取facebook_app_token)一贴中已经介绍了如何获取Facebook App Token，这里就介绍一下如何获取UserToken。

参考3 [Facebook Login - Advance - Manually Build a Login Flow](https://developers.facebook.com/docs/facebook-login/manually-build-a-login-flow)给出了如何构建一个signURL，RestFB的getLoginDialogUrl方法就实现了这样的功能。redirectUri一开始直接想用带外认证urn:ietf:wg:oauth:2.0:oob，可是Facebook不认呀。
![获取Facebook User Token](/images/2016/8/0026uWfMzy73WsVvBVv99.jpg)[Facebook Login - Advance - Manually Build a Login Flow](https://developers.facebook.com/docs/facebook-login/manually-build-a-login-flow)已经提到了：对于桌面应用，redirectUri必须是https://www.facebook.com/connect/login_success.html 。

### 获取Facebook User Token步骤

#### 生成signURL
生成signURL并进行Get请求：
```
curl "https://www.facebook.com/dialog/oauth?client_id={appId}&redirect_uri=https://www.facebook.com/connect/login_success.html&response_type=token&scope=public_profile"
```
可以从返回的页面中获取登录表单：![获取Facebook User Token](/images/2016/8/0026uWfMzy73XyEhrcD73.jpg)
#### 认证
使用自己的Facebook账户和密码填充上一表单，使用Post请求进行认证：
```
curl -X POST "{form-action}" -H "Content-Type: application/x-www-form-urlencoded" --data "lsd={lsd_value}&api_key={api_key_value}&cancel_url={cancel_rul_value}&isprivate={isprivate=_value}&legacy_return={legacy_return_value}&profile_selector_ids={profile_selector_ids_value}&return_session={return_session_value}&skip_api_login={skip_api_login_value}&signed_next={skip_api_login_value}&trynum={trynum_value}&timezone={timezone_value}&lgndim={lgndim_value}&lgnrnd={lgnrnd_value}&lgnjs={lgnjs_value}&email={your_facebook_account}&pass={your_facebook_password}&login={login_value}&persistent={persistent_value}&default_persistent={default_persistent_value}"
```

#### 获取User Token
Facebook通过认证后返回302响应，其Location头是下面这个样子的，很好获取（也可以参考一下RestFB的fromQueryString函数实现）。
```
https://www.facebook.com/connect/login_success.html#access_token={userToken}&expires_in={expire}
```

### 参考

[Facebook Login - Access Tokens](https://developers.facebook.com/docs/facebook-login/access-tokens)    
[Facebook Login - Access Tokens - App Access Tokens](https://developers.facebook.com/docs/facebook-login/access-tokens#apptokens)    
[Facebook Login - Advance - Manually Build a Login Flow](https://developers.facebook.com/docs/facebook-login/manually-build-a-login-flow)    
[RestFB： GET LOGIN DIALOG URL](http://restfb.com/documentation/#access-token-dialog)    
[RestFB： EXTENDING AN ACCESS TOKEN](http://restfb.com/documentation/#access-token-extend)    
[Facebook Dialog OAuth Tutorial](http://hayageek.com/facebook-dialog-oauth/)    