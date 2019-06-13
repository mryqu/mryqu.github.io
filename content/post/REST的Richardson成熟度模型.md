---
title: 'REST的Richardson成熟度模型'
date: 2013-10-19 10:59:05
categories: 
- Service+JavaEE
tags: 
- rest
- restful
- web服务
- 成熟度
- 模型
---
一个web服务有多么的"restful"，最有名的就是《RESTful Web Services》的合著者Leonard Richardson提出的REST 成熟度模型，简称Richardson成熟度模型。
- 第0级：使用HTTP作为传输方式；一个URI，一个HTTP方法。SOAP、XML-RPM都属于这一级别，仅是来回传送"Plain OldXML"(POX)。即使没有显式调用RPC接口（SOAP、XML-RPM），通常会调用服务器端的一个处理过程。一个接口会有一个端点，文档的内容会被解析用还判断所要调用的处理过程及其参数。这种做法相当于把HTTP 这个应用层协议降级为传输层协议用。HTTP 头和有效载荷是完全隔离的，HTTP头只用于保证传输，不涉及业务逻辑；有效载荷包含全部业务逻辑，因此 API 可以无视 HTTP 头中的任何信息。
- 第1级：引入了资源的概念，每个资源有对应的标识符和表达；多个URI，一个HTTP方法。这些资源仍是被"GETful"接口操作而不是HTTP动词，但服务基本上提供和操作资源。例如：
  - GET http://example.com/app/createUser
  - GET http://example.com/app/getUser?id=123
  - GEThttp://example.com/app/changeUser?id=123&field=value
  - GET http://example.com/app/deleteUser?id=123
- 第2级：根据语义使用HTTP动词，适当处理HTTP响应状态码；多个URI，多个HTTP方法。
  - GET用于查询资源；
  - HEAD用于查询资源是否存在；
  - POST创建新资源；
  - PUT更新已存在的资源；
  - PATCH部分更新已存在的资源；
  - DELETE删除已存在的资源。在这一级别，资源名称为基URI的一部分，而不是查询参数。
- 第3级：使用超媒体作为应用状态引擎（HATEOAS）；多个URI，多个HTTP方法。在资源的表达中包含了链接信息。客户端可以根据链接来发现可以执行的动作。链接推荐使用ATOM (RFC4287)中的显式语义。

当然围绕这一模型，争论很多，Martin Fowler、Rest之父Roy Fielding、《RESTful WebServices Cookbook》作者Subbu Allamaraju都有不同的见解。

### 参考

Leonard Richardson：[REST 成熟度模型](http://www.crummy.com/writing/speaking/2008-QCon/act3.html)    
Martin Fowler：[Richardson Maturity Model](http://martinfowler.com/articles/richardsonMaturityModel.html)    
Roy Fielding：[REST APIs must be hypertext-driven](http://roy.gbiv.com/untangled/2008/rest-apis-must-be-hypertext-driven)    
Subbu Allamaraju：[Measuring REST](https://www.subbu.org/blog/2011/05/measuring-rest)    
[如何度量应用的RESTful成熟度？](http://www.infoq.com/cn/news/2011/05/measuring-rest)    