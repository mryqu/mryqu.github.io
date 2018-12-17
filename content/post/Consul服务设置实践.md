---
title: 'Consul服务设置实践'
date: 2015-08-04 05:54:36
categories: 
- Tool
- Consul
tags: 
- consul
- service
- check
- register
- deregister
---
在[向Consul注册/注销外部服务节点](/post/向consul注册注销外部服务节点)中，我实践对Consul节点注册和注销，本帖我实践一些对Consul服务的查看和注销。

查看当前数据中心所有注册的服务：
```
curl http://localhost:8500/v1/catalog/services
```

查看当前数据中心注册的服务`foo`的信息：
```
curl http://localhost:8500/v1/catalog/service/foo
```

注销服务节点`foo`上关联的检查`service:foo-192-168-0-123`：
```
curl -X PUT -H 'application/json' -d '{"Node": "kexiao", "CheckID": "service:foo-192-168-0-123"}' http://localhost:8500/v1/catalog/deregister
```

注销服务节点`foo`上关联的服务`foo-192-168-0-123`：
```
curl -X PUT -H 'application/json' -d '{"Node": "kexiao", "ServiceID": "foo-192-168-0-123"}' http://localhost:8500/v1/catalog/deregister
```

### 参考

[Consul - Catalog HTTP Endpoint](https://www.consul.io/docs/agent/http/catalog.html)  