---
title: 'Google Analytics API Error 403: "User does not have any Google Analytics Account"'
date: 2015-09-19 06:05:53
categories: 
- DataBuilder
tags: 
- google
- analytics
- api
- account
---
试用Google Analytics API，使用service account的认证方式，结果它报错:“User doesnot have any Google Analytics Account”。

解决方法：

1. 在Google开发者控制台中确认Analytics API已经使能
   ![enable Analytics API](/images/2015/9/0026uWfMgy6WclsRaWLdb.jpg)
2. Service account的邮箱域为@developer.gserviceaccount.com
   ![Service account mail domain](/images/2015/9/0026uWfMgy6WcltfPYi1e.jpg)
3. 拥有适当的AccountID和ProfileID，并将serviceaccount（至少以读取和分析权限）添加到Google Analytics profile
   ![enable premit](/images/2015/9/0026uWfMgy6WcltLBDEe6.jpg)

### 参考

[Google's instructions for adding an email address to an Analytics profile](https://support.google.com/analytics/answer/1009702?hl=en)  
