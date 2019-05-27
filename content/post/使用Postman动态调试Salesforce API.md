---
title: '使用Postman动态调试Salesforce API'
date: 2019-05-27 06:12:23
categories: 
- Tool
tags: 
- Postman
---

在使用Postman调试Salesforce API时，觉得每次输入Access Token很low，应该充分利用它的脚本能力进行自动化。

### 创建环境变量

创建新环境变量：
![Postman: new Env](/images/2019/5/Postman_01_newEnv.png)  

设置环境变量：
![Postman: env Setting ](/images/2019/5/Postman_02_envSetting.png)  

选择环境变量：
![Postman: select Env](/images/2019/5/Postman_03_selectEnv.png)  


### 创建OAuth集合

创建OAuth Collection：  
![Postman: new Collection OAuth](/images/2019/5/Postman_04_newCollOAuth.png)  

创建Password Authorization请求：  
![Postman: new PwdAuth Request](/images/2019/5/Postman_05_CollOAuth_newPwdAuthReq.png)  

Password Authorization请求头：  
![Postman: PwdAuth Request Headers](/images/2019/5/Postman_06_CollOAuth_PwdAuthReq_Headers.png)  

Password Authorization请求体：  
![Postman: PwdAuth Request Body](/images/2019/5/Postman_07_CollOAuth_PwdAuthReq_Body.png)  

Password Authorization响应脚本：
脚本用于将响应中信息写入ACCESS_TOKEN和INSTANCE_URL环境变量以用于后继API调用。  
![Postman: PwdAuth Request Tests](/images/2019/5/Postman_08_CollOAuth_PwdAuthReq_Tests.png)  

Server Authorization请求：  
![Postman: ServerAuth Request Body ](/images/2019/5/Postman_09_CollOAuth_ServerAuthReq_Body.png)  

### 创建Export集合

创建Export Collection： 
![Postman: newCollExport](/images/2019/5/Postman_10_newCollExport.png)  

编辑Export Collection： 
主要是让集合内请求共用Bearer Token。
![Postman: editCollExport](/images/2019/5/Postman_11_editCollExport.png)  

获取版本： 
脚本用于将响应中信息写入LATEST_VER_PATH环境变量以用于后继API调用。  
![Postman: getVers](/images/2019/5/Postman_12_CollExport_getVers.png)  
注： 通过快捷键(CMD/CTRL + ALT + C)可以打开Postman应用的控制台。

获取资源： 
![Postman: getRess](/images/2019/5/Postman_13_CollExport_getRess.png)  

获取对象列表： 
![Postman: getObjs](/images/2019/5/Postman_14_CollExport_getObjs.png)  

获取对象元数据： 
![Postman: getObjMeta](/images/2019/5/Postman_15_CollExport_getObjMeta.png)  

获取对象列信息： 
脚本用于通过响应信息生成QUERY环境变量以用于SOQL查询API调用。  
![Postman: getObjCols](/images/2019/5/Postman_16_CollExport_getObjCols.png)  

执行SOQL查询： 
![Postman: query](/images/2019/5/Postman_17_CollExport_query.png)  

查询限额： 
![Postman: get limits](/images/2019/5/Postman_18_CollExport_limits.png)   


最后将环境变量和两个请求集合导出成JSON文件，可以共享给其他人使用。