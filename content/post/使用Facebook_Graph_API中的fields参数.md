---
title: '使用Facebook Graph API中的fields参数'
date: 2016-01-15 05:50:04
categories: 
- DataBuilder
tags: 
- facebook
- graph
- api
- fields
- fieldexpansion
---
使用Facebook Graph API进行查询，v2.3和v2.4版返回结果截然不同。使用v2.3之前的FacebookGraph API获得的响应信息很详细，而使用v2.4及之后的Facebook Graph API获得的响应基本没什么信息！
![使用Facebook Graph API中的fields参数](/images/2016/1/0026uWfMzy73gPqG1BJ97.jpg)![使用Facebook Graph API中的fields参数](/images/2016/1/0026uWfMzy73gPr00iA50.jpg)
这可是相同的AccessToken呀。卖萌的话，可以说句“吓死宝宝了”。

[Using the Graph API](https://developers.facebook.com/docs/graph-api/using-graph-api)提到可以使用fields参数选择所需字段，照着v2.3的加上了id、name、about、awards......
![使用Facebook Graph API中的fields参数](/images/2016/1/0026uWfMzy73gPrlmbr45.jpg)失而复得，虚惊一场！！！

[Using the Graph API](https://developers.facebook.com/docs/graph-api/using-graph-api)里不仅提到了选择参数，还提到可以使用字段表达式进行嵌套查询。
![使用Facebook Graph API中的fields参数](/images/2016/1/0026uWfMzy73gPrzveub6.jpg) likes字段使用limit(1)限定其仅返回一个点赞数据，反正我还要使用GraphAPI对帖子点赞数据进行请求，返回一个点赞知道需不需要请求就好了。

comments字段还制定了二级字段attachment、id和from。这样comments字段既不会漏了我需要的子字段，也不会多出来我不需要的字段。在上图GraphAPI Explorer中，左侧comments字段下面的”Search for afield“链接可以提示那些子字段可选，很方便。
