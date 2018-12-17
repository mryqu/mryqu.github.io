---
title: 'Facebook Graph API之我的常用URL笔记'
date: 2016-01-08 06:20:20
categories: 
- DataBuilder
tags: 
- facebook
- graph
- page
- post
- comment
---
### 获取Facebook主页Id
https://graph.facebook.com/v2.5/SasSoftware?access_token={accessToken}&format=json ![Facebook Graph API之我的常用URL笔记](/images/2016/1/0026uWfMgy71y27IyKe8a.png)上面示例是通过主页名SasSoftware获取其主页Id。
### 获取Facebook主页帖子
- https://graph.facebook.com/v2.5/{pageId}/feed?limit=100&format=json&include_hidden=true&access_token={accessToken}&since=2015-01-01&util=2015-12-31  
- https://graph.facebook.com/{pageId}/feed?limit=100&format=json&include_hidden=true&access_token={accessToken}&since=1420041660&util=1422634320  
- https://graph.facebook.com/v2.0/{pageId}/feed?limit=100&format=json&include_hidden=true&access_token={accessToken}&since=1420041660&util=1422634320

通过Facebook Graph API 2.5或不带版本的API仅能获取帖子的Id、创建时间和帖子内容，而FacebookGraph API 2.0则可以获得更多内容。
### 获取Facebook帖子的评论信息
https://graph.facebook.com/{postId}/comments?limit=100&format=json&include_hidden=true&access_token={accessToken}
### 获取Facebook帖子的点赞信息
https://graph.facebook.com/{postId}/likes?limit=100&format=json&include_hidden=true&summary=true&access_token={accessToken}