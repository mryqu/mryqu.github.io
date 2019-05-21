---
title: 'Salesforce Data Loader一览'
date: 2019-05-20 06:00:05
categories: 
- DataBuilder
tags: 
- salesforce
- dataloader
---
最近研究一下如何从[Salesforce](https://www.salesforce.com/)抓取数据，所以找到了[dataloader.io](https://dataloader.io/)和[dataloader](https://github.com/forcedotcom/dataloader)这两款软件进行学习。

### [dataloader.io](https://dataloader.io/)

[dataloader.io](https://dataloader.io/)是[salesforce AppExchange](https://appexchange.salesforce.com/listingDetail?listingId=a0N30000009w8ZBEAY)上的应用。它分为免费版、专业版和企业版。

入口  
![dataloader.io: 入口](/images/2019/5/dataloader.io_1.png)
认证  
![dataloader.io: 认证](/images/2019/5/dataloader.io_2.png)
授权  
![dataloader.io: 授权](/images/2019/5/dataloader.io_3.png)
主界面  
![dataloader.io: 主界面](/images/2019/5/dataloader.io_4.png)
导出 - 浏览对象
![dataloader.io: 导出 - 浏览对象](/images/2019/5/dataloader.io_5.png)
导出 - 选择列  
![dataloader.io: 导出 - 选择列](/images/2019/5/dataloader.io_6.png)
导出 - 设置  
![dataloader.io: 导出 - 设置](/images/2019/5/dataloader.io_7.png)
导出 - 运行结果邮件  
![dataloader.io: 导出 - 运行结果邮件](/images/2019/5/dataloader.io_8.png)

### [Data Loader](https://github.com/forcedotcom/dataloader)

[Data Loader](https://github.com/forcedotcom/dataloader)是[Salesforce](https://www.salesforce.com/)开源的一款桌面版数据连接器，基于Java语言，底层依赖[Force Wsc和Patner API](https://mvnrepository.com/artifact/com.force.api)。
![dataloader: 主界面](/images/2019/5/dataloader_1.png) 
[Data Loader](https://github.com/forcedotcom/dataloader)有两种登陆方式：OAuth和Password Authentication。
![dataloader: 登陆界面](/images/2019/5/dataloader_2.png) 

#### OAuth认证

认证
![dataloader: 认证](/images/2019/5/dataloader_oauth_1.png) 
授权
![dataloader: 授权](/images/2019/5/dataloader_oauth_2.png) 
登陆成功
![dataloader: 登陆成功](/images/2019/5/dataloader_oauth_3.png) 

#### 密码认证

![dataloader: 密码认证](/images/2019/5/dataloader_pwdauth_1.png) 
注：  
* 假设用户密码为mypwd，此处要输入的密码为用户密码和下面提到的Salesforce 安全标记组合，即mypwdXXXXXXXXXXXX。  
* 此处Salesforce登陆URL为用户所在的实例地址。如果使用沙箱的话，则使用https://test.salesforce.com。  

![dataloader: Salesforce 安全标记](/images/2019/5/dataloader_pwdauth_2.png) 

#### 导出

导出 - 浏览对象
![dataloader.io: 导出 - 浏览对象](/images/2019/5/dataloader_export_1.png)
导出 - 选择列  
![dataloader.io: 导出 - 选择列](/images/2019/5/dataloader_export_2.png)
导出 - 运行  
![dataloader.io: 导出 - 运行](/images/2019/5/dataloader_export_3.png)
导出 - 查看结果  
![dataloader.io: 导出 - 查看结果](/images/2019/5/dataloader_export_4.png)

### 其他Salesforce Data Loader

[Jitterbit Cloud Data Loader for Salesforce](https://www.jitterbit.com/solutions/salesforce-integration/salesforce-data-loader/)  
[Salesforce Connector - Mule 4](https://www.mulesoft.com/exchange/com.mulesoft.connectors/mule-salesforce-connector/)    


### 参考

[Data Loader Guide](https://developer.salesforce.com/docs/atlas.en-us.dataLoader.meta/dataLoader/data_loader.htm)  
[Data Loader help](https://help.salesforce.com/articleView?id=data_loader.htm&type=5)  
[重置您的安全标记](https://help.salesforce.com/articleView?id=user_security_token.htm&type=5)  
[更新 Connect Offline、Connect for Office 和 Data Loader 中的标记](https://help.salesforce.com/articleView?id=user_security_token_connect.htm&type=5)  