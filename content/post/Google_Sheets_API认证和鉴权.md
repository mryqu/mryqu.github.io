---
title: 'Google Sheets API认证和鉴权'
date: 2016-09-27 05:44:22
categories: 
- DataBuilder
tags: 
- google
- sheets
- api
- oauth2
- authorization
---
玩一把用于Google Sheets API的OAuth2认证，以获得用于Sheets API的访问令牌。

### 注册Google Sheets应用

首先在[Google API Console](https://console.developers.google.com/)注册一个应用：
![Google Sheets API认证和鉴权](/images/2016/9/0026uWfMzy75Irl45GHbb.jpg)![Google Sheets API认证和鉴权](/images/2016/9/0026uWfMzy75IrlBfUS4a.jpg)
### Google Sheets API鉴权

- 用于用户登录的HTTPGET请求如下（scope选择了profile、对文件元数据和内容只读访问、对表单和属性只读访问）：
  ```
  GET https://accounts.google.com/o/oauth2/v2/auth?
  scope=https://www.googleapis.com/auth/spreadsheets.readonly https://www.googleapis.com/auth/drive.readonly profile&
  redirect_uri=urn:ietf:wg:oauth:2.0:oob&
  response_type=code&
  client_id=826380598768-5935tlo90sccvr691ofmp4nrvpthrnn6.apps.googleusercontent.com
  ```
  首先要求用户登录：![Google Sheets API认证和鉴权](/images/2016/9/0026uWfMzy75Irc6eVWf0.jpg)要求登录后用户的授权：![Google Sheets API认证和鉴权](/images/2016/9/0026uWfMzy75IrchpgWd6.jpg)返回页面包含授权码：![Google Sheets API认证和鉴权](/images/2016/9/0026uWfMzy75IrcpBpCe0.jpg)
- 获取访问令牌的HTTPPOST请求包含上面获得的授权码（在创建Google应用时获得的client_id和client_secret）：
  ```
  POST https://www.googleapis.com/oauth2/v4/token
  Content-Type: application/x-www-form-urlencoded

  code=4/-qpp...qA&
  client_id=826380598768-5935tlo90sccvr691ofmp4nrvpthrnn6.apps.googleusercontent.com&
  client_secret=5...r&
  redirect_uri=urn:ietf:wg:oauth:2.0:oob&
  grant_type=authorization_code
  ```
  ![Google Sheets API认证和鉴权](/images/2016/9/0026uWfMzy75IrczJmDf7.jpg)

### 参考

[Google Sheets](https://docs.google.com/spreadsheets/)    
[Google Sheets API](https://developers.google.com/sheets/)    
[Authorize Google Sheets API Requests](https://developers.google.com/sheets/guides/authorizing)    
[Using OAuth 2.0 for Mobile and Desktop Applications](https://developers.google.com/identity/protocols/OAuth2InstalledApp)    
[Using OAuth 2.0 for Web Server Applications](https://developers.google.com/identity/protocols/OAuth2WebServer)    