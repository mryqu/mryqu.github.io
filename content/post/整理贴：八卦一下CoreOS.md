---
title: '整理贴：八卦一下CoreOS'
date: 2015-07-17 06:10:11
categories: 
- Tool
tags: 
- coreos
- 容器
- docker
- rkt
- devops
---
CoreOS是一个轻量级容器化Linux发行版，专为大型数据中心而设计，旨在通过轻量的系统架构和灵活的应用程序部署能力简化数据中心的维护成本和复杂度。

### CoreOS的历史

2013年2月，美国的dotCloud公司发布了一款新型的Linux容器软件Docker，并建立了一个网站发布它的首个演示版本（见[Docker第一篇官方博客](http://blog.docker.com/2013/02/first-demo-video-containerizing-postgres-9/)）。而几乎同时，2013年3月，美国加州，年轻的帅小伙Alex Polvi正在自己的车库开始他的[第二次创业](http://www.csdn.net/article/2013-08-22/2816672-coreos-the-new-linux)。此前，他的首个创业公司Cloudkick卖给了云计算巨头Rackspcace（就是OpenStack的东家）。
有了第一桶金的Alex这次准备干一票大的，他计划开发一个足以颠覆传统的服务器系统的Linux发行版。为了提供能够从任意操作系统版本稳定无缝地升级到最新版系统的能力，Alex急需解决应用程序与操作系统之间的耦合问题。因此，当时还名不见经传的Docker容器引起了他的注意，凭着敏锐直觉，Alex预见了这个项目的价值，当仁不让地将Docker做为了这个系统支持的第一套应用程序隔离方案。不久以后，他们成立了以自己的系统发行版命名的组织：CoreOS。事实证明，采用Docker这个决定，后来很大程度上成就了CoreOS的生态系统。
![Alex Polvi](/images/2015/7/0026uWfMgy6UZkEQe7Jb7.jpg)

### CoreOS特点

首先，CoreOS没有提供包管理工具，而是通过容器化的运算环境向应用程序提供运算资源。应用程序之间共享系统内核和资源，但是彼此之间又互不可见。这样就意味着应用程序将不会再被直接安装到操作系统中，而是通过Docker 运行在容器中。这种方式使得操作系统、应用程序及运行环境之间的耦合度大大降低。相对于传统的部署方式而言，在 CoreOS集群中部署应用程序更加灵活便捷，应用程序运行环境之间的干扰更少，而且操作系统自身的维护也更加容易。
其次， CoreOS 采用双系统分区 (dual root partition)设计。两个分区分别被设置成主动模式和被动模式并在系统运行期间各司其职。主动分区负责系统运行，被动分区负责系统升级。一旦新版本的操作系统被发布，一个完整的系统文件将被下载至被动分区，并在系统下一次重启时从新版本分区启动，原来的被动分区将切换为主动分区，而之前的主动分区则被切换为被动分区，两个分区扮演的角色将相互对调。同时在系统运行期间系统分区被设置成只读状态，这样也确保了CoreOS 的安全性。CoreOS 的升级过程在默认条件下将自动完成，并且通过 cgroup对升级过程中使用到的网络和磁盘资源进行限制，将系统升级所带来的影响降至最低。
另外，CoreOS 使用 Systemd 取代 SysV 作为系统和服务的管理工具。与 SysV 相比，Systemd不但可以更好的追踪系统进程，而且也具备优秀的并行化处理能力，加之按需启动等特点，并结合 Docker 的快速启动能力，在 CoreOS集群中大规模部署 Docker容器与使用其他操作系统相比在性能上的优势将更加明显。Systemd 的另一个特点是引入了“target” 的概念，每个 target 应用于一个特定的服务，并且可以通过继承一个已有的 target扩展额外的功能，这样使得操作系统对系统上运行的服务拥有更好的控制力。
通过对系统结构的重新设计，CoreOS剔除了任何不必要的软件和服务。在一定程度上减轻了维护一个服务器集群的复杂度，帮助用户从繁琐的系统及软件维护工作中解脱出来。虽然CoreOS最初源自于Google ChromeOS，但是从一开始就决定了 CoreOS更加适合应用于一个集群环境而不是一个传统的服务器操作系统。
![整理贴：八卦一下CoreOS](/images/2015/7/0026uWfMgy6UZNnjyjy3c.png)

### CoreOS相关工具

除了操作系统之外，CoreOS 团队和其他团队还提供了若干工具帮助用户管理 CoreOS 集群以及部署Docker容器。

#### etcd

![整理贴：八卦一下CoreOS](/images/2015/7/0026uWfMgy6UZNGnGqk10.png)
在CoreOS 集群中处于骨架地位的是 [etcd](https://github.com/coreos/etcd)。 etcd 是一个分布式 key/value存储服务，CoreOS 集群中的程序和服务可以通过 etcd 共享信息或做服务发现 。etcd 基于非常著名的 raft一致性算法：通过选举形式在服务器之中选举 Lead 来同步数据，并以此确保集群之内信息始终一致和可用。etcd 以默认的形式安装于每个CoreOS 系统之中。在默认的配置下，etcd使用系统中的两个端口：4001和7001，其中4001提供给外部应用程序以HTTP+Json的形式读写数据，而7001则用作在每个etcd 之间进行数据同步。用户更可以通过配置 CA Cert让 etcd 以 HTTPS的方式读写及同步数据，进一步确保数据信息的安全性。

#### fleet

[fleet](https://github.com/coreos/fleet) 是一个通过Systemd对CoreOS 集群中进行控制和管理的工具。fleet 与 Systemd 之间通过 D-Bus API 进行交互，每个fleet agent 之间通过 etcd 服务来注册和同步数据。fleet提供的功能非常丰富，包括查看集群中服务器的状态、启动或终止 Docker容器、读取日志内容等。更为重要的是 fleet可以确保集群中的服务一直处于可用状态。当出现某个通过 fleet创建的服务在集群中不可用时，如由于某台主机因为硬件或网络故障从集群中脱离时，原本运行在这台服务器中的一系列服务将通过fleet被重新分配到其他可用服务器中。虽然当前 fleet 还处于非常早期的状态，但是其管理 CoreOS集群的能力是非常有效的，并且仍然有很大的扩展空间，目前已提供简单的 API 接口供用户集成。

#### Kubernetes

[Kuberenetes](https://github.com/GoogleCloudPlatform/kubernetes) 是由Google 开源的一个适用于集群的Docker容器管理工具。用户可以将一组容器以 “POD” 形式通过 Kubernetes部署到集群之中。与 fleet 更加侧重 CoreOS 集群的管理不同，Kubernetes生来就是一个 容器的管理工具。Kubernetes 以“POD” 为单位管理一系列彼此联系的容器，这些容器被部署在同一台物理主机中、拥有同样地网络地址并共享存储配额。

#### flannel (rudder)

[flannel](https://github.com/coreos/flannel) (rudder)是 CoreOS 团队针对 Kubernetes 设计的一个覆盖网络 (overlay network)工具，其目的在于帮助每一个使用 Kuberentes 的 CoreOS 主机拥有一个完整的子网。Kubernetes 会为每一个POD 分配一个独立的 IP 地址，这样便于同一个 POD 中的容器彼此连接，而之前的 CoreOS并不具备这种能力。为了解决这一问题，flannel 通过在集群中创建一个覆盖网格网络 (overlay mesh network)为主机设定一个子网。

### CoreOS公司和Docker公司之争

Docker可能成为容器技术的代名词，但它不是唯一的容器技术，而且不是所有人都认为它应该成为容器技术的标准。2014年12月，CoreOS宣布推出自己的容器技术（rkt，刚开始叫rocket）和格式（appc），这个项目得到了一些主要参与者如谷歌、RedHat和VMware的支持。CoreOS公司与Docker公司决裂了。
两家公司竞争的焦点集中在容器编排平台上。编排平台提供了一套工具，用来部署和管理大量的容器，把这些容器联网，共同组成一个以容器为基础的软件基础设施。Linux 容器本身非常适合用作开发平台，如果以容器为基础构建整个软件栈，还需要提供几类编排工具，包括：
- 容器调度器：把容器部署到物理服务器上；
- 集群信息存储：容器数据的共享和协调；
- 软件定义网络：容器联网；
- 资源管理和监控等。

容器领域的所有公司好像都把编排作为自己产品与众不同的关键点，希望凭借这一点建立影响和寻求回报。除了 CoreOS 公司和 Docker公司，[Red Hat 公司的 Project Atomic](http://www.projectatomic.io/)、[Ubuntu 的 Snappy Core](http://developer.ubuntu.com/en/snappy/)、[Joyent 公司的 Triton](https://www.joyent.com/blog/triton-docker-and-the-best-of-all-worlds)和[Apache Mesos 项目](http://mesos.apache.org/)都是容器编排领域强有力的竞争者。尤其值得注意的是， Microsoft 公司宣布： 2016 年， WindowsServer 和 .net 用户将可以使用[Windows 容器](http://blogs.technet.com/b/server-cloud/archive/2015/04/08/microsoft-announces-new-container-technologies-for-the-next-generation-cloud.aspx)。
上个月，在Linux基金会的安排下，这两家公司将与谷歌、微软、 亚马逊等其他利益相关者携手共进，联手打造[开放容器技术项目（OCP）](http://www.opencontainers.org/)。OCP是一个非营利性组织，其受特许建立通用的容器软件技术标准。

### CoreOS试用

如果想要尝试CoreOS的话, 可以使用虚拟机进行安装实验.
- 安装VirtualBox
- 安装[Vagrant](http://prisoner.github.io/2013/08/30/vagrant.html)
- 运行:
   ```
   git clone https//github.com/coreos/coreos-vagrant/
   cd coreos-vagrant
   vagrant up
   vagrant ssh
   ```

### 参考

[CoreOS官网](https://coreos.com)  
[Linux黑客车库创业：服务器操作系统CoreOS颠覆互联网](http://www.csdn.net/article/2013-08-22/2816672-coreos-the-new-linux)  
[漫步云端：CoreOS实践指南（一）](http://www.csdn.net/article/2014-12-29/2823356)  
[CoreOS实践指南（二）：架设CoreOS集群](http://www.csdn.net/article/2015-01-04/2823399)  
[CoreOS实践指南（三）：系统服务管家Systemd](http://www.csdn.net/article/2015-01-08/2823477)  
[CoreOS实践指南（四）：集群的指挥所Fleet](http://www.csdn.net/article/2015-01-14/2823554)  
[CoreOS实践指南（五）：分布式数据存储Etcd（上）](http://www.csdn.net/article/2015-01-22/2823659)  
[CoreOS实践指南（六）：分布式数据存储Etcd（下）](http://www.csdn.net/article/2015-01-28/2823739)  
[CoreOS实践指南（七）：Docker容器管理服务](http://www.csdn.net/article/2015-02-11/2823925)  
[CoreOS实践指南（八）：Unit文件详解](http://www.csdn.net/article/2015-02-27/2824034)  
[CoreOS实践指南（九）：在CoreOS上的应用服务实践（上）](http://www.csdn.net/article/2015-03-06/2824128)  
[CoreOS实践指南（十）：在CoreOS上的应用服务实践（下）](http://my.oschina.net/freyr/blog/415779)  
[CoreOS 实战](http://www.infoq.com/cn/coreosaction/)  