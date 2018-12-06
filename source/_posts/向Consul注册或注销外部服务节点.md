---
title: '向Consul注册/注销外部服务节点'
date: 2015-08-01 07:00:25
categories: 
- Tool
- Consul
tags: 
- consul
- external
- service
- register
- deregister
---
已有一个docker上的微服务节点`foo`，但是有可能需要使用系统外部的`foo`服务集群。
切换到系统外部的`foo`服务集群的操作过程如下：
```
docker-compose stop foo
docker-compose rm foo
curl -X PUT -H 'application/json' -d '{"Node": "foo", "Address": "foo.cluster.yqu.com", "Service": {"Service":"foo", "tags": ["controller"],  "port": 12221}}' http://localhost:8500/v1/catalog/register
docker-compose restart consul
```

切换回系统内部过程的`foo`服务节点操作过程如下：
```
curl -X PUT -H 'application/json' -d '{"Node": "foo"}' http://localhost:8500/v1/catalog/deregister
docker-compose up -d foo
docker-compose restart consul
```

注销`foo`服务节点操作过程如下：
```
curl -X PUT -H 'application/json' -d '{"Node": "foo"}' http://localhost:8500/v1/catalog/deregister
docker-compose stop foo
docker-compose rm foo
docker-compose restart consul
```

### 参考

[Consul Guide：Registering An External Service](https://www.consul.io/docs/guides/external.html)  