---
title: '[Hadoop] 分布式缓存'
date: 2013-06-28 21:30:09
categories: 
- BigData
tags: 
- hadoop
- 分布式缓存
- distributed
- cache
---
一直在看分布式缓存，最近涉猎到Hadoop的分布式缓存，做个汇总以备后用。

adoop分布式缓存是Map-Reduce框架提供的用于缓存应用程序所需文件（文本文件、存档文件、Jar文件等）的工具。
应用程序通过URL（hdfs://或http://）指定通过JobConf进行缓存的文件。分布式缓存假定URL所指定的文件已经存在于Hadoop分布式文件系统或本地文件系统中并可被集群中所有机器访问到。Hadoop框架会在任何作业在节点执行之前将必须的缓存文件复制到任务节点以供使用。为了节省网络带宽，这些文件只会为每个作业复制一次，且归档类型的缓存文件会在任务节点中解压缩。分布式缓存能用于分发简单只读数据或文本文件及复杂文件（存档文件、Jar文件等）。归档文件（zip、tar和tgz/tar.gz文件）在任务节点中解压缩。Jar文件可选择加入任务的类路径，这是基本的软件分发机制。
分布式缓存跟踪缓存文件的修改时戳。很明显当作业执行时这些缓存文件不应被应用程序或外部修改。

下面的示例介绍了如何使用DistributedCache：
1. 将所需文件复制到FileSystem:
   ```
   $ bin/hadoop fs -copyFromLocal lookup.dat /myapp/lookup.dat 
   $ bin/hadoop fs -copyFromLocal map.zip /myapp/map.zip 
   $ bin/hadoop fs -copyFromLocal mylib.jar /myapp/mylib.jar
   $ bin/hadoop fs -copyFromLocal mytar.tar /myapp/mytar.tar
   $ bin/hadoop fs -copyFromLocal mytgz.tgz /myapp/mytgz.tgz
   $ bin/hadoop fs -copyFromLocal mytargz.tar.gz /myapp/mytargz.tar.gz
   ```
2. 设置应用程序的JobConf:
   ```
   JobConf job = new JobConf();
   DistributedCache.addCacheFile(new URI("/myapp/lookup.dat"), job);
   DistributedCache.addCacheArchive(new URI("/myapp/map.zip", job);
   DistributedCache.addFileToClassPath(new Path("/myapp/mylib.jar"), job);
   DistributedCache.addCacheArchive(new URI("/myapp/mytar.tar", job);
   DistributedCache.addCacheArchive(new URI("/myapp/mytgz.tgz", job);
   DistributedCache.addCacheArchive(new URI("/myapp/mytargz.tar.gz", job);
   ```
3. 在[Mapper](http://hadoop.apache.org/docs/current/api/org/apache/hadoop/mapred/Mapper.html)或[Reducer](http://hadoop.apache.org/docs/current/api/org/apache/hadoop/mapred/Reducer.html)中使用缓存的文件:
   ```
   public static class MapClass extends MapReduceBase
   implements Mapper{
     private Path[] localArchives;  
     private Path[] localFiles;
   
     public void configure(JobConf job) {
       // Get the cached archives/files
       File f = new File("./map.zip/some/file/in/zip.txt");  
     }
   
     public void map(K key, V value, OutputCollector output,
                     Reporter reporter)  throws IOException {
       // Use data from the cached archives/files here
       // ...
       // ...
       output.collect(k, v);  }
   }
   ```

通过GenericOptionsParser使用分布式缓存是一种常用的方式。用户可以使用-file选项指定待分发的文件，文件内包含以都放分隔的URL列表。文件可以放在本地文件系统、HDFS或其他Hadoop可读文件系统（例如S3）中。如果未指定文件系统，则这些文件默认是本地的（即使默认文件系统并非本地文件系统，也是成立的。）。用户可以使用-archieves选项向自己的任务复制存档文件，这些存档文件会在任务节点解压缩。-libjars选项会把JAR文件添加到mapper和reducer任务的类路径中。当库JAR文件没有打包进作业JAR文件时，会非常有帮助。

### 工作机制

当用户启动一个作业，Hadoop将由-files、-archieves和-libjars选项所指定的文件复制到jobtracker的文件系统（一般是HDFS）之中。接着，tasktracker在任务运行之前将文件从jobtracker的文件系统中复制到本地磁盘--缓存—使任务能够访问文件。这些文件在这一刻可以被访问到了。从任务的角度来看，这些文件就已经在那里了（它并不关心这些文件是否来自HDFS）
Tasktracker为缓存中的每个文件维护一个计数器来统计使用该文件的任务数。当任务运行之前，文件引用数加1；当所有任务结束后，计数器减1。当计数器值为0时，表明该文件没有被任何任务使用，可以从缓存中移除。当缓存超过一定容量—默认为10GB，无用的文件将被删除以腾出空间来装载新文件。缓存大小可以通过配置属性local.cache.size进行配置，以字节为单位。
尽管这个机制并不确保在同一tasktracker上运行的作业的后继任务能否在缓存中找到文件，但是成功的概率相当大。原因在于作业的多个任务在调度之后几乎同时开始运行，在此期间基本不可能有足够多的其他任务也在运行，以至于将该任务所需文件从缓存中移除出去。
文件存放在tasktracker的${mapred.loccal.dir}/taskTracker/archive目录下。但是应用程序无需了解这一点，因为这些文件可在任务工作目录通过符号链接获得。

### 分布式缓存 API

由于可以通过GenericOptionsParser间接使用分布式缓存，大多数应用程序不需要使用分布式缓存API。然而，一些应用程序可能需要使用分布式缓存更高级的个噢能能，因此直接使用API。API分为两部分：将数据放入缓存的方法（在Job中）和从缓存中获取数据的方法（在Jobcontext中）
<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><th>作业API方法</th><th>GenericOptionsParser等价项</th><th>描述</th></tr><tr><td>addCacheFile(URI uri)</td><td rowspan="2">-files file1,file2,...</td><td rowspan="2">将文件加入分布式缓存、复制到任务节点。</td></tr><tr><td>setCacheFiles(URI[] files)</td></tr><tr><td>addCacheArchive(URI uri)</td><td rowspan="2">-archives archive1,archive2,…</td><td rowspan="2">将归档文件加入分布式缓存、复制到任务 节点并解压缩。</td></tr><tr><td>setCacheArchives(URI[] files)</td></tr><tr><td>addFileToClassPath(Path file)</td><td>-libjars jar1,jar2,...</td><td>将文件加入分布式缓存并加入MapReduce 任务类路径。这些文件不会解压缩，因此 是将JAR文件加入类路径的非常有用的一种方式。</td></tr><tr><td>addArchiveToClassPath(Path archive)</td><td>&nbsp;无</td><td>将归档文件加入分布式缓存并解压缩后加 入MapReduce任务类路径。当需要将一个 目录下的所有文件加入类路径时非常有用，因为可以创建包含这些文件的归档文件。 另一种方式是创建JAR文件并使用 addFileToClassPath()方法。</td></tr></tbody></table>