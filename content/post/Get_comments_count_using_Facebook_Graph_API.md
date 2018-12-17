---
title: 'Get comments count using Facebook Graph API'
date: 2016-05-06 05:50:38
categories: 
- DataBuilder
tags: 
- facebook
- graph
- comments
- summary
- total_count
---
### 通过fields参数获取评论/回复个数

通过预判评论/回复个数，以决定是否发起[/{object-id}/comments](https://developers.facebook.com/docs/graph-api/reference/v2.6/object/comments)API请求，可以显著减少API请求个数。
#### 获取帖子的评论数
```
https://graph.facebook.com/{YOUR_PAGE_ID}/feed?fields=id,XXXX,likes.limit(0).summary(1),comments.limit(0).summary(1),XXXX,with_tags&format=json&include_hidden=true&limit=100&since=XXXX&until=XXXX&include_hidden=true&access_token={YOUR_ACCESS_TOKEN}
```
![Get comments count using Facebook Graph API](/images/2016/5/0026uWfMzy7ai012ULXfd.jpg)
#### 获取评论的回复数
```
https://graph.facebook.com/{YOUR_POST_ID}/comments?fields=id,from,message,created_time,like_count,comments.limit(0).summary(1)&format=json&include_hidden=true&limit=100&since=XXXX&until=XXXX&include_hidden=true&access_token={YOUR_ACCESS_TOKEN}
```
![Get comments count using Facebook Graph API](/images/2016/5/0026uWfMzy7ai0su4Pxdb.jpg)

### comments.summary.total_count解读
在Facebook Graph指南中[/{object-id}/comments](https://developers.facebook.com/docs/graph-api/reference/v2.6/object/comments)提到了total_count数值是随filter变动的。
- filter为stream，total_count为该节点下所有评论及其回复的总数；
- filter为toplevel，total_count为该节点下顶层评论/回复的总数。

由于在我的使用场景中为设置filter，而其默认值为toplevel，则total_count为该节点下顶层评论/回复的总数。