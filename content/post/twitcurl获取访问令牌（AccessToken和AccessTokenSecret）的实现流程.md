---
title: 'twitcurl获取访问令牌（AccessToken和AccessTokenSecret）的实现流程'
date: 2016-07-01 05:34:09
categories: 
- DataBuilder
tags: 
- twitcurl
- twitter
- oauth
- requesttoken
- accesstoken
---
[twitterClient.cpp](https://github.com/mryqu/twitcurl/blob/master/twitterClient/twitterClient.cpp)中有一段代码是没有AccessToken和AccessTokenSecret的情况下，通过ConsumerKey、ConsumerKeySecret、UserName和UaserPassword获取AccessToken和AccessTokenSecret。
一般实现是通过重定向到Twitter页面去授权应用，通过callbackURL获得Twitter传过来的AccessToken和AccessTokenSecret信息。twitcurl既可以通过访问twitter.com获取PIN，也可以交由twitcurl自动获得。
如果通过twitter.com处理PIN，twitcurl会提供授权链接。进入链接后输入用户名和密码，会重定向到Twitter应用的callbackURL（例如http://www.mryqu.com/test.html?oauth_token={OAuthToken}&oauth_verifier={OAuthVerifier} ），其中oauth_verifier值即为所谓的PIN。
下面我们看一下[twitcurl](https://github.com/mryqu/twitcurl)是如何实现不访问twitter.com获取AccessToken和AccessTokenSecret的。
- GET https://api.twitter.com/oauth/request_tokentwitCurl::oAuthRequestToken 方法实现该HTTP请求，允许消费者应用获得一个OAuth请求令牌以请求用户授权。除了HTTP OAuth头外，[twitcurl](https://github.com/mryqu/twitcurl)实现没有其他HTTP头，也没有消息体内容。HTTP OAuth头包含如下项：
  - oauth_consumer_key
  - oauth_nonce
  - oauth_signature
  - oauth_signature_method
  - oauth_timestamp
  - oauth_version
 
 通过如下HTTP响应可以获得oauth_token和oauth_token_secret，保存在oAuth对象的m_oAuthTokenKey和m_oAuthTokenSecret变量中：
 ```
 oauth_token=XXXXXX&oauth_token_secret=XXXXXX&oauth_callback_confirmed=true
 ```
- GET https://api.twitter.com/oauth/authorize?oauth_token=XXXXXXtwitterObj.oAuthHandlePIN 方法实现该HTTP请求，获取响应页面中表单的authenticity_token和oauth_token元素的值。除了HTTP OAuth头外，[twitcurl](https://github.com/mryqu/twitcurl)实现没有其他HTTP头，也没有消息体内容。HTTP OAuth头包含如下项：
  - oauth_consumer_key
  - oauth_nonce
  - oauth_signature
  - oauth_signature_method
  - oauth_timestamp
  - oauth_token （**取自上一HTTP响应**）
  - oauth_version
  
 HTTP响应片段：![twitcurl获取访问令牌（AccessToken和AccessTokenSecret）的实现流程](/images/2016/7/0026uWfMzy72Utunz5b55.jpg)
- POST https://api.twitter.com/oauth/authorize?oauth_token=XXXXXXtwitterObj.oAuthHandlePIN 方法实现该HTTP请求，允许消费者应用使用OAuth请求令牌请求用户授权。HTTP OAuth头包含如下项：
  - oauth_consumer_key
  - oauth_nonce
  - oauth_signature
  - oauth_signature_method
  - oauth_timestamp
  - oauth_token （**取自上一HTTP响应**）
  - oauth_version

 HTTP请求消息体内容为：
 ```
 oauth_token=XXXXXX&authenticity_token=XXXXXX&session[username_or_email]=**XXXXX**X&session[password]=XXXXXX
 ```
 HTTP响应片段：![twitcurl获取访问令牌（AccessToken和AccessTokenSecret）的实现流程](/images/2016/7/0026uWfMzy72Uw46dlc66.png)通过如下HTTP响应可以获得oauth_verifier，保存在oAuth对象的m_oAuthPin变量中。
- GET https://api.twitter.com/oauth/access_tokentwitterObj.oAuthAccessToken 方法实现该HTTP请求，允许消费者应用使用OAuth请求令牌交换OAuth访问令牌。HTTP OAuth头包含如下项：
  - oauth_consumer_key
  - oauth_nonce
  - oauth_signature
  - oauth_signature_method
  - oauth_timestamp
  - oauth_token
  - oauth_verifier （**取自上一HTTP响应**）
  - oauth_version

 HTTP响应：
 ```
 oauth_token=XXXXXX&oauth_token_secret=XXXXXX&user_id=XXXXXX&screen_name=XXXXXX&x_auth_expires=0
 ```
 通过HTTP响应可以获得oauth_token、oauth_token_secret和user_id，保存在oAuth对象的m_oAuthTokenKey、m_oAuthTokenSecret和m_oAuthScreenName变量中，可以将此OAuth访问令牌保存下来以备之后的使用，下次就无需再次申请访问令牌了。

### 参考

[Twitter OAuth Overview](https://dev.twitter.com/oauth/overview)    
[Twitter PIN-based authorization](https://dev.twitter.com/oauth/pin-based)    
[Github: mryqu/twitcurl](https://github.com/mryqu/twitcurl)    
[OAuth Core 1.0](http://oauth.net/core/1.0/)    
[Twitter：POST oauth/request_token](https://dev.twitter.com/oauth/reference/post/oauth/request_token)    
[Twitter：GET oauth/authorize](https://dev.twitter.com/oauth/reference/get/oauth/authorize)    
[Twitter：POST oauth/access_token](https://dev.twitter.com/oauth/reference/post/oauth/access_token)    
[twitcurl生成HTTP OAuth头的实现流程](/post/twitcurl生成http_oauth头的实现流程)    
[twitter4j/auth/OAuthAuthorization.java](https://github.com/yusuke/twitter4j/blob/master/twitter4j-core/src/main/java/twitter4j/auth/OAuthAuthorization.java)    