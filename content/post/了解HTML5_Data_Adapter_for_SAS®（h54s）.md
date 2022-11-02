---
title: '了解HTML5 Data Adapter for SAS®（h54s）'
date: 2016-01-30 06:20:15
categories: 
- FrontEnd
tags: 
- h54s
- sas
- boemska
- html5
- bi
---
今天在LinkedIn上看到一个消息，SAS的银牌合作伙伴Boemska开源了他们的HTML5 Data Adapter forSAS®（h54s）。
H54S是一个库，帮助和管理基于HTML5(JavaScript)的Web应用与部署在SAS企业BI平台上以SAS语言开发的后端数据服务之间的无缝双向通信。可以让Web程序员和SAS开发者协作以前所未有的速度和敏捷创建通用Web应用。
服务器端要求：
- SAS® BI平台 (9.2及更高版本)
- SAS® 存储过程Web应用 (集成技术)

粗略扫了一下h54s.sas、h54s.js和method.js：编写一个引入h54s.sas的SAS存储过程，接收前端的JSON数据，经过该SAS存储过程处理后返回给前端JSON结果。

### 参考

[HTML5 Data Adapter for SAS®（h54s）](https://boemskats.com/h54s/)    
[GitHub：boemska/h54s](https://github.com/boemska/h54s)    