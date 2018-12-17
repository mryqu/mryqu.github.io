---
title: 'Dropbox API访问速率限制'
date: 2016-10-05 06:06:00
categories: 
- DataBuilder
tags: 
- dropbox
- api
- rate
- limit
- quota
---
Dropbox的Data ingress guide介绍了关于Dropbox API访问速率限制。
错误Status code: 429 (Too ManyRequests)用于表示API访问速率超限，如果响应包内容为JSON，则包含too_many_requests或too_many_write_operations值进行更进一步说明。
关联用户的应用，访问速率限制仅适用于每用户。一个用户关联多个应用，各应用互不影响。
关联团队的应用当调用商业端点（BusinessEndpoint），访问速率限制仅适用于每个团队。如果应用有团队成员文件访问权限但是正在调用用户端点（UserEndpoint），访问速率限制仅适用于每个团队成员。这意味着，对于关联团队的应用，一个团队关联多个应用，各应用互不影响；单个应用代表多个团队成员的请求，也不会影响团队成员彼此的访问速率限制。
超过速率限制后的响应包含一个Retry-After头，提供按秒计的等待间隔值，应用在这段时间内不应重试请求以免再获得速率限制响应。
**Dropbox不会公布其API速率限制值，开发时要假设Dropbox会在今后调整其API速率限制。**
