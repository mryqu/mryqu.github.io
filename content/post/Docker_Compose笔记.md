---
title: 'Docker Compose笔记'
date: 2015-06-06 05:33:22
categories: 
- Tool
- Docker
tags: 
- docker
- compose
- multi-container
- devops
---
### Docker Compose概述

<table style="border: none !important; background: transparent !important; background-color: rgba(0, 0, 0, 0.0) !important; margin: 0 !important; padding: 0 !important;"><tr><td style="border: none !important; background: transparent !important; background-color: rgba(0, 0, 0, 0.0) !important; margin: 0 !important; padding: 0 !important; text-align:center">**DockerCompose**<br><img src="/content/images/2015/6/0026uWfMgy6VRybrJv290.png" style="border: none !important; height: 66px !important;"></td><td style="border: none !important; background: transparent !important; background-color: rgba(0, 0, 0, 0.0) !important; margin: 0 !important; padding: 0 !important; text-align:center">**前身 Fig**<br><img src="/content/images/2015/6/0026uWfMgy6VRyadtqe86.png" style="border: none !important; height: 66px !important;"></td></table>
Compose是用于在Docker内定义和运行多容器应用程序的工具。使用Compose，可以在一个文件内定义多容器应用程序，然后使用一个命令运行应用。
Compose对开发环境、交付准备服务器（stagingservers）和持续集成（CI）很有帮助，不建议用于生产环境。
使用Compose基本上是三步流程：
- 通过一个`Dockerfile`定义应用环境，以便在其他地方复制；
- 在`docker-compose.yml`中定义组成应用的服务，因此他们可以在一个隔离的环境一起运行；
- 最后，运行`docker-compose up`，Compose将启动并运行整个应用。

`docker-compose.yml`大概是这个样子的:
```
web:
  build: .
  ports:
   - "5000:5000"
  volumes:
   - .:/code
  links:
   - redis
redis:
  image: redis
```
Compose包含管理应用整个生命周期的命令:
- 启动、停止和重建服务
- 查看运行的服务状态
- 对运行的服务的日志输出生成数据流
- 对一个服务运行一次性命令

### Docker Compose安装
```
curl -L https://github.com/docker/compose/releases/download/VERSION_NUM/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
$ chmod +x /usr/local/bin/docker-compose
```

### Docker Compose命令

![Docker Compose笔记](/images/2015/6/0026uWfMgy6VSUpAxdW54.png)

#### 更新整个应用

```
mryqu$ docker-compose stop   # stop the containers
mryqu$ docker-compose pull   # download updated images
mryqu# docker-compose up -d  # creates new containers and starts them
```

#### 更新单个服务
```
mryqu$ docker-compose stop foo    # stop the foo service
mryqu$ docker-compose pull foo    # download foo service
mryqu$ docker-compose up -d foo   # start the new foo service
```

### 参考

[Overview of Docker Compose](https://docs.docker.com/compose/)  
[GitHub：docker/compose](https://github.com/docker/compose)    
[Fig](http://www.fig.sh/)    