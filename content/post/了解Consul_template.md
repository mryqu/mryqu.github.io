---
title: '了解Consul template'
date: 2015-06-17 06:22:19
categories: 
- Tool
- Consul
tags: 
- consul
- consul-template
- devops
---
支持 DNS 和基于HTTP发现机制的服务发现工具[Consul](http://consul.io/)让我们印象深刻。它提供了定制化的注册服务健康检查并标记不健康实例的功能远胜于其他类似的工具。更多时兴的工具与[Consul](http://consul.io/)的集成使其功能更加强大。ConsulTemplate守护进程提供了一个便捷方式直接使用[Consul](http://consul.io/)的信息来填充配置文件。
`consul-template` 查询一个[Consul](http://consul.io/)实例并对文件系统任意数量模板进行更新。此外，`consul-template` 在更新过程结束后可选地执行任意多个命令。
`consul-template` 项目提供了一些例子，通过[Consul](http://consul.io/)信息生成负载均衡器HAProxy、缓存引擎Varnish和web服务器Apachehttpd的配置文件。

### 参考

[Github：hashicorp/consul-template](https://github.com/hashicorp/consul-template)    
[Scalable Architecture DR CoN: Docker, Registrator, Consul, Consul Template and Nginx](https://www.airpair.com/scalable-architecture-with-docker-consul-and-nginx)    