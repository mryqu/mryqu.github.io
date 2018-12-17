---
title: '[Hadoop] mapred和mapreduce包的区别'
date: 2013-07-12 16:55:48
categories: 
- Hadoop/Spark
- Hadoop
tags: 
- hadoop
- mapred
- mapreduce
- package
- difference
---
### 背景介绍

在Hadoop的代码中，存在[org.apache.hadoop.mapred](https://github.com/apache/hadoop/tree/master/hadoop-mapreduce-project/hadoop-mapreduce-client/hadoop-mapreduce-client-core/src/main/java/org/apache/hadoop/mapred)和[org.apache.hadoop.mapreduce](https://github.com/apache/hadoop/tree/master/hadoop-mapreduce-project/hadoop-mapreduce-client/hadoop-mapreduce-client-core/src/main/java/org/apache/hadoop/mapreduce)两个包。[mapred包](https://github.com/apache/hadoop/tree/master/hadoop-mapreduce-project/hadoop-mapreduce-client/hadoop-mapreduce-client-core/src/main/java/org/apache/hadoop/mapred)下是老的API，在Hadoop0.20时被废弃了，引入了新包[mapreduce](https://github.com/apache/hadoop/tree/master/hadoop-mapreduce-project/hadoop-mapreduce-client/hadoop-mapreduce-client-core/src/main/java/org/apache/hadoop/mapreduce)，但是由于新的API迟迟没有完成，所以在Hadoop0.21中[取消了mapred包的废弃状态](https://issues.apache.org/jira/browse/MAPREDUCE-1735)。[原来的设想](http://www.mail-archive.com/mapreduce-dev@hadoop.apache.org/msg01833.html)中老包mapred在Hadoop0.22和1.0中将再次设成废弃状态，但时至今日也没有被废弃。

### 区别

本文将通过WordCount示例代码，介绍一下二者的区别。WordCount示例代码分别取自[0.19](https://github.com/apache/hadoop/blob/branch-0.19/src/examples/org/apache/hadoop/examples/WordCount.java)和[0.23.9](https://github.com/apache/hadoop/blob/branch-0.23.9/hadoop-mapreduce-project/hadoop-mapreduce-examples/src/main/java/org/apache/hadoop/examples/WordCount.java)版本的Hadoop源码。

#### [ 0.19版WordCount示例](https://github.com/apache/hadoop/blob/branch-0.19/src/examples/org/apache/hadoop/examples/WordCount.java)
![[Hadoop] mapred和mapreduce包的区别](/images/2013/7/0026uWfMzy78Edxwb2y3a.png)
#### [ 0.23.9版WordCount示例](https://github.com/apache/hadoop/blob/branch-0.23.9/hadoop-mapreduce-project/hadoop-mapreduce-examples/src/main/java/org/apache/hadoop/examples/WordCount.java)
![[Hadoop] mapred和mapreduce包的区别](/images/2013/7/0026uWfMzy78Edz8VCG92.png)
<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt; width: 688"><tbody><tr><th width="118px">区别</th><th>新API</th><th>老API</th></tr><tr><td>包</td><td>新API位于<i style="color: blue;"><b>org.apache.hadoop.mapreduce</b></i>包内</td><td>老API位于<b style="color: blue;"><i>org.apache.hadoop.mapred.</i></b>包内</td></tr><tr><td>Mapper和Reducer类型</td><td>新API使用Mapper和Reducer<i style="color: blue;"><b>抽象类</b></i><br>抽象类更容易扩展，Hadoop实现可以轻松向其抽象类中添加方法(用默认的实现)而不会对已有Hadoop应用造成影响</td><td>老API使用Mapper和Reduceer<i style="color: blue;"><b>接口</b></i></td></tr><tr><td>使用对象</td><td>新API使用<i style="color: blue;"><b>Configuration</b></i>和一些Helper类完成作业配置；<br>新API使用<i style="color: blue;"><b>Job</b></i>完成作业控制；<br>新API使用<i style="color: blue;"><b>Context</b></i>完成用户代码与MapReduce系统的通信。</td><td>老API使用<i style="color: blue;"><b>JobConf<br></b></i>完成作业配置，它是Configuration子类；<br>![[Hadoop]?mapred和mapreduce包的区别](/images/2013/7/0026uWfMzy78EeY1A9Ge0.png)<br>老API使用<i style="color: blue;"><b>JobClient</b></i>完成作业控制；<br>老API使用<i style="color: blue;"><b>OutputCollector</b></i>和<i style="color: blue;"><b>Reporter</b></i>完成用户代码与MapReduce系统的通信。<br></td></tr><tr><td>方法</td><td>map() reduce() clearup() setup() run()；<br>所有方法可抛IOException或InterruptedException；<br>Reduce()输入值为<i style="color: blue;"><b>java.lang.Itera<span style="background-color: yellow;">ble</span></b></i>；键值对输出通过Context对象的write方法实现；<br></td><td>map() reduce()；<br>所有方法可抛IOException；<br>Reduce()输入值为<i style="color: blue;"><b>java.lang.Itera<span style="background-color: yellow;">tor</span></b></i>；<br>键值对输出通过OutputCollector对象的collect方法实现；</td></tr><tr><td>输出文件</td><td><i style="color: blue;"><b>part-m-nnnnn</b></i>和<i style="color: blue;"><b>part-r-nnnnn</b></i><br>(nnnnn为从0开始的整数)</td><td><i style="color: blue;"><b>part-nnnnn</b></i></td></tr></tbody></table>

### 注意事项

尽量使用新API。在mapred和mapreduce两个包下存在FileInputFormat、FileOutputFormat等名字一样的类，如果引入错误的话，程序会无法通过编译。

### 参考

[Upgrading To The New Map Reduce API](http://www.slideshare.net/sh1mmer/upgrading-to-the-new-map-reduce-api)  
[Difference between Hadoop OLD API and NEW API](http://hadoopbeforestarting.blogspot.com/2012/12/difference-between-hadoop-old-api-and.html)  