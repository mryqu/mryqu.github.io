---
title: 'Facebook的Page Access Token'
date: 2018-10-30 06:31:53
categories: 
- DataBuilder
tags: 
- facebook
- page
- access token
---
忽然发现原本可用的Facebook App Access Token无法获取Page内容的，甚至是自己的主页，错误提示为：
> "(#10) To use 'Page Public Content Access', your use of this endpoint must be reviewed and approved by Facebook. To submit this 'Page Public Content Access' feature for review please read our documentation on reviewable features: https://developers.facebook.com/docs/apps/review."。

注：我的App yquTest当前App版本为2.8。![failedAppAccessToken](/images/2018/10/failedAppAccessToken.png) 
祭出Access Token Tool武器，开始实验User Access Token。
![FacebookAccessTokenTool](/images/2018/10/FacebookAccessTokenTool.png)
发现结果如下：
- 使用Facebook App Access Token无法读取自己或他人的主页内容
- 使用Facebook User Access Token可以读取自己主页内容，但无法读取他人的主页内容

### Facebook Page Access Token调查  

#### 获取自己多个主页的Page Access Toke  

![MutliPageAccessToken](/images/2018/10/MutliPageAccessToken.png)

#### 获取自己单个主页的Page Access Toke  

![SinglePageAccessToken](/images/2018/10/SinglePageAccessToken.png)

#### 使用Page Access Token获取自己的主页内容  

![UsePageAccessToken](/images/2018/10/UsePageAccessToken.png)

#### 尝试获取他人主页的Page Access Token  

![NeedPagePublicContentAccessFeature](/images/2018/10/NeedPagePublicContentAccessFeature.png)
结果自然是嘿嘿嘿。

#### 结论  

还是赶紧向Facebook提交并通过使用Page Public Content Access特性的评审吧。

-----

###参考

[Page Access Tokens, Permissions, and Roles](https://developers.facebook.com/docs/facebook-login/access-tokens/)



