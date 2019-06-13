---
title: '[RabbitMQ] AutorecoveringConnection在连接恢复后才调用ShutdownListener'
date: 2016-08-13 06:00:17
categories: 
- Service+JavaEE
- MQ
tags: 
- rabbitmq
- autorecoveringconnec
- shutdownlistener
- recoverylistener
- hook
---
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
