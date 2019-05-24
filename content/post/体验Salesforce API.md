---
title: '体验Salesforce API'
date: 2019-05-21 06:01:23
categories: 
- DataBuilder
tags: 
- salesforce
- api
- soap
- rest
---
继前一博文[Salesforce dataLoader一览](/post/Salesforce dataLoader一览)，这次就开始体验一把Salesforce API了。

### 准备工作

1. 通过[developer.salesforce.com/signup](https://developer.salesforce.com/signup)获得Salesforce开发版  
2. 确保激活了API权限  
![salesface api: api enabled](/images/2019/5/salesforce_api_enabled.png)
3. 创建connected app：scnydqTest1  
![salesface api: connected app scnydqTest1](/images/2019/5/salesforce_connectedapp_scnydqTest1.png)
4. 获取scnydqTest1的sonsumer key和secret
![salesforce api: list connected apps](/images/2019/5/salesforce_list_connectedapp.png)  
![salesforce api: get consumer key and secret](/images/2019/5/salesforce_get_consumersecret.png)  

### OAuth鉴权

Salesforce的OAuth鉴权支持三种流程：  
* web服务器流程：适用于服务器可以保存consumer secret  
* 用户代理流程：适用于应用无法安全保存consumer secret  
* 用户密码流程：应用使用用户凭证直接访问  

#### OAuth鉴权之web服务器流程

验证按照[Understanding the User-Agent OAuth Authentication Flow](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_understanding_web_server_oauth_flow.htm)进行。
```
https://login.salesforce.com/services/oauth2/authorize?response_type=code&client_id={scnydqTest1_appConsumerKey}&redirect_uri=https%3A%2F%2Flogin.salesforce.com%2Fservices%2Foauth2%2Fsuccess
```
鉴权：  
![salesforce api: get consumer key and secret](/images/2019/5/salesforce_scnydqTest1_oauth_1.png)  
通过跳转URL获取code：  
![salesforce api: get consumer key and secret](/images/2019/5/salesforce_scnydqTest1_oauth_2.png)  
通过code、consumer key和consumer secret获取access token：  
![salesforce api: get consumer key and secret](/images/2019/5/salesforce_scnydqTest1_oauth_3.png)  

#### OAuth鉴权之用户代理流程

验证按照[How Are Apps Authenticated with the Web Server OAuth Authentication Flow?](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_understanding_user_agent_oauth_flow.htm)进行。
```
https://login.salesforce.com/services/oauth2/authorize?response_type=token&client_id={scnydqTest1_appConsumerKey}&redirect_uri=https%3A%2F%2Flogin.salesforce.com%2Fservices%2Foauth2%2Fsuccess
```
认证： 
![salesforce api: ua auth](/images/2019/5/salesforce_scnydqTest1_uaauth_1.png)   
鉴权：  
![salesforce api: ua auth](/images/2019/5/salesforce_scnydqTest1_uaauth_2.png)   
通过跳转URL获取access_token：  
![salesforce api: ua auth](/images/2019/5/salesforce_scnydqTest1_uaauth_3.png)   
返回URL为：
```
https://login.salesforce.com/services/oauth2/success#access_token=00D2v000000R9tt%21AXXXXXi.&instance_url=https%3A%2F%2Fap15.salesforce.com&id=https%3A%2F%2Flogin.salesforce.com%2Fid%2F00D2XXXXXC%2F005XXXXXL&issued_at=1XXXXX8&signature=iXXXXXI%3D&scope=id+api&token_type=Bearer
```

#### OAuth鉴权之用户密码流程

验证按照[Understanding the Username-Password OAuth Authentication Flow](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_understanding_username_password_oauth_flow.htm)进行。

![salesforce api: pwdauth](/images/2019/5/salesforce_pwdauth.png)  

### REST调用

此处走一下[Salesforce官方的快速入门示例](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/quickstart_code.htm)。

#### 获取Salesforce版本

![salesforce api: get ver](/images/2019/5/salesforce_rest_getver.png)  


#### 使用Salesforce版本获取可用资源

![salesforce api: get res](/images/2019/5/salesforce_rest_getres.png)  


#### 使用一个资源获取可用对象列表

![salesforce api: get obj list](/images/2019/5/salesforce_rest_getobjs.png)  

#### 获取一个对象的元数据描述

![salesforce api: get obj metadata](/images/2019/5/salesforce_rest_getobjmeta.png)  

#### 获取一个对象的列信息

![salesforce api: get obj columns](/images/2019/5/salesforce_rest_getobjcols.png)  

#### 执行SOQL查询获取Account记录的某些指定列的值

![salesforce api: query](/images/2019/5/salesforce_rest_query.png)  

### 限额


REST API与SOAP API使用相同的数据模型和标准对象。REST API遵循[SOAP API的限额](https://developer.salesforce.com/docs/atlas.en-us.218.0.api.meta/api/implementation_considerations.htm?SearchType=Stem)。  
获取[Limits信息](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_limits.htm)详见[Salesforce示例](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_limits.htm)。


### 参考

[Salesforce SOAP API Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.218.0.api.meta/api/sforce_api_quickstart_intro.htm)  
[Salesforce REST API Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_what_is_rest_api.htm)   
[SOQL and SOSL Reference](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_sosl_intro.htm)   
[Salesforce Bulk API Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_intro.htm)   
[Enhance Salesforce with Code](https://help.salesforce.com/articleView?id=extend_code_overview.htm&type=5)   