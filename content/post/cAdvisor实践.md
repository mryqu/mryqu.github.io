---
title: 'cAdvisor实践'
date: 2015-06-11 00:40:08
categories: 
- Tool
- Docker
tags: 
- cadvisor
- docker
- devops
---
![cAdvisor实践](/images/2015/6/0026uWfMgy6TbmyhptIae.jpg)
cAdvisor (Container Advisor)为运行容器的用户提供出色的资源使用和性能特征。这是一个运行守护进程，能够搜集、集料、处理和导出运行中的容器的信息。特别需要指出，每个容器都有资源隔离参数、历史资源使用、以及完整历史数据的柱状图。
cAdvisor目前支持[Docker](https://github.com/docker/docker)容器和[lmctfy](https://github.com/google/lmctfy)容器。

### 运行cAdvisor容器

![cAdvisor实践](/images/2015/6/0026uWfMgy6TbpsoYWg2c.jpg)

### 配置boot2docker与宿主机之间的端口转移

![cAdvisor实践](/images/2015/6/0026uWfMgy6TbpsC81210.jpg)

### 查看cAdvisor

![cAdvisor实践](/images/2015/6/0026uWfMgy6TbpsSKyZ61.jpg)

### 参考

[GitHub：cAdvisor](https://github.com/google/cadvisor)  