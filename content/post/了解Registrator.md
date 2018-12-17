---
title: '了解Registrator'
date: 2015-06-18 05:50:21
categories: 
- Tool
- Docker
tags: 
- docker
- consul
- registrator
- service
- devops
---
支持 DNS和基于HTTP发现机制的服务发现工具Consul让我们印象深刻。它提供了定制化的注册服务健康检查并标记不健康实例的功能远胜于其他类似的工具。更多时兴的工具与Consul的集成使其功能更加强大。在使用Docker的场景里，有了Registrator的帮助，只需要很小的工作量就可以自动化地向Consul注册Docker容器，使得管理基于容器技术的配置更加容易。
Registrator通过检查Docker容器是否上线，自动为Docker容器注册/注销服务。Registrator支持可插拔服务注册中心，当前包括[Consul](http://www.consul.io/)、[etcd](https://github.com/coreos/etcd)和[SkyDNS 2](https://github.com/skynetservices/skydns/)。

### 用法

1. 运行Consul容器
   ```
   $ docker run -d --name=consul --net=host consul-server -bootstrap
   ```
2. 运行Registrator容器
   Registrator被设计为在每个主机运行一次。也可以在每个集群仅运行一个Registrator，但是通过确保Registrator运行在每个主机上可以获得更好的伸缩性和更简化的配置。假定使用某种程度的自动化，在所有地方都运行反而讽刺性地比某个地方运行更简单。
   ```
   $ docker run -d \
       --name=registrator \
       --net=host \
       --volume=/var/run/docker.sock:/tmp/docker.sock \
       gliderlabs/registrator:latest \
         consul://localhost:8500
   ```
   --volume=/var/run/docker.sock:/tmp/docker.sock可以让Registrator访问DockerAPI；
   --net=host有助于Registrator获得主机级IP和主机名；
   consul://localhost:8500是服务注册中心URI。
3. 运行其他服务的容器
   `$ docker run -d -P --name=redis redis` 
   Registrator通过Docker API可以监听Docker容器的启动/关闭，并自动注册/注销服务:
   ```
   $ curl $(boot2docker ip):8500/v1/catalog/services
   {"consul":[],"redis":[]}
   
   $ curl $(boot2docker ip):8500/v1/catalog/service/redis
   [{"Node":"boot2docker","Address":"10.0.2.15","ServiceID":"boot2docker:redis:6379","ServiceName":"redis","ServiceTags":null,"ServiceAddress":"","ServicePort":32768}]
   ```

### 参考

[Github：gliderlabs/registrator](https://github.com/gliderlabs/registrator)  
[Registrator Quickstart](http://gliderlabs.com/registrator/latest/user/quickstart/)  
[Docker Hub：gliderlabs/registrator](https://hub.docker.com/r/gliderlabs/registrator/)  
[Scalable Architecture DR CoN: Docker, Registrator, Consul, Consul Template and Nginx](https://www.airpair.com/scalable-architecture-with-docker-consul-and-nginx)  