---
title: 'Hello Microsoft OneDrive API'
date: 2016-10-12 06:14:09
categories: 
- DataBuilder
tags: 
- microsoft
- onedrive
- api
- crawler
- storage
---
OneDriveAPI提供了一套HTTP服务用以将应用连接到OneDrive个人版、OneDrive商业版及SharePoint在线文档库上的文件和目录。OneDriveAPI使应用连接Office 365上文档及访问OneDrive和SharePoint上文件高级功能变得容易。

### 测试源

为了省事，就用我自己私人的OneDrive做测试吧。![Hello Microsoft OneDrive API](/images/2016/10/0026uWfMzy75ApSbcoC8e.jpg) ![Hello Microsoft OneDrive API](/images/2016/10/0026uWfMzy75ApSdViob0.jpg)

### 获取Token

最省事的方法是在[OneDrive authentication and sign-in](https://dev.onedrive.com/auth/msa_oauth.htm)里面获得测试Token，无需注册新的应用就可以请求到与登录账户绑定的、一个有效期1小时的开发者Token。![Hello Microsoft OneDrive API](/images/2016/10/0026uWfMzy75ArHnoUT3f.jpg)

### 测试API

#### 获取默认Drive
![Hello Microsoft OneDrive API](/images/2016/10/0026uWfMzy75ArRMkMY1c.jpg)
#### 查看Drive 根目录内容
![Hello Microsoft OneDrive API](/images/2016/10/0026uWfMzy75AsXlveM18.png) 从上图可知，根目录包含一个包含"050709大同"子目录，该子目录的id为"712B21FCE8E08C92!112"。从整个响应内容可知，根目录包含"文档"子目录，其id为"712B21FCE8E08C92!442"。
#### 查看Drive "文档"目录
![Hello Microsoft OneDrive API](/images/2016/10/0026uWfMzy75AsYRZ3Aea.jpg) 该目录下有一个CN_EN_JP_KO.xlsx文件，其@content.downloadUrl属性值为下载链接。
#### 获取CN_EN_JP_KO.xlsx文件
![Hello Microsoft OneDrive API](/images/2016/10/0026uWfMzy75ArRTReX2b.png) 如果将链接直接放入浏览器，下载后将文件名变更成xlsx后缀，即可用Excel打开。

### 参考

[Develop with the OneDrive API](https://dev.onedrive.com/README.htm)    