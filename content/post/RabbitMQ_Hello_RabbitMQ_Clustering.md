---
title: '[RabbitMQ] Hello RabbitMQ Clustering'
date: 2016-08-08 05:58:43
categories: 
- Service+JavaEE
- MQ
tags: 
- rabbitmq
- clustering
- 集群
- 配置
- 手工
---
RabbitMQ集群文档的介绍是：
一个RabbitMQ代理（broker）是一或多个Erlang节点的逻辑组合，每个节点运行RabbitMQ应用并共享用户、虚拟主机、队列、交换器、绑定和运行时参数。有时我们将节点集合称之为集群。
对RabbitMQ代理操作所需的所有数据/状态都会在所有节点上复制。唯一的例外是消息队列，默认存在于创建队列的节点上，但是对所有其他节点可见并可访问。集群内节点通过主机名互相通信，所以这些主机名必须能被集群内所有节点解析。

### 在Ubuntu上安装RabbitMQ

我在三台Ubuntu服务器上安装了RabbitMQ，分别是node50064，node50069和node51054。

- 执行下列命令将APT仓库添加到/etc/apt/sources.list.d:
  ```
  echo 'deb http://www.rabbitmq.com/debian/ testing main' |
        sudo tee /etc/apt/sources.list.d/rabbitmq.list
  ```
- (可选地)为了避免未签名包告警，使用 apt-key将RabbitMQ网站的公钥添加到信赖密钥列表：
  ```
  wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc |
        sudo apt-key add -
  ```
- 执行下列命令更新包列表：
  ```
  sudo apt-get update
  ```
- 安装rabbitmq-server包：
  ```
  sudo apt-get install rabbitmq-server
  ```

配置RabbitMQ
- 修改/etc/rabbitmq/enabled_plugins使能管理插件：
  ```
  [rabbitmq_management].
  ```
- 修改/etc/default/rabbitmq-server，增大每用户可打开文件数（我的系统不使用systemd，无需修改/etc/systemd/system/rabbitmq-server.service.d/limits.conf）：
  ```
  ulimit -S -n 4096
  ```
- 修改/etc/rabbitmq/rabbitmq-env.conf，激活长主机名并使用每个主机的完整域名作为本地节点名：
  ```
  USE_LONGNAME=true
  NODENAME=rabbit@`env hostname -f`
  ```

关闭RabbitMQ：
```
sudo /etc/init.d/rabbitmq-server stop
```

### 配置RabbitMQ集群

首先启动node50064上的RabbitMQ（注：会有告警，可忽略。-detached选项就会导致PID不写入PID文件。）：
```
sudo rabbitmq-server -detached
```
RabbitMQ节点和CLI工具(例如rabbitmqctl)使用cookie来判断节点间是否可以通信。两个能够通信的节点必须拥有相同的共享密文，称之为Erlangcookie。集群中所有节点必须拥有相同cookie。必须在node50069和node51054关闭RabbitMQ的情况下，从node50064将其cookie复制到node50069（对node51054也做相同操作）：
![[RabbitMQ] Hello RabbitMQ Clustering](/images/2016/8/0026uWfMzy754DMOLh4ee.jpg) 更省事的方式，是在node50069和node51054没有安装RabbitMQ之前就将node50064上的cookie复制过来，这样node50069和node51054上的erlang节点就不会自己生成cookie了。

手工配置集群：
```
ubuntu@node50069:~$sudo rabbitmq-server -detached
ubuntu@node50069:~$sudo rabbitmqctl stop_app
ubuntu@node50069:~$sudo rabbitmqctl join_cluster rabbit@node50064.mryqu.com
ubuntu@node50069:~$sudo rabbitmqctl start_app

ubuntu@node51054:~$sudo rabbitmq-server -detached
ubuntu@node51054:~$sudo rabbitmqctl stop_app
ubuntu@node51054:~$sudo rabbitmqctl join_cluster rabbit@node50064.mryqu.com
ubuntu@node51054:~$sudo rabbitmqctl start_app
```

验证集群状态：![[RabbitMQ] Hello RabbitMQ Clustering](/images/2016/8/0026uWfMzy75aNJHmCqfe.png)
管理UI：![[RabbitMQ] Hello RabbitMQ Clustering](/images/2016/8/0026uWfMzy75aQdNFo03c.jpg)

### 参考

[RabbitMQ Clustering Guide](http://www.rabbitmq.com/clustering.html)    
[Installing RabbitMQ on Debian / Ubuntu](http://www.rabbitmq.com/install-debian.html)    
[Hello RabbitMQ](/post/rabbitmq_hello_rabbitmq)    