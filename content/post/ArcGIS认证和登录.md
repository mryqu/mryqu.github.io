---
title: 'ArcGIS认证和登录'
date: 2017-05-18 05:43:22
categories: 
- DataBuilder
tags: 
- esri
- arcgis
- rest
- oauth
- login
---
### 申请ArcGIS Online账户
![ArcGISDev Signup](/images/2017/05/ArcGISDev_Signup.png)
### 创建应用

点击创建第一个应用：
![ArcGISDev NewApp](/images/2017/05/ArcGISDev_NewApp.png)
输入应用所需信息：
![ArcGISDev AppInfoInput](/images/2017/05/ArcGISDev_AppInfoInput.png)
查看应用信息：
![ArcGISDev AppInfoCheck](/images/2017/05/ArcGISDev_AppInfoCheck.png)
设置redirect URI：
![ArcGISDev App redirectURI](/images/2017/05/ArcGISDev_App_redirectURI.png)
### 获取应用访问令牌

![ArcGISDev App getAppToken](/images/2017/05/ArcGISDev_App_getAppToken.png)
默认情况下，访问令牌2小时过期。可在获取访问令牌的请求中加入expiration参数，指定以分钟为单位的过期间隔（响应中单位为秒），最大为14天。
应用登录具有几个内建限制：
*   通过应用获取的访问令牌仅能读取公开内容和服务。
*   通过应用获取的访问令牌有可能读取Esri托管的高级内容和服务，并消费代表应用所有者的点数。
*   应用无法创建、更新、共享、修改和删除在ArcGIS Online或ArcGIS门户网站上的内容（层、文件、服务、地图）。
*   使用应用登录方式的应用无法列于ArcGIS软件商店。

### 获取用户访问令牌
用于用户登录的HTTP GET请求如下：
```
https://www.arcgis.com/sharing/rest/oauth2/authorize?client_id={YOUR_APP_CLIENT_ID}&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code
```
请求用户授权：
![ArcGISDev App authorize](/images/2017/05/ArcGISDev_App_authorize.png)
返回地址包含code参数，内容中也有一含有code值的文本框：
![ArcGISDev App Approval](/images/2017/05/ArcGISDev_App_approval.png)
获取访问令牌的HTTP GET请求包含上面获得的code参数：：
```
https://www.arcgis.com/sharing/rest/oauth2/token?client_id={YOUR_APP_CLIENT_ID}&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code&code={GOTTEN_CODE}
```
![ArcGISDev App getUserToken](/images/2017/05/ArcGISDev_App_getUserToken.png)
### 访问令牌使用

不同的ArcGIS REST API使用的访问令牌类型可能不同。例如在[Accessing the GeoEnrichment service](https://developers.arcgis.com/rest/geoenrichment/api-reference/accessing-the-service.htm)中提到使用GeoEnrichment服务需要用户访问令牌；而在 [Authenticate a request to the World Geocoding Service](https://developers.arcgis.com/rest/geocode/api-reference/geocoding-authenticate-a-request.htm)中提到使用Geocoding服务需要应用访问令牌。
下面的示例使用用户访问令牌执行Geocoding服务的操作，结果返回403错误，提示Token is valid but access is denied，具体信息为User does not have permissions to access geocodeAddresses。
![ArcGISDev App wrongToken](/images/2017/05/ArcGISDev_App_wrongToken.png)
### 参考
* * *
[ArcGIS: Implementing App Login](https://developers.arcgis.com/authentication/accessing-arcgis-online-services/)  
[ArcGIS: Implementing Named User Login](https://developers.arcgis.com/authentication/signing-in-arcgis-online-users/)  
[ArcGIS: Mobile and Native Named User Login](https://developers.arcgis.com/authentication/mobile-and-native-user-logins/)  
[ArcGIS: Limitations of App Login](https://developers.arcgis.com/authentication/limitations-of-application-authentication/)  