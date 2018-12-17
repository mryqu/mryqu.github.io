---
title: '解决"Access Not Configured. The API (YouTube Analytics API) is not enabled for your project."'
date: 2015-10-16 06:32:52
categories: 
- DataBuilder
tags: 
- youtube
- analytics
- usagelimits
- accessnotconfigured
- 403
---
在用Google Developers OAuth 2.0 Playground试用Google YoutubeAnalytics API时总是返回下列403 Forbidden错误:
```
{
  "code" : 403,
  "errors" : [ {
    "domain" : "usageLimits",
    "message" : "Access Not Configured. The API (YouTube Analytics API) is not enabled for your project. Please use the Google Developers Console to update your configuration.",
    "reason" : "accessNotConfigured",
    "extendedHelp" : "https://console.developers.google.com"
  } ],
  "message" : "Access Not Configured. The API (YouTube Analytics API) is not enabled for your project. Please use the Google Developers Console to update your configuration."
}
```

在https://console.developers.google.com查看我的项目，各种可能需要的API都激活了：
- **Analytics API**
- BigQuery API
- Cloud Debugger API
- **Contacts API**
- Debuglet Controller API
- Google Cloud Logging API
- Google Cloud SQL
- Google Cloud Storage
- Google Cloud Storage JSON API
- **Google+ API**
- Google+ Domains API
- **YouTube Analytics API**
- **YouTube Data API v3**
- **YouTube Reporting API**

![解决 "Access Not Configured. The API (YouTube Analytics API) is not enabled for your project."](/images/2015/10/0026uWfMgy6WlX2y3p711.jpg)

最后的解决过程如下：
- 创建一个web应用证书，关键是其redirectURI为**https://developers.google.com/oauthplayground**。
  ![解决 "Access Not Configured. The API (YouTube Analytics API) is not enabled for your project."](/images/2015/10/0026uWfMgy6WlX3loVqb0.jpg)
- 关键的一点是在Google Developers OAuth 2.0 Playground中采用**“Use yourown OAuthcredentials”**。我觉得403错误可能是playground自动创建的证书没有和自己的项目绑定，因此认为YoutubeAnalytics API没有激活。
  ![解决 "Access Not Configured. The API (YouTube Analytics API) is not enabled for your project."](/images/2015/10/0026uWfMgy6WlX3STRD39.jpg)
- 200OK出来了，搞定：
  ![解决 "Access Not Configured. The API (YouTube Analytics API) is not enabled for your project."](/images/2015/10/0026uWfMgy6WlX4JlIocc.jpg)

当然，类似查询也可以在Google API Explorer里面完成，而且没碰到什么障碍。
![解决 "Access Not Configured. The API (YouTube Analytics API) is not enabled for your project."](/images/2015/10/0026uWfMgy6WmekZ4FH41.jpg)