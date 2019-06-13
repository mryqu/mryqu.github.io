---
title: '[RabbitMQ] 强制杀死RabbitMQ进程'
date: 2016-08-11 05:10:09
categories: 
- Service+JavaEE
- MQ
tags: 
- kill
- rabbitmq-server
- process
- linux
---
- 首先，尝试使用init.d脚本优雅关闭RabbitMQ
  ```
  sudo /etc/init.d/rabbitmq-server stop
  ```
- 如果不成功的话，使用
  ```
  ps -eaf | grep erl
  ```
  查看进程及父进程ID。输出第三列为父进程ID。找到仍是erlang进程（而不是启动进程的shell脚本）的第一个祖先进程，杀死它，这会同样终止其他子进程。![[RabbitMQ] 强制杀死RabbitMQ进程](/images/2016/8/0026uWfMzy75aISYaX577.jpg)上述示例中进程1301为"/bin/sh -e/usr/lib/rabbitmq/bin/rabbitmq-server"，已经不是erlang进程了，所以杀死进程1587就可以了。对于目前的RabbitMQ版本，可直接使用：
  ```
  sudo pkill beam.smp
  ```
