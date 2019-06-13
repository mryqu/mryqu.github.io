---
title: 'Tomcat的会话持久化'
date: 2013-11-08 20:17:47
categories: 
- Service+JavaEE
- Web Application Server
tags: 
- tomcat
- session
- persistence
- 会话持久化
- session.ser
---
《[玩玩HTTP servlet和session资源监控器](/post/玩玩http_servlet和session资源监控器)》提到我hello的一个web项目，刚开始我只是用监视器清除了Tomcat容器外部的文件资源，以为会话失效后Tomcat会自己清除会话属性，但后来发现想的太简单了。不但会话失效，并且重启Tomcat服务器，服务器端原来的会话及其属性都在,如果客户端浏览器的会话没有丢的话，刷新页面仍然可以获得以前的信息。原来Tomcat（起码5.x之后的版本）在默认的情况下提供了会话持久化这项功能，见$TOMCAT_HOME$/conf/context.xml：![Tomcat的会话持久化](/images/2013/11/0026uWfMgy6OOWlb7ndf3.png)Tomcat的默认会话管理器是标准会话管理器(StandardManager)，用于非集群环境中对单个处于运行状态的Tomcat实例会话进行管理。当Tomcat关闭时，这些会话相关的数据会被写入磁盘上的一个名叫SESSION.ser的文件，并在Tomcat下次启动时读取此文件。
- 默认只有在Tomcat正常关闭时才会保存完整的用户会话信息
- 默认保存于$CATALINA_HOME$/work/Catalina/[host]/[webapp]/下的SESSIONS.ser文件中
- 若是自定义的虚拟主机则保存在$CATALINA_HOME/work/Catalina/[host]/_/下的SESSIONS.ser文件中

如果不想再获得失效会话属性的话，解决办法为：
- 关闭Tomcat会话持久化功能。去掉context.xml中那句注释即可。
- HttpSessionListener实现类的sessionDestroyed方法删除该会话所有属性。

#### 参考

[Apache Tomcat 5.5 Configuration Reference](http://tomcat.apache.org/tomcat-5.5-doc/config/manager.html)[Tomcat会话管理](http://xyuex.blog.51cto.com/5131937/1040123)    