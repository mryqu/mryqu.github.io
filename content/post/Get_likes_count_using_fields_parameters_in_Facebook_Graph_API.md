---
title: 'Get likes count using fields parameters in Facebook Graph API'
date: 2016-05-05 06:02:17
categories: 
- DataBuilder
tags: 
- facebook
- graph
- likes
- count
---
原来获得Facebook帖子/评论的点赞数，需要额外单独发送一次API请求：![Get likes count using fields parameters in Facebook Graph API](/images/2016/5/0026uWfMzy7agEMpj5qd4.jpg)![Get likes count using fields parameters in Facebook Graph API](/images/2016/5/0026uWfMzy7agEQ2GPT69.jpg) 通过对Facebook GraphAPI中fields参数添加likes.limit(0).summary(1)，仅需一次API请求就可获得帖子/评论的所有信息：![Get likes count using fields parameters in Facebook Graph API](/images/2016/5/0026uWfMzy7agETUMjf19.jpg)
