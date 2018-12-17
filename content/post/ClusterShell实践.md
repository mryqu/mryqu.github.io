---
title: 'ClusterShell实践'
date: 2014-01-07 20:47:23
categories: 
- Tool
- Linux
tags: 
- clustershell
- linux
- clush
- clubak
- nodeset
---
## ClusterShell介绍

[ClusterShell](https://github.com/cea-hpc/clustershell)提供了一个轻量级、统一和健壮的命令执行Python框架，非常适于减轻Linux集群日常管理任务负担。[ClusterShell](https://github.com/cea-hpc/clustershell)的好处如下：
- 提供高效、并行和高可扩展的Python命令执行引擎。
- 提供统一节点组语法和对外部组的访问
- 当使用clush和nodeset等工具可有效提升集群创建和日常管理任务的效率

## ClusterShell实践

### 安装

首先在集群内节点配置无密钥ssh访问。然后在主/工作节点上安装ClusterShell。
```
apt-get install clustershell
```

### 配置和实践
![ClusterShell实践](/images/2014/1/0026uWfMzy79uMIrCMv3f.png)

## ClusterShell工具

[ClusterShell](https://github.com/cea-hpc/clustershell)包含如下工具：
- [clush](http://clustershell.readthedocs.io/en/latest/tools/clush.html)[帮助文档](https://linux.die.net/man/1/clush)
- [clubak](http://clustershell.readthedocs.io/en/latest/tools/clubak.html)[帮助文档](https://linux.die.net/man/1/clubak)
- [nodeset](http://clustershell.readthedocs.io/en/latest/tools/nodeset.html)[cluset](http://clustershell.readthedocs.io/en/latest/tools/cluset.html)[帮助文档](https://linux.die.net/man/1/nodeset)

[ClusterShell](https://github.com/cea-hpc/clustershell)在线文档为[http://clustershell.readthedocs.io/](http://clustershell.readthedocs.io/)。
