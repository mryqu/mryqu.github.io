---
title: '使用Docker的现代十二要素应用'
date: 2015-06-04 05:26:36
categories: 
- Tool
- Docker
tags: 
- twelve-factor
- docker
- devops
---
【编者的话】“十二要素应用”为开发SaaS应用提供了方法上的指导，而Docker能够提供打包依赖，解耦后端服务等特性，使得两者非常吻合。这篇文章介绍了Docker特性怎样满足了开发“十二要素应用”的对应要点。Docker非常适合开发“十二要素应用”。

<blockquote>“十二要素应用”为构建SaaS应用提供了方法论，是由知名PaaS云计算平台Heroku的创始人AdamWiggins提出的。请参考这篇[文章](http://www.infoq.com/cn/news/2012/09/12-factor-app)。
</blockquote>

Dockerfile与docker-compose.yml正在成为用代码定义服务的标准，通过它们可以定义服务的所有内容：依赖、环境、端口、各种进程以及后端服务。Docker镜像和容器为操作系统提供了保证，使得开发环境和生产环境可以有效地保持一致。这篇文章简单地介绍了Docker是怎样满足“十二要素应用”的核心要点的。它解释了用Docker开发一个典型的“Rails/Postgres/Redis/web/worker”所应用的技术。后续文章将通过代码深入介绍如何应用这些技术。
### II. 依赖—显示地声明和隔离依赖关系
Docker镜像基于显示的Dockerfile构建，而Docker容器作为独立的运行环境。Dockerfile提供了显示声明基础操作系统的方法（FROM）,而且通过运行命令来安装附加的系统包以及应用的依赖包（RUN）。通过这些方法，你可以声明你需要ubuntu 14.04、Ruby 2.2.2、Node 0.11，然后一次性安装。
### III. 配置—在环境中储存配置
Docker容器非常依赖Linux的环境变量进行配置。docker-compose.yml有一个环境变量的哈希表，你可以通过它显示的定义容器的环境变量。这些默认的或者未定义的值将在运行时从主机中继承。另外，还有Dokckerfile的ENV命令以及『docker run –env=[]』和『docker run–env-file=[]』运行选项可以设置环境变量。通过这些方法，你可以声明你的应用需要环境变量GITHUB_AUTH_TOKEN。 
### VII. 端口绑定—通过端口绑定来提供服务
Docker非常依赖端口绑定。docker-compose.yml有一个端口阵列，可以通过它显示的定义“主机:容器”的端口绑定。『docker run –pHOST:CONTAINER』让你可以在运行时定义端口绑定。通过这些方法，你可以声明你的应用的网络服务器将监听端口5000，而且你可以通过主机的端口5000获取服务。
### IV. 后端服务—把后端服务当作附加资源
Docker容器与其它容器几乎完全隔离，所以需要通过网络与后端服务进行通信。docker-compse.yml有一个链接哈希表，你可以通过它指定你的应用所需要依赖的其他容器服务。‘docker-composeup’命令将首先开启这些后端服务，然后配置应用容器中网络连接信息的环境变量。通过这些方法，你可以声明你的应用需要Postgres 9.4和Redis3.0服务，让你的应用通过主机名和端口号与他们建立连接。
### VI. 进程—以一个或者多个无状态进程运行应用
默认情况下，Docker容器是不带储存的进程。docker-compose.yml定义了一系列服务，每一个服务都有自己的镜像或者构建文件(Dockerfile)以及命令。通过这些方法，你可以声明你的应用同时有一个网络进程和工作进程。
### XII. 管理进程—后台管理任务当做一次性进程运行
Docker镜像可以很容易地运行一次性进程。‘docker run myapp CMD’可以在与你的网络进程一致的环境中运行任意命令。通过这些方法，你可以基于你的Postgres数据库运行交互式的bash或者运行一次性的’rakedb:migrate’进程。
### 现有技术
若没有Docker，OS X的开发工具链是这样的：Homebrew作为系统依赖包， Postgres和Redis作为开发服务,Ruby的Bundler作为跨平台开发依赖，一系列的Shell脚本和foreman让所有工具在本地同时运行起来，以及一个独立的基于Linux的构建服务负责将应用打包到生产环境。这样的工作流并没有错误，但是Docker提供一个更简洁的方式。有了Dockerfile和docker-compose.yml文件，我们将不再需要任何OSX系统依赖，服务包或者跨平台的语言依赖。一个简单的“dicker-composeup”命令可以提供一个完整的Linux开发环境，并且能够轻易地将“十二要素应用”移植到生产机器。
- - -

原英文链接：[Modern Twelve-Factor Apps With Docker](https://medium.com/@nzoschke/modern-twelve-factor-apps-with-docker-55dd92c832b3)  
原译文链接：[现代“十二要素应用”与Docker](http://dockone.io/article/411)  
