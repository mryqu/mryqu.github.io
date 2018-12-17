---
title: 'Making Nested Requests using Facebook Graph API'
date: 2017-04-13 05:53:26
categories: 
- DataBuilder
tags: 
- facebook
- graph
- api
- nested request
- fields
---
今天又玩了一把Facebook Graph API。当我们抓取Page上的帖子后，之后会发起API请求获取帖子的评论及回复。

#### 获取Page SASsoftware（ID为193453547355388）下的帖子
```
https://graph.facebook.com/193453547355388/feed?fields=id,XXXX,likes.limit(0).summary(1),comments,XXXX,with_tags&format=json&include_hidden=true&limit=100&since=XXXX&until=XXXX&access_token={YOUR_TOKEN}
```
![FB:SASSoftware feed](/images/2017/04/FB_SASSoftware_feed.png)
#### 获取帖子193453547355388_951786161522119的评论
```
https://graph.facebook.com/193453547355388_951786161522119/comments?fields=id,from,message,created_time,like_count&format=json&include_hidden=true&limit=100&access_token={YOUR_TOKEN}
```
![FB:SASSoftware pageItemComment](/images/2017/04/FB_SASSoftware_pageItemComment.png)
#### 获取评论951786161522119_951787458188656的回复
```
https://graph.facebook.com/951786161522119_951787458188656/comments?fields=id,from,message,created_time,like_count&format=json&include_hidden=true&limit=100&access_token={YOUR_TOKEN}
```
![FB:SASSoftware pageItemCommentReply](/images/2017/04/FB_SASSoftware_pageItemCommentReply.png)
### 试用嵌套请求
```
https://graph.facebook.com/193453547355388/feed?fields=id,XXXX,likes.limit(0).summary(1),comments{id,from,message,type,created_time,like_count,comments{id,from,message,type,created_time,like_count}},XXXX,with_tags&format=json&include_hidden=true&limit=100&since=XXXX&until=XXXX&access_token={YOUR_TOKEN}
```
这里的请求使用了两级嵌套请求，第一级获取帖子的评论，第二季获取评论的回复，那结果如何？
![FB:SASSoftware restedRequest](/images/2017/04/FB_SASSoftware_restedRequest.png)
一个API请求就能够获得了帖子、评论及回复的信息。**但是**，考虑到一个帖子的评论或一个评论的回复都可能很多，返回结果是第一个分页结果，还是需要通过[/{object-id}/comments](https://developers.facebook.com/docs/graph-api/reference/v2.8/object/comments) API 请求获取，考虑到设计复杂性和性价比，决定放弃这种方案。



