---
title: '[RabbitMQ] RabbitMQ笔记'
date: 2016-08-06 05:29:19
categories: 
- Service+JavaEE
tags: 
- rabbitmq
- queue
- exchange
- route
- topic
- clustering
---
### RabbitMQ介绍

RabbitMQ是基于高级消息队列协议的消息代理软件。RabiitMQ服务器由Erlang语言开发，客户端支持多种主流编程语言。
RabbitMQ由LShift和CohesiveFT合营公司Rabbit技术有限公司开发，在2010年4月被SpringSource收购，2013年5月归入Pivotal软件。
RabbitMQ项目包括：
- RabbitMQ交换服务器自身
- 用于HTTP、流文本定向消息协议(STOMP)和消息队列遥测传输协议(MQTT)的网关
- Java、.NET Framework和Erlang语言的AMQP客户端库
- 支持定制插件的插件平台，内建插件集合为:
  - Shovel插件，负责从一个消息代理（broker）向另一个移动/复制消息。
  - Federation插件，在消息代理之间有效共享消息(基于exchange这一级)
  - Management插件，监控和管理消息代理
  - STOMP插件，提供STOMP协议支持
  - MQTT插件，提供MQTT协议支持
  - LDAP插件，RabbitMQ通过外部LDAP服务器进行认证和授权

### 在Widnows平台安装RabbitMQ

根据[http://www.rabbitmq.com/install-windows.html](http://www.rabbitmq.com/install-windows.html)安装Erlang和RabbitMQ服务器，运行RabbitMQ安装程序时需要选择“**Runas Administrator**”，否则事后需要执行下列命令修正.erlang.cookie位置错误。
```
copy /Y %SystemRoot%\.erlang.cookie %HOMEDRIVE%%HOMEPATH%
```
设置环境变量（及安装并启动RabbitMQ服务）
```
SET　ERLANG_HOME=C:\tools\erl8.0
SET RABBITMQ_SERVER＝C:\tools\RabbitMQ_Server\rabbitmq_server-3.6.5
SET　RABBITMQ_BASE=C:\rabbitmq-data
ECHO []. > C:\rabbitmq-data\rabbitmq.config
%RABBITMQ_SERVER%\sbin\rabbitmq-service.bat install
%RABBITMQ_SERVER%\sbin\rabbitmq-service.bat start
```

#### 安装管理插件

rabbitmq-management插件提供用于管理和监控RabbitMQ服务器的基于HTTP的API，以及基于浏览器的界面和一个控制台工具rabbitmqadmin。功能包括：
- 声明、列举和删除exchange、queue、binding、用户、虚拟主机和权限。
- 监控队列长度、消息总速率和每通道速率、连接数据速率等。
- 发送和接受消息。
- 监控Erlang进程、文件描述符和内存使用。
- 导出/导入对象定义到JSON格式
- 强制关闭连接、清除队列。![[RabbitMQ] 在Widnows平台安装配置RabbitMQ](/images/2016/8/0026uWfMzy74vsO9YwJf5.jpg)

重启RabbitMQ后登录http://guest:guest@localhost:15672/ ，即可见到管理页面。
![[RabbitMQ] 在Widnows平台安装配置RabbitMQ](/images/2016/8/0026uWfMzy74vxtT5yC2e.jpg)

#### rabbitmqctl

通过rabbitmqctl创建一个管理员用户admin和一个对虚拟主机有读写权限的普通用户mryqu：
![[RabbitMQ] 在Widnows平台安装配置RabbitMQ](/images/2016/8/0026uWfMzy74wHf4qcEe8.png)
自建管理员用户admin的默认用户guest的区别在于：guest仅能本机访问RabbitMQ，除非在rabbitmq.config增加loopback_users设置。

#### 使用HTTP管理API

将配置导出成JSON格式：
```
curl -i -u guest:guest http://localhost:15672/api/definitions
```
![[RabbitMQ] 在Widnows平台安装配置RabbitMQ](/images/2016/8/0026uWfMzy74wO9zc3s3e.jpg)

#### 激活其他插件

例如激活shovel插件：
```
%RABBITMQ_SERVER%\sbin\rabbitmq-plugins.bat enable rabbitmq_shovel
%RABBITMQ_SERVER%\sbin\rabbitmq-plugins.bat enable rabbitmq_shovel_management
```

#### 测试RabbitMQ

使用[GETTING STARTED: Messaging with RabbitMQ](https://spring.io/guides/gs/messaging-rabbitmq/) 中的代码即可，由于我想试验非本机访问RabbitMQ，因此添加了application.properties：
```
spring.rabbitmq.host=rabbitmqServer
spring.rabbitmq.port=5672
spring.rabbitmq.username=mryqu
spring.rabbitmq.password=XXXXXXXXXXXXXX
```

#### 参考

[RabbitMQ - Installing on Windows](http://www.rabbitmq.com/install-windows.html)    
[RabbitMQ - Access Control (Authentication, Authorisation)](http://www.rabbitmq.com/access-control.html)    
[RabbitMQ - Windows Quirks](https://www.rabbitmq.com/windows-quirks.html)    
[RabbitMQ - plugins](https://www.rabbitmq.com/plugins.html)    
[RabbitMQ - Management Plugin](https://www.rabbitmq.com/management.html)    
[RabbitMQ - Shovel plugin](https://www.rabbitmq.com/shovel.html)    
[RabbitMQ - rabbitmqctl(1) manual page](https://www.rabbitmq.com/man/rabbitmqctl.1.man.html)    
[RabbitMQ Management HTTP API](https://cdn.rawgit.com/rabbitmq/rabbitmq-management/rabbitmq_v3_6_5/priv/www/api/index.html)    
[GETTING STARTED: Messaging with RabbitMQ](https://spring.io/guides/gs/messaging-rabbitmq/)    
[Spring AMQP](http://docs.spring.io/spring-amqp/reference/html/index.html)    
[RabbitMQ for Windows: Introduction](https://lostechies.com/derekgreer/2012/03/05/rabbitmq-for-windows-introduction/)    

### 了解多个同名rabbitmq-server文件

安装完RabbitMQ后，查了查机器中多了六个rabbitmq-server文件，除了两个位于/usr/lib/rabbitmq目录下的可以不理，其他都有什么区别呢？
![了解多个同名rabbitmq-server文件](/images/2016/8/0026uWfMzy75aTu8gqF75.jpg)
下面针对这四个文件进行一下介绍：
- /etc/init.d/rabbitmq-server：RabbitMQ服务器的开机自启动脚本
- /usr/sbin/rabbitmq-server：init脚本所启动的主服务器程序脚本
- /etc/logrotate.d/rabbitmq-server：logrotate是个十分有用的工具，它可以自动对日志进行截断（或轮循）、压缩以及删除旧的日志文件。该文件是针对rabbitmq-server的logrotate配置，默认情况下logrotate每周对/var/log/rabbitmq/下的log文件进行处理。
- /usr/lib/ocf/resource.d/rabbitmq/rabbitmq-server：OCF指开放集群框架（Open Clustering Framework）。当使用[pacemaker](https://www.rabbitmq.com/pacemaker.html) 配置RabbitMQHA时，作为OCF 资源代理脚本，用于操作和监控RabbitMQ节点。OCF 规范（尤其是与资源代理相关的部分）详见在[Open Clustering Framework Resource Agent API](http://www.opencf.org/cgi-bin/viewcvs.cgi/specs/ra/resource-agent-api.txt?rev=HEAD&amp;content-type=text/vnd.viewcvs-markup) 。

### 强制杀死RabbitMQ进程

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
  
### 学习RabbitMQ教程

为了快速入门RabbitMQ，我主要学习了下列参考中的两个链接：RabbitMQ教程和SpringAMQP范例。这里对所学教程做一个小笔记。

#### 准备工作

由于我不打算跑本机上的RabbitMQ服务器，所有对代码稍有修改。

TutorialConfiguration.java
```
public class TutorialConfiguration {
    public static final String HOST = "mryqu-rabbitmq-server";
    public static final String USERNAME = "mryqu";
    public static final String PASSWORD = "mryqu-pwd";
}
```

对原有代码进行修改
```
// factory.setHost("localhost");
factory.setHost(TutorialConfiguration.HOST);
factory.setUsername(TutorialConfiguration.USERNAME);
factory.setPassword(TutorialConfiguration.PASSWORD);
}
```

#### RabbitMQ函数

发布方和消费方首先要创建连接，通过连接创建通道。通过通道也可以声明交换器，也可以直接声明队列。
- 函数Exchange.DeclareOk exchangeDeclare(String exchange, Stringtype, boolean durable, boolean autoDelete, boolean internal, Maparguments)用于声明交换器。其中exchange为队列名；type为交换器类型，例如fanout、direct、header和topic，**注意无法改变已存在交换器的类型**；durable为true时为持久交换器，在服务器重启后仍将存在，默认为false；autoDelete为true时，当所有的消费者使用完交换器后，服务器会自动删除交换器。服务器必须为判断交换器未使用提供一个合理时延，起码允许客户端能够创建一个代理并将其与队列绑定。默认为false；internal为true时为内部交换器，客户端不能直接向其发布消息，默认为false。
- 函数Queue.DeclareOk queueDeclare(String queue, boolean durable,boolean exclusive, boolean autoDelete, Map arguments)用于声明队列，其中queue为队列名；durable为true时为持久队列，在服务器重启后仍将存在。默认为false；exclusive为true时为私有队列，仅在当前连接中可以访问队列，当连接关闭时删除该队列。默认为true；autoDelete为true时，当所有的消费者使用完队列后，服务器会自动删除队列。最后一个消费者可被显式取消或由于通道关闭而取消。如果队列从没有消费者，队列将不会被删除。应用可以像对普通队列一样使用Delete方法显式删除自动删除队列。默认为true。
函数Queue.BindOk queueBind(String queue, String exchange, StringroutingKey, Map arguments)用于通过路由关键字将队列与交换器进行绑定。

函数void basicPublish(String exchange, String routingKey, booleanmandatory, boolean immediate, BasicProperties props, byte[]body)用于发布者发布消息。其中exchange为交换器名；routingKey为路由关键字，使用默认交换器及命名队列时可直接设为队列名；mandatory标志告知服务器当消息无法路由到队列时如何处理。如果标志被设上，服务器通过一个Return方法返回无法路由的消息。如果标志为空，服务器就仅丢弃消息。默认为false；immediate标志告知服务器当消息无法立即路由到队列消费者时如何处理。如果标志被设上，服务器通过一个Return方法返回无法路由的消息。如果标志为空，服务器就将消息放入队列，但不保证消息最终被消费。默认为false；props可设置下列子属性（可参考com.rabbitmq.client.MessageProperties进行了解）：
```
public static class BasicProperties 
extends com.rabbitmq.client.impl.AMQBasicProperties {
  private String contentType; 
```

函数String basicConsume(String queue, boolean autoAck, StringconsumerTag, boolean noLocal, boolean exclusive, Map arguments,Consumercallback)用于消费者接收消息。其中queue为队列名；autoAck为true时，服务器当传递完消息即认为消息被确认。autoAck为false时，服务器必须等待显示确认；consumerTag为客户端生成的用于建立上下文的消费者标签。消费者标签仅对一个通道局部可见，因此两个客户端可以使用相同的消费者标签。如果该字段为空，则服务器将生成一个唯一标签。<font color="#FF0000">**如果一个标签已用于标识一个已有消费者，客户端不能在使用该函数时使用其值。**</font>标签仅对创建消费者所在的通道有效；noLocal为true的话，服务器不会将消息传递给发布消息的连接。默认为false；exclusive为true的话，请求排外消费者访问，即仅该消费者可以访问队列。客户端可能不会从已有活跃消费者的队列获得排外访问。默认为false。
消息消费者通过函数void basicQos(int prefetchSize, int prefetchCount,boolean global)指定服务质量。QoS可指定用于当前通道或连接的所有通道。机关QoS原则上施加于消息两端，当前仅对服务器有意义。客户端可以请求消息被提前发送，这样当客户端处理完一条消息，下一条消息已被收到本地，而不是此时从通道接收。预抓取可以提升性能。prefetchSize以字节为单位指定了预抓取窗口，服务器当消息大小等于小于prefetchSize（且满足其他预抓取限制）时提前发送消息。改值可以为0，即无限制。如果no-ack选项被设置时prefetchSize将被忽略。当客户端没有处理任何消息时，服务器必须忽略该选项（例如预抓取大小不限制向客户端发送单个消息的大小，仅当客户端仍有一或多个未应答消息时用于提前发送消息）。默认为0；prefetchCount为以消息个数指定预抓取窗口，可与prefetchSize联合使用。如果no-ack选项被设置时prefetchCount将被忽略。服务器可以提前发送少于prefetchCount个消息，而不能多发送；对于global，RabbitMQ重新解释了该字段。原规范指“默认QoS设置仅适用于当前通道。如果该字段被设置，将应用于整个连接”。而RabbitMQ将global=false解释为QoS设置仅应用于消费者（对通道的新消费者生效，已有消费者不受影响），global=true解释为QoS设置应用于通道。默认为false。

#### 教程一："Hello World!"

![[RabbitMQ] Hello RabbitMQ](/images/2016/8/0026uWfMzy74Q9fWBCbd3.png)
本教程中消息发布者和消费者直接通过一个命名队列“Hello”传递消息。

消息发布者：
```
private final static String QUEUE_NAME = "hello";
String message = "Hello World!";
channel.basicPublish("", QUEUE_NAME, null, message.getBytes("UTF-8"));
```

消息消费者：
```
private final static String QUEUE_NAME = "hello";
Consumer consumer = new DefaultConsumer(channel) {
  @Override
  public void handleDelivery(String consumerTag, Envelope envelope, AMQP.BasicProperties properties, byte[] body)
  throws IOException {
    String message = new String(body, "UTF-8");
    System.out.println(" [x] Received '" + message + "'");
  }
};
channel.basicConsume(QUEUE_NAME, true, consumer);
```

#### 教程二：工作队列

![[RabbitMQ] Hello RabbitMQ](/images/2016/8/0026uWfMzy74Q9BA4ok04.png)
本教程跟教程一的区别主要有以下几点：
- 教程一中消息发布者和消费者声明的队列为非持久性，而本教程中则为持久性；
- 教程一中消息发布者发布消息时未指定属性，而本教程中指定内容为纯文本、持久的消息
- 教程一中消息消费者消息时自动应答（autoAck或no-ack），而本教程中为非自动应答
- 本教程中消息消费者通过函数void basicQos(int prefetchSize)指定服务质量。由于前一条为非自动应答，因此本设置生效。预读取字节无限制，预读取消息个数为1，仅应用于消费者级别。
- 本教程中消息消费者通过Thread.sleep函数模拟耗时操作，并通过void basicAck(longdeliveryTag, boolean multiple)确认消息。
- 本教程中起了两个消息消费者，两个消息消费者交替处理发布者迅速发出的多个消息。

#### 教程三：订阅/发布

![[RabbitMQ] Hello RabbitMQ](/images/2016/8/0026uWfMzy74WXfT7Zt57.png)
上一教程工作队列中每个任务仅发送给一个消费者，而本教程中一个消息可被发给多个消费者。实现主要通过一个fanout类型的交换器完成。

#### 教程四：路由

![[RabbitMQ] Hello RabbitMQ](/images/2016/8/0026uWfMzy74WXIBxwm12.png)
上一教程中fanout类型的交换器将收到的消息广播给所有接收者，而本教程接收者将有选择地接收消息中感兴趣的那一部分。实现主要通过direct类型交换器完成，消费者将通道与交换器通过感兴趣的路由关键字绑定，发布者在使用basicPublish函数发布消息时需提供交换器、路由关键字和消息内容。

#### 教程五：主题

![[RabbitMQ] Hello RabbitMQ](/images/2016/8/0026uWfMzy74WXyqOdf6d.png)
上一教程的限制在于不能基于多个条件进行路由。本教程通过topic类型交换器完成复杂的路由。其中路由关键字为由点做分界符的词列表，\*代表一个词，#代表零或多个词。
例如路由关键词中第一个代表速度、第二个代表颜色，第三个代表物种：..。这里创建三个绑定：Q1与"\*.orange.\*"关键词绑定，Q2与关键词"\*.\*.rabbit"和"lazy.#"绑定。其意义为：Q1对所有桔色动物感兴趣，Q2希望获得所有关于兔子及所有关于缓慢动物的消息。
路由关键词设为"quick.orange.rabbit"的消息将会传给两个队列。路由关键词设为"lazy.orange.elephant"的消息也将会传给两个队列。路由关键词设为"quick.orange.fox"将仅会传给第一个队列，路由关键词设为"lazy.brown.fox"将仅会传给第二个队列。路由关键词设为"lazy.pink.rabbit"将仅会传给第二个队列一次，即使它匹配了两个绑定。路由关键词设为"quick.brown.fox"的消息没有匹配任何绑定，因此会被丢弃。路由关键词设为"orange"或"quick.orange.male.rabbit"也不会匹配任何绑定，将被丢弃。而路由关键词设为"lazy.orange.male.rabbit"即使有四个词，也能匹配最后一个绑定，并传给第二个队列。
如果路由关键词不包含\*和#字符，则等同direct类型。

#### 教程六：RPC

![[RabbitMQ] Hello RabbitMQ](/images/2016/8/0026uWfMzy74WXDJDeg38.png)
本教程借助消息属性中的replyTo和correlationId，完成响应与请求的匹配。

#### 参考

[RabbitMQ Tutorials](http://www.rabbitmq.com/getstarted.html)    
[Spring AMQP Samples](https://github.com/spring-projects/spring-amqp-samples)    
[GETTING STARTED: Messaging with RabbitMQ](https://spring.io/guides/gs/messaging-rabbitmq/)    
[Understanding AMQP](https://spring.io/understanding/AMQP)    
[Spring AMQP](http://docs.spring.io/spring-amqp/reference/html/index.html)    
[AMQP 0-9-1 Complete Reference Guide](http://www.rabbitmq.com/amqp-0-9-1-reference.html)    

### RabbitMQ Clustering

RabbitMQ集群文档的介绍是：
一个RabbitMQ代理（broker）是一或多个Erlang节点的逻辑组合，每个节点运行RabbitMQ应用并共享用户、虚拟主机、队列、交换器、绑定和运行时参数。有时我们将节点集合称之为集群。
对RabbitMQ代理操作所需的所有数据/状态都会在所有节点上复制。唯一的例外是消息队列，默认存在于创建队列的节点上，但是对所有其他节点可见并可访问。集群内节点通过主机名互相通信，所以这些主机名必须能被集群内所有节点解析。

#### 在Ubuntu上安装RabbitMQ

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

#### 配置RabbitMQ集群

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

#### 参考

[RabbitMQ Clustering Guide](http://www.rabbitmq.com/clustering.html)    
[Installing RabbitMQ on Debian / Ubuntu](http://www.rabbitmq.com/install-debian.html)    
[Hello RabbitMQ](/post/rabbitmq_hello_rabbitmq)   

### AutorecoveringConnection在连接恢复后才调用ShutdownListener

想玩一玩RabbitMQ中的ShutdownListener和RecoveryListener，又不想写自己的重连接逻辑，所以使用了ConnectionFactory类的setAutomaticRecoveryEnabled方法让其自动恢复连接。代码如下：
```
package com.yqu.rabbitmq;

import com.rabbitmq.client.*;

import java.io.IOException;

public class AutoRecoveryRecv {

  private final static String QUEUE_NAME = "hello";

  public static void main(String[] argv) throws Exception {
    try {
      ConnectionFactory factory = new ConnectionFactory();
      factory.setHost(ConnectionFactoryConfiguration.HOST);
      factory.setUsername(ConnectionFactoryConfiguration.USERNAME);
      factory.setPassword(ConnectionFactoryConfiguration.PASSWORD);
      factory.setAutomaticRecoveryEnabled(true);
      factory.setNetworkRecoveryInterval(10000);
      Connection connection = factory.newConnection();
      connection.addShutdownListener(new ShutdownListener() {
        @Override
        public void shutdownCompleted(ShutdownSignalException cause)
        {

          String hardError = "";
          String applInit = "";

          if (cause.isHardError()) {
            hardError = "connection";
          } else {
            hardError = "channel";
          }

          if (cause.isInitiatedByApplication()) {
            applInit = "application";
          } else {
            applInit = "broker";
          }

          System.out.println("Connectivity to MQ has failed.  It was caused by "
                  + applInit + " at the " + hardError
                  + " level.  Reason received " + cause.getReason());
        }
      });
      ((Recoverable)connection).addRecoveryListener(new RecoveryListener() {
        @Override
        public void handleRecovery(Recoverable recoverable) {
          if( recoverable instanceof Connection ) {
            System.out.println("Connection was recovered.");
          } else if ( recoverable instanceof Channel ) {
            int channelNumber = ((Channel) recoverable).getChannelNumber();
            System.out.println( "Connection to channel #" 
                   + channelNumber + " was recovered." );
          }
        }
      });
      Channel channel = connection.createChannel();

      channel.queueDeclare(QUEUE_NAME, false, false, false, null);
      System.out.println(" [*] Waiting for messages. To exit press CTRL+C");

      Consumer consumer = new DefaultConsumer(channel) {
        @Override
        public void handleDelivery(String consumerTag, Envelope envelope,
                                   AMQP.BasicProperties properties, byte[] body)
                throws IOException {
          String message = new String(body, "UTF-8");
          System.out.println(" [x] Received '" + message + "'");
        }
      };
      channel.basicConsume(QUEUE_NAME, true, consumer);
    }
    catch(Throwable t) {
      t.printStackTrace();
    }
  }
}
```

重启了RabbitMQ所在的服务器，然后获得下列日志，显示连接已修复，然后才调用ShutdownListener显示连接关闭信息：![[RabbitMQ] AutorecoveringConnection在连接恢复后才调用ShutdownListener](/images/2016/8/0026uWfMzy75YP4pM7I36.jpg)
为什么会这样？下面就开始我的解密之旅！
首先看一下ShutdownNotifier接口的层次图，Connection下共有三个子孙类，尚不确定在我的测试里是哪一个？
![[RabbitMQ] AutorecoveringConnection在连接恢复后才调用ShutdownListener](/images/2016/8/0026uWfMzy75YSEzBzG60.png) 看一下com.rabbitmq.client.ConnectionFactory类newConnection方法实现，豁然开朗！对于ConnectionFactory类，如果automaticRecoveryEnabled被设置则创建AutorecoveringConnection，否则创建AMQConnection。而RecoveryAwareAMQConnectionFactory才会创建RecoveryAwareAMQConnection。
AutorecoveringConnection类init方法会调用addAutomaticRecoveryListener方法，addAutomaticRecoveryListener方法会添加一个ShutdownListener类实例automaticRecoveryListener到列表shutdownListeners，而我创建的ShutdownListener类实例是列表shutdownListeners中的第二个元素。
参看下面堆栈信息，ShutdownNotifierComponent类的notifyListeners会遍历所有shutdownListeners列表所有监听器，第一个关闭监听器实例automaticRecoveryListener会进行连接修复并通知RecoveryListener，然后才到我的关闭监听器打印关闭信息。
```
at AutoRecoveryRecv$2.handleRecovery(AutoRecoveryRecv.
at com.rabbitmq.client.impl.recovery.AutorecoveringConnection.notifyRecoveryListeners(AutorecoveringConnection.
at com.rabbitmq.client.impl.recovery.AutorecoveringConnection.beginAutomaticRecovery(AutorecoveringConnection.
- locked <0x30d> (a com.rabbitmq.client.impl.recovery.AutorecoveringConnection)
at com.rabbitmq.client.impl.recovery.AutorecoveringConnection.access$000(AutorecoveringConnection.
at com.rabbitmq.client.impl.recovery.AutorecoveringConnection$1.shutdownCompleted(AutorecoveringConnection.
at com.rabbitmq.client.impl.ShutdownNotifierComponent.notifyListeners(ShutdownNotifierComponent.
at com.rabbitmq.client.impl.AMQConnection$MainLoop.run(AMQConnection.
at 
```
[rabbitmq/rabbitmq-java-client](https://github.com/rabbitmq/rabbitmq-java-client)项目在https://github.com/rabbitmq/rabbitmq-java-client/pull/136 修正了这个错误，先通知所有ShutdownListener再尝试自动修复连接。但是在我所用的amqp-client-3.6.5.jar还没有包含这一修改。
