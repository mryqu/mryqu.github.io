---
title: 'twitcurl生成HTTP OAuth头的实现流程'
date: 2015-12-27 06:12:09
categories: 
- DataBuilder
- C++
tags: 
- twitter
- twitcurl
- authorization
- oauth
- signaure
---
对[twitcurl](https://github.com/mryqu/twitcurl)代码做了一些修改，结果遇到了认证失败的错误：
```
{“errors”:[{“message”:”Could not authenticate you”,”code”:32}]}
```
通过继续修改[twitcurl](https://github.com/mryqu/twitcurl)代码改正问题，学习了[twitcurl](https://github.com/mryqu/twitcurl)的认证授权部分代码。其授权部分主要在[oauthlib.h](https://github.com/mryqu/twitcurl/blob/master/libtwitcurl/oauthlib.h)和[oauthlib.cpp](https://github.com/mryqu/twitcurl/blob/master/libtwitcurl/oauthlib.cpp)中的oAuth类实现中。下面主要分析一下oAuth::getOAuthHeader方法。

### 外部数据

Http URL: https://api.twitter.com/1.1/search/tweets.json
Http头参数:

|参数键|参数值
|-----
|q|va
|count|23
|result_type|recent


Http授权参数:

|参数键|参数值
|-----
|oauth_consumer_key|xvz1evFS4wEEPTGEFPHBog
|oauth_signature_method|HMAC-SHA1
|oauth_token|370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb
|oauth_version|1.0


### oAuth::getOAuthHeader方法

- 通过buildOAuthHttpParameterKeyValPairs(params, true,rawKeyValuePairs);对Http头参数中参数值进行百分号编码（URL编码），编码后结果放在哈希表rawKeyValuePairs中
  rawKeyValuePairs:
  <table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><th>键</th><th>值</th></tr><tr><td>q</td><td>va</td></tr><tr><td>count</td><td>23</td></tr><tr><td>result_type</td><td>recent</td></tr></tbody></table>  
- 假定HTTP内容是经过百分号编码的，通过buildOAuthRawDataKeyValPairs( rawData,false, rawKeyValuePairs );找到内容中的键值对，放入哈希表rawKeyValuePairs中
  rawKeyValuePairs:
  <table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><th>键</th><th>值</th></tr><tr><td>q</td><td>va</td></tr><tr><td>count</td><td>23</td></tr><tr><td>result_type</td><td>recent</td></tr></tbody></table>
- 通过buildOAuthTokenKeyValuePairs( includeOAuthVerifierPin,std::string( "" ), rawKeyValuePairs, true );创建认授权证：
  rawKeyValuePairs:
  <table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><th>键</th><th>值</th><th>说明</th></tr><tr><td>q</td><td>va</td><td></td></tr><tr><td>count</td><td>23</td><td></td></tr><tr><td>result_type</td><td>recent</td><td></td></tr><tr><td>oauth_consumer_key</td><td>xvz1evFS4wEEPTGEFPHBog</td><td></td></tr><tr><td>oauth_nonce</td><td>1318622958<span style="line-height: 21px;">19c</span></td><td>twitcurl实现就是时戳项加一个随机数</td></tr><tr><td>oauth_signature_method</td><td>HMAC-SHA1</td><td>固定值</td></tr><tr><td>oauth_timestamp</td><td>1318622958</td><td></td></tr><tr><td>oauth_token</td><td>370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb</td><td></td></tr><tr><td>oauth_version</td><td>1.0</td><td>固定值</td></tr></tbody></table>
- 通过getSignature( eType, pureUrl, rawKeyValuePairs,oauthSignature );获得签名
  - 生成 sigBase：![twitcurl生成HTTP OAuth头的实现流程](/images/2015/12/0026uWfMzy72R7B4EEcec.png)
  - 使用consumer_secret和token_secret组成signing_key，使用HMAC_SHA1算法通过sigBase和signing_key生成摘要strDigest：B6 79 C0 AF 18 F4 E9 C5 87 AB 8E 20 0A CD 4E 48 A9 3F 8C B6(非真实计算而得数据)
  - 通过base64_encode进行编码：tnnArxj06cWHq44gCs1OSKk/jLY= (非真实计算而得数据)
  - 通过百分比编码获得最终签名：![twitcurl生成HTTP OAuth头的实现流程](/images/2015/12/0026uWfMzy72RbbH8DFf3.png) (非真实计算而得数据)
- 通过rawKeyValuePairs.clear();清除OAuth不需要的键值对
- 通过buildOAuthTokenKeyValuePairs( includeOAuthVerifierPin, oauthSignature, rawKeyValuePairs, false );重新创建认授权证：
  rawKeyValuePairs:
  <table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><th>键</th><th>值</th><th>说明</th></tr><tr><td>oauth_consumer_key</td><td>xvz1evFS4wEEPTGEFPHBog</td><td></td></tr><tr><td>oauth_nonce</td><td>131862295819c</td><td>twitcurl实现就是时戳项加一个随机数</td></tr><tr><td>oauth_signature_method</td><td>HMAC-SHA1</td><td>固定值</td></tr><tr><td>oauth_timestamp</td><td>1318622958</td><td></td></tr><tr><td>oauth_token</td><td>370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb</td><td></td></tr><tr><td>oauth_version</td><td>1.0</td><td>固定值</td></tr><tr><td>oauth_signature</td><td><img src="/content/images/2015/12/0026uWfMzy72RbbH8DFf3.png"></td><td></td></tr></tbody></table>
- 最终生成HTTP授权头：![twitcurl生成HTTP OAuth头的实现流程](/images/2015/12/0026uWfMzy72RbQrAEb93.png)

### 参考

[Twitter OAuth Overview](https://dev.twitter.com/oauth/overview)    
[Twitter sign in implementation](https://dev.twitter.com/web/sign-in/implementing)    
[Creating a signature](https://dev.twitter.com/oauth/overview/creating-signatures)    
[Authorizing a Twitter request](https://dev.twitter.com/oauth/overview/authorizing-requests)    
[Percent encoding parameters for Twitter](https://dev.twitter.com/oauth/overview/percent-encoding-parameters)    
[Github: mryqu/twitcurl](https://github.com/mryqu/twitcurl)    