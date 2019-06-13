---
title: '[Hadoop] YARN DistributedShell实践'
date: 2016-01-31 06:20:46
categories: 
- Hadoop+Spark
- Hadoop
tags: 
- hadoop
- yarn
- distributedshell
---
### YARN DistributedShell介绍

Hadoop2的源代码中实现了两个基于YARN的应用，一个是MapReduce，另一个是非常简单的应用程序编程实例——DistributedShell。DistributedShell是一个构建在YARN之上的non-MapReduce应用示例。它的主要功能是在Hadoop集群中的多个节点，并行执行用户提供的shell命令或shell脚本（将用户提交的一串shell命令或者一个shell脚本，由ApplicationMaster控制，分配到不同的container中执行)。

### YARN DistributedShell测试

执行下列命令进行测试：
```
hadoop jar /usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-applications-distributedshell-2.7.X.jar -shell_command /bin/ls -shell_args /home/hadoop -jar /usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-applications-distributedshell-2.7.X.jar
```
客户端日志显示执行成功：![[Hadoop] YARN DistributedShell实践](/images/2016/1/0026uWfMzy78uJ6xrkVb5.png)

### 参考

[如何运行YARN中的DistributedShell程序](http://dongxicheng.org/mapreduce-nextgen/how-to-run-distributedshell/)    
[YARN DistributedShell源码分析与修改](http://www.cnblogs.com/BYRans/p/5118891.html)    
[YARN Distributedshell解析](http://blog.csdn.net/lalaguozhe/article/details/10361367)    