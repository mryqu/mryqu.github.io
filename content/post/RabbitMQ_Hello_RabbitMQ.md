---
title: '[RabbitMQ] Hello RabbitMQ'
date: 2016-08-07 05:54:08
categories: 
- Service+JavaEE
- MQ
tags: 
- rabbitmq
- queue
- exchange
- route
- topic
---
为了快速入门RabbitMQ，我主要学习了下列参考中的两个链接：RabbitMQ教程和SpringAMQP范例。这里对所学教程做一个小笔记。

### 准备工作

由于我不打算跑本机上的RabbitMQ服务器，所有对代码稍有修改。
#### TutorialConfiguration.java
```
public class TutorialConfiguration {
    public static final String HOST = "mryqu-rabbitmq-server";
    public static final String USERNAME = "mryqu";
    public static final String PASSWORD = "mryqu-pwd";
}
```
#### 对原有代码进行修改
```
// factory.setHost("localhost");
factory.setHost(TutorialConfiguration.HOST);
factory.setUsername(TutorialConfiguration.USERNAME);
factory.setPassword(TutorialConfiguration.PASSWORD);
}
```

### RabbitMQ函数

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

### 教程一："Hello World!"

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

### 教程二：工作队列

![[RabbitMQ] Hello RabbitMQ](/images/2016/8/0026uWfMzy74Q9BA4ok04.png)
本教程跟教程一的区别主要有以下几点：
- 教程一中消息发布者和消费者声明的队列为非持久性，而本教程中则为持久性；
- 教程一中消息发布者发布消息时未指定属性，而本教程中指定内容为纯文本、持久的消息
- 教程一中消息消费者消息时自动应答（autoAck或no-ack），而本教程中为非自动应答
- 本教程中消息消费者通过函数void basicQos(int prefetchSize)指定服务质量。由于前一条为非自动应答，因此本设置生效。预读取字节无限制，预读取消息个数为1，仅应用于消费者级别。
- 本教程中消息消费者通过Thread.sleep函数模拟耗时操作，并通过void basicAck(longdeliveryTag, boolean multiple)确认消息。
- 本教程中起了两个消息消费者，两个消息消费者交替处理发布者迅速发出的多个消息。

### 教程三：订阅/发布

![[RabbitMQ] Hello RabbitMQ](/images/2016/8/0026uWfMzy74WXfT7Zt57.png)
上一教程工作队列中每个任务仅发送给一个消费者，而本教程中一个消息可被发给多个消费者。实现主要通过一个fanout类型的交换器完成。

### 教程四：路由

![[RabbitMQ] Hello RabbitMQ](/images/2016/8/0026uWfMzy74WXIBxwm12.png)
上一教程中fanout类型的交换器将收到的消息广播给所有接收者，而本教程接收者将有选择地接收消息中感兴趣的那一部分。实现主要通过direct类型交换器完成，消费者将通道与交换器通过感兴趣的路由关键字绑定，发布者在使用basicPublish函数发布消息时需提供交换器、路由关键字和消息内容。

### 教程五：主题

![[RabbitMQ] Hello RabbitMQ](/images/2016/8/0026uWfMzy74WXyqOdf6d.png)
上一教程的限制在于不能基于多个条件进行路由。本教程通过topic类型交换器完成复杂的路由。其中路由关键字为由点做分界符的词列表，\*代表一个词，#代表零或多个词。
例如路由关键词中第一个代表速度、第二个代表颜色，第三个代表物种：..。这里创建三个绑定：Q1与"\*.orange.\*"关键词绑定，Q2与关键词"\*.\*.rabbit"和"lazy.#"绑定。其意义为：Q1对所有桔色动物感兴趣，Q2希望获得所有关于兔子及所有关于缓慢动物的消息。
路由关键词设为"quick.orange.rabbit"的消息将会传给两个队列。路由关键词设为"lazy.orange.elephant"的消息也将会传给两个队列。路由关键词设为"quick.orange.fox"将仅会传给第一个队列，路由关键词设为"lazy.brown.fox"将仅会传给第二个队列。路由关键词设为"lazy.pink.rabbit"将仅会传给第二个队列一次，即使它匹配了两个绑定。路由关键词设为"quick.brown.fox"的消息没有匹配任何绑定，因此会被丢弃。路由关键词设为"orange"或"quick.orange.male.rabbit"也不会匹配任何绑定，将被丢弃。而路由关键词设为"lazy.orange.male.rabbit"即使有四个词，也能匹配最后一个绑定，并传给第二个队列。
如果路由关键词不包含\*和#字符，则等同direct类型。

### 教程六：RPC

![[RabbitMQ] Hello RabbitMQ](/images/2016/8/0026uWfMzy74WXDJDeg38.png)
本教程借助消息属性中的replyTo和correlationId，完成响应与请求的匹配。

### 参考

[RabbitMQ Tutorials](http://www.rabbitmq.com/getstarted.html)    
[Spring AMQP Samples](https://github.com/spring-projects/spring-amqp-samples)    
[GETTING STARTED: Messaging with RabbitMQ](https://spring.io/guides/gs/messaging-rabbitmq/)    
[Understanding AMQP](https://spring.io/understanding/AMQP)    
[Spring AMQP](http://docs.spring.io/spring-amqp/reference/html/index.html)    
[AMQP 0-9-1 Complete Reference Guide](http://www.rabbitmq.com/amqp-0-9-1-reference.html)    