---
title: '[RabbitMQ] 了解多个同名rabbitmq-server文件'
date: 2016-08-12 06:13:28
categories: 
- Service+JavaEE
- MQ
tags: 
- rabbitmq-server
- 同名
- 文件
- 介绍
---
安装完RabbitMQ后，查了查机器中多了六个rabbitmq-server文件，除了两个位于/usr/lib/rabbitmq目录下的可以不理，其他都有什么区别呢？
![[RabbitMQ] 了解多个同名rabbitmq-server文件](/images/2016/8/0026uWfMzy75aTu8gqF75.jpg)
下面针对这四个文件进行一下介绍：
- /etc/init.d/rabbitmq-server： RabbitMQ服务器的开机自启动脚本
- /usr/sbin/rabbitmq-server： init脚本所启动的主服务器程序脚本
- /etc/logrotate.d/rabbitmq-server：logrotate是个十分有用的工具，它可以自动对日志进行截断（或轮循）、压缩以及删除旧的日志文件。该文件是针对rabbitmq-server的logrotate配置，默认情况下logrotate每周对/var/log/rabbitmq/下的log文件进行处理。
- /usr/lib/ocf/resource.d/rabbitmq/rabbitmq-server：OCF指开放集群框架（Open Clustering Framework）。当使用[pacemaker](https://www.rabbitmq.com/pacemaker.html)配置RabbitMQHA时，作为OCF 资源代理脚本，用于操作和监控RabbitMQ节点。OCF 规范（尤其是与资源代理相关的部分）详见在[Open Clustering Framework Resource Agent API](http://www.opencf.org/cgi-bin/viewcvs.cgi/specs/ra/resource-agent-api.txt?rev=HEAD&amp;content-type=text/vnd.viewcvs-markup)。