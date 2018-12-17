---
title: 'Consul实践'
date: 2015-06-14 23:08:40
categories: 
- Tool
- Consul
tags: 
- consul
- 服务注册
- 服务发现
- 服务配置
- 服务编排
---
#### Consul简介

最近除了在用Hashicorp公司的Vagrant，也使用了[Consul](https://www.consul.io/)。[Consul](https://www.consul.io/)是一款以跨数据中心、高可用的方式提供服务注册、发现、配置和编排的工具。Consul可以用来回答一个企业的基础设施中，诸如下列这些问题：

- “服务X在哪里”
- “服务Y的实例是否健康”
- “当前正在运行的服务是什么”
- “服务Z的配置是怎样的”
- “在我的平台上是否还有其他人在执行操作A？”

Consul通过DNS或HTTP API提供服务发现功能，同时支持跨数据中心的内部服务或外部服务的发现。使用shell脚本实现了健康检查，并允许创建自定义的服务验证协议。Consul还提供了高可用的键值对存储，由此可以暴露一致的存储值，用于配置参数的调优，而不必非要执行配置管理工具。可调优的操动实例包括指定服务的位置、指明系统处于维护模式，或者设置服务的QoS参数。Consul还提供了一套编排原语、通过UDP协议跨数据中心广播异步“事件”、通过TCP协议让指定的计算机同步执行“exec”指令，以及通过实现长轮询、react、事件机制或者其他操作实现定制化的监控。

#### 安装Consul

```
echo Installing dependencies...
sudo apt-get install -y unzip curl
echo Fetching Consul...
cd /tmp/
wget https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip -O consul.zip
echo Installing Consul...
unzip consul.zip
sudo chmod +x consul
sudo mv consul /usr/mryqu/consul
echo Fetching Consul UI...
cd /tmp/
wget https://dl.bintray.com/mitchellh/consul/0.5.2_web_ui.zip -O dist.zip
echo Installing Consul UI...
unzip dist.zip
sudo chmod +x dist
sudo mv dist /usr/mryqu/consul/dist
```

#### 引导一个数据中心

首先以服务器模式运行第一个Consul代理。Consul需要使用-bootstrap-expect指定集群节点个数，使用-data-dirparameter指定一个数据目录名，使用-ui-dir参数指定Consul UI目录:
```
$>consul agent -server -bootstrap-expect 1 -data-dir /usr/mryqu/consul/consuldata -ui-dir /usr/mryqu/consul/dist
```
UI默认地址是http://localhost:8500/ui
如果UI没有启动，需要添加额外的-client 0.0.0.0参数重启Consult代理。

#### 注册服务

服务定义是最常用的注册服务的方式。下面是注册一个名为vmstat的服务定义示例：
```
$>echo ‘{“service”: {“name”: “vmstat”,”tags”:[“master”],”address”: “127.0.0.1”,”port”: 8012,”checks”:[{“script”: “/usr/mryqu/consul/scripts/chkvm.sh”,”interval”: “10s”} ]}} ‘ \ > /usr/mryqu/consul/services/vm.json
```
重启consul并指定服务目录.
```
$>consul agent -server -client 0.0.0.0 -bootstrap-expect 1 -data-dir /usr/mryqu/consul/consuldata -ui-dir /usr/mryqu/consul/dist -config-dir /usr/mryqu/consul/services
```
通过日志可以发现该服务已被同步。
```
[INFO] agent: Synced service ‘vmstat’
[INFO] agent: Synced check ‘service:vmstat’
```
Consul UI http://localhost:8500/ui/ 显示如下：
![Consul实践](/images/2015/6/0026uWfMgy6T4bdWupRdb.png)

### 参考

[Consul官网](https://www.consul.io/)  
[Consul介绍](http://www.consul.io/intro/index.html)  
[Consul指南](http://www.consul.io/docs/guides/index.html)  
[Vagrant Consul Demo](https://github.com/hashicorp/consul/tree/master/demo/vagrant-cluster)  