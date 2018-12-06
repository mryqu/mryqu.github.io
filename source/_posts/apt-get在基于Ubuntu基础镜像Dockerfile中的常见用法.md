---
title: 'apt-get在基于Ubuntu基础镜像Dockerfile中的常见用法'
date: 2015-07-05 21:32:25
categories: 
- Tool
- Docker
tags: 
- dockerfile
- ubuntu
- apt-get
- debian_frontend
- devops
---
首先，在Ubuntu的Docker官方镜像中是没有缓存Apt的软件包列表的。因此在做其他任何基础软件的安装前，都需要至少先做一次`apt-get update`。
有时为了加快apt-get安装软件的速度，还需要修改Apt源的列表文件`/etc/apt/sources.list`。相应的操作用命令表示如下：
```
# 使用Ubuntu官方的Apt源，也可以根据实际需要修改为国内源的地址
echo "deb http://archive.ubuntu.com/ubuntu trusty main universe\n" > /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe\n" >> /etc/apt/sources.list
```

在容器构建时，为了避免使用`apt-get install`安装基础软件的过程中需要进行的交互操作，使用`-y`参数来避免安装非必须的文件，从而减小镜像的体积。
```
apt-get -y --no-install-recommends install
```

使用`apt-get autoremove`命令移除为了满足包依赖而安装的、但不再需要的包；使用`apt-get clean`命令清除所获得包文件的本地仓库。
DEBIAN_FRONTEND这个环境变量，告知操作系统应该从哪儿获得用户输入。如果设置为"noninteractive"，你就可以直接运行命令，而无需向用户请求输入（所有操作都是非交互式的）。这在运行apt-get命令的时候格外有用，因为它会不停的提示用户进行到了哪步并且需要不断确认。非交互模式会选择默认的选项并以最快的速度完成构建。请确保只在Dockerfile中调用的RUN命令中设置了该选项，而不是使用ENV命令进行全局的设置。因为ENV命令在整个容器运行过程中都会生效，所以当你通过BASH和容器进行交互时，如果进行了全局设置那就会出问题。
```
# 正确的做法 - 只为这个命令设置ENV变量
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3
# 错误地做法 - 为接下来的任何命令都设置ENV变量，包括正在运行地容器
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y python3
```

我的示例如下：
```
FROM ubuntu:trusty
MAINTAINER mryqu 
RUN \
 DEBIAN_FRONTEND=noninteractive apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get -y install wget curl && \
 DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && \
 DEBIAN_FRONTEND=noninteractive apt-get clean
```

### 参考

[Ubuntu manuals: apt-get man page](http://manpages.ubuntu.com/manpages/utopic/man8/apt-get.8.html)  
[使用Docker部署Python应用的一些最佳实践](http://dockone.io/article/185)  
[docker部署OpenStack API](http://niusmallnan.github.io/_build/html/_templates/docker/depoly_openstack_api.html)  