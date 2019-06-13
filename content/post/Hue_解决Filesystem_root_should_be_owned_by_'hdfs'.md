---
title: "[Hue] 解决Filesystem root '/' should be owned by 'hdfs'"
date: 2016-08-24 05:36:55
categories: 
- Hadoop+Spark
- Hue
tags: 
- hue
- hdfs
- filesystem
- warning
- superuser
---
安装Hue后，通过about页面检查配置，有一个提示：<font color="#FF0000">**Filesystemroot '/' should be owned by 'hdfs'**</font>
![[Hue] 解决Filesystem root '/' should be owned by 'hdfs'](/images/2016/8/0026uWfMzy77YSXQIjX55.jpg)
我在hadoop集群都使用用户hadoop，并没有创建用户hdfs。解决方案是将hue.ini中的default_hdfs_superuser设置：
```
# This should be the hadoop cluster admin
default_hdfs_superuser=hadoop
```
重启Hue后警告解除，呵呵。
