---
title: '在Google API中使用访问令牌的三种方式'
date: 2016-09-29 05:33:08
categories: 
- DataBuilder
tags: 
- google
- api
- access_token
- oauth
- bearer
---
在[Google Developers OAuth 2.0 playground](https://developers.google.com/oauthplayground/) 中设置OAuth2.0配置时，可以发现有一个访问令牌位置的选择框，其值为：
- Authorization header w/ OAuth prefix
- Authorization header w/ Bearer prefix
- Access_token URL parameter

![在Google API中使用访问令牌的三种方式](/images/2016/9/0026uWfMzy75LCfGsYX53.png) 按照前面博文《[Google Sheets API认证和鉴权](/post/google_sheets_api认证和鉴权) 》中的方法生成一个访问令牌。下面我就用这个访问令牌对这三种使用方式进行一下尝试。

#### 认证头使用OAuth前缀
![在Google API中使用访问令牌的三种方式](/images/2016/9/0026uWfMzy75LEiCVeB9d.jpg)
#### 认证头使用Bearer前缀
![在Google API中使用访问令牌的三种方式](/images/2016/9/0026uWfMzy75LElsbAmaa.jpg)
#### 使用access_token URL参数
![在Google API中使用访问令牌的三种方式](/images/2016/9/0026uWfMzy75LEnBxgaf6.jpg)
结论：这三种访问令牌位置的使用都工作正常，API结果相同！
