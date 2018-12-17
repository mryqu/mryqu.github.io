---
title: 'Docker速查笔记'
date: 2015-06-02 22:16:06
categories: 
- Tool
- Docker
tags: 
- docker
- 速查表
- 命令
- dockerfile
- 笔记
---
![Docker速查笔记](/images/2015/6/0026uWfMgy6ThXuVivB67.jpg)
### 常用命令

#### 登入运行的docker容器内
```
docker exec -it $dockerContainerName /bin/bash
```

#### 查看docker日志
```
docker logs --tail="5" -f $dockerContainerName
```

#### 清除容器及镜像
```
docker stop $(docker ps -a -q)  #停止所有容器
docker rm $(docker ps -a -q)     #删除所有容器
docker rmi $(docker images -q)  #删除所有镜像
```

### 参考

[Docker Cheat Sheet](https://github.com/wsargent/docker-cheat-sheet)    
[Docker Command Line](https://docs.docker.com/reference/commandline/cli/)    
[Dockerfile reference](https://docs.docker.com/reference/builder/#the-dockerignore-file)    
[The Docker Book](http://www.dockerbook.com/)    