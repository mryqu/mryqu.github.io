---
title: '非技术视角八卦一下docker'
date: 2015-05-01 10:03:21
categories: 
- Tool
- Docker
tags: 
- docker
- doucloud
- 容器
- 历史
- 竞争对手
---
2010年，几个大胡子年轻人在旧金山成立了一家做 PaaS平台的公司，起名为dotCloud。dotCloud是YCombinator（创投公司） S10的毕业生。![非技术视角八卦一下docker](/images/2015/5/0026uWfMgy6SBlo5D0Ucc.png)
创始人：[Solomon Hykes](https://www.linkedin.com/in/solomonhykes)
- 2006年毕业于EPITECH - European Institute of Technology(硕士)
- 2003-2004年做过个人IT教师
- 2006年曾经在SmartJog担任售后工程师
- 2010-2013年担任dotCloud的CEO
- 2013年至今担任dotCloud的CTO

dotCloud主要是基于 PaaS 平台为开发者或开发商提供技术服务。PaaS的概念虽好，但是由于认知、理念和技术的局限性，市场的接受度并不高，市场的规模也不够大。除 此之外，还有巨头不断进场搅局，IBM的蓝云，微软的 Azure，Amazon 的 EC2，Google 的 GAE，VMware 的 Cloud Foundry等等，可谓强敌环伺，而且强敌都不差钱，想玩多久就玩多久，想玩多大玩多大。在这种情况下，虽然 dotCloud在2011年初拿到了1000万美元的融资，但依然举步维艰。
Solomon Hykes在这种情况下，决定将自己的核心引擎开源，并让团队的核心成员参与开源项目。这个引擎的名字叫做Docker，以Go语言写成。Docker一经开源立刻得到了「业界」的热烈吹捧。这个容器管理引擎大大降低了容器技术的使用门槛，轻量级，可移植，虚拟化，语言无关，写了程序扔上去做成镜像可以随处部署和运行，Docker迅速从单纯的云端虚机限定资源环境转变成新的代码或应用发布形式，方便有集成开发、快速迭代需求的用户实现多次更新的回退和版本管理，开发、测试和生产环境彻底统一了，还能进行资源管控和虚拟化。
从此以后，他们开始专心研发 Docker 产品和维护相关社区。2013年10月 dotCloud公司更名为[Docker股份有限公司](https://www.docker.com/)，2014年8月Docker宣布把PAAS的业务「dotCloud」出售给位于德国柏林的平台即服务提供商「cloudControl」，dotCloud的历史告一段落。同年8月，Docker内部员工 James Turnbull 发布了面向开发者、运维和系统管理员的 Docker电子书《The DockerBook》。2014年9月，Docker 宣布已获 4000 万美元的 C 轮融资。
2014年6月，Microsoft Open Technology （微软开放技术）宣布 Azure开始支持Docker部署；2014年10月，微软宣布下一个版本的WindowsServer将原生支持Docker；2014年11月，AWS加码押注Docker，推出了高性能容器管理服务EC2Container服务，用户可以在AWS上使用容器轻松地运行和管理分布式应用；2014年12月，Docker宣布发布跨容器的分布式应用编排服务，编排服务可以帮助开发者创建并管理新一代的可移植的分布式应用程序。
Docker的竞争对手是CoreOS公司的容器技术Rocket，现在Rocket得到谷歌、Red Hat以及 VMware等一批大公司的支持。

### 参考

[Docker 传奇之 dotCloud](http://www.oschina.net/news/57838/docker-dotcloud)    
[Docker，云时代的程序交付方式](http://www.tucaobj.com/note/os/201408120731364392.jhtml)    
[Docker项目研究](http://www.jianshu.com/p/014d6f6c1b08)    
[Docker之父Solomon Hykes谈项目开发的初衷和挑战](http://www.csdn.net/article/2014-10-30/2822366-the-new-stack-makers-docker-creator-solomon-hykes)    
[解读2014之Docker篇：才气、勇气、运气](http://www.infoq.com/cn/articles/2014-review-docker)    
[八个Docker的真实应用场景](http://dockone.io/article/126)    
[Google支持Docker的竞争对手，云计算恩怨又起](http://www.leiphone.com/news/201505/afco7IrxTn0QciAT.html)    