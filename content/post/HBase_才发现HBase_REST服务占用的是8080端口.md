---
title: '[HBase] 才发现HBase REST服务占用的是8080端口'
date: 2016-03-03 05:43:11
categories: 
- Hadoop+Spark
- HBase
tags: 
- hbase
- rest
- service
- port
- 8080
---
今天用一下Tomcat，结果发现8080端口还被占了，谁呀？
![[HBase] 才发现HBase REST服务占用的是8080端口](/images/2016/3/0026uWfMzy77U417Ls864.jpg)竟然是HBase REST服务占用的！！看了一下[Ports Used by Components of CDH 5](https://www.cloudera.com/documentation/enterprise/latest/topics/cdh_ig_ports_cdh5.html)，发现ClouderaCDH里是这么用的：
- 8080：Non- Cloudera Manager - managed HBase REST Service
- 20550：Cloudera Manager - managed HBase REST Service
- 8085：HBase REST UI

8080端口还是留着吧，对hbase-site.xml做如下修改：![[HBase] 才发现HBase REST服务占用的是8080端口](/images/2016/3/0026uWfMzy77U594Xdl77.png)
重启HBase REST服务：
```
hbase-daemon.sh stop rest
hbase-daemon.sh start rest
```
通过HBase REST UI检查，REST服务端口改成了20550：![[HBase] 才发现HBase REST服务占用的是8080端口](/images/2016/3/0026uWfMzy77U6LwLHH01.png)![[HBase] 才发现HBase REST服务占用的是8080端口](/images/2016/3/0026uWfMzy77U5wnPSk1c.jpg)
另一种修改REST服务端口的方式是在启动HBase REST服务命令时通过-p选项直接指定端口。例如：
```
hbase-daemon.sh start rest -p 20550
```

### 参考

[Linux – Which application is using port 8080](https://www.mkyong.com/linux/linux-which-application-is-using-port-8080/)    
[Configuring and Using the HBase REST API](https://www.cloudera.com/documentation/enterprise/latest/topics/admin_hbase_rest_api.html)    
[Ports Used by Components of CDH 5](https://www.cloudera.com/documentation/enterprise/latest/topics/cdh_ig_ports_cdh5.html)    