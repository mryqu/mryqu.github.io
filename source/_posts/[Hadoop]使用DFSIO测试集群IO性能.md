---
title: '[Hadoop] 使用DFSIO测试集群I/O性能'
date: 2015-05-23 09:12:41
categories: 
- Hadoop/Spark
- Hadoop
tags: 
- hadoop
- dfsio
- performance
- benchmark
- test
---
DFSIO是Hadoop自带的用于集群分布式I/O性能基准测试的工具，其源码为[https://github.com/apache/hadoop/blob/trunk/hadoop-mapreduce-project/hadoop-mapreduce-client/hadoop-mapreduce-client-jobclient/src/test/java/org/apache/hadoop/fs/TestDFSIO.java](https://github.com/apache/hadoop/blob/trunk/hadoop-mapreduce-project/hadoop-mapreduce-client/hadoop-mapreduce-client-jobclient/src/test/java/org/apache/hadoop/fs/TestDFSIO.java)。

### DFSIO 用法
```
hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.7.X-tests.jar TestDFSIO
15/05/22 19:50:22 INFO fs.TestDFSIO: TestDFSIO.1.8
Missing arguments.
Usage: TestDFSIO [genericOptions] -read [-random | -backward | -skip [-skipSize Size]] | -write | -append | -truncate | -clean [-compression codecClassName] [-n rFiles N] [-size Size[B|KB|MB|GB|TB]] [-resFile resultFileName] [-bufferSize Bytes]

```

DFSIO可以测试写操作和读操作，以MapReduce作业的方式运行，返回整个集群的I/O性能报告。DFSIO读写测试的位置在hdfs://namendoe:8020/benchmarks/TestDFSIO/io_data，其中读测试不会自己产生数据，必须先执行DFSIO写测试。

- -read：读测试，对每个文件读-size指定的字节数
- -write：写测试，对每个文件写-size指定的字节数
- -append：追加测试，对每个文件追加-size指定的字节数
- -truncate：截断测试，对每个文件截断至-size指定的字节数
- -clean：清除TestDFSIO在HDFS上生成数据
- -n：文件个数
- -size：每个文件的大小
- -resFile：生成测试报告的本地文件路径
- -bufferSize：每个mapper任务读写文件所用到的缓存区大小，默认为1000000字节。
### DFSIO测试

#### 写10个100MB的文件
```
hadoop@node50064:~$ hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.7.X-tests.jar TestDFSIO -write -nrFiles 10 -fileSize 100MB -resFile /tmp/DFSIO-write.out
```

#### 查看写测试结果

本地文件/tmp/DFSIO-write.out包含写测试性能报告：
```
hadoop@node50064:~$ cat /tmp/DFSIO-write.out
 ----- TestDFSIO ----- : write
            Date & time: Sat May 23 00:44:59 EDT 2015
        Number of files: 10
 Total MBytes processed: 1000.0
      Throughput mb/sec: 3.458508276210305
 Average IO rate mb/sec: 4.84163236618042
  IO rate std deviation: 2.384178973806887
     Test exec time sec: 170.605

```

DFSIO 写测试在HDFS上生成的数据：
```
hadoop@node50064:~$ hadoop fs -ls /benchmarks/TestDFSIO/
Found 3 items
drwxr-xr-x   - hadoop supergroup          0 2015-05-23 00:42 /benchmarks/TestDFSIO/io_control
drwxr-xr-x   - hadoop supergroup          0 2015-05-23 00:44 /benchmarks/TestDFSIO/io_data
drwxr-xr-x   - hadoop supergroup          0 2015-05-23 00:44 /benchmarks/TestDFSIO/io_write
hadoop@node50064:~$ hadoop fs -ls /benchmarks/TestDFSIO/io_control
Found 10 items
-rw-r--r--   2 hadoop supergroup        112 2015-05-23 00:42 /benchmarks/TestDFSIO/io_control/in_file_test_io_0
-rw-r--r--   2 hadoop supergroup        112 2015-05-23 00:42 /benchmarks/TestDFSIO/io_control/in_file_test_io_1
-rw-r--r--   2 hadoop supergroup        112 2015-05-23 00:42 /benchmarks/TestDFSIO/io_control/in_file_test_io_2
-rw-r--r--   2 hadoop supergroup        112 2015-05-23 00:42 /benchmarks/TestDFSIO/io_control/in_file_test_io_3
-rw-r--r--   2 hadoop supergroup        112 2015-05-23 00:42 /benchmarks/TestDFSIO/io_control/in_file_test_io_4
-rw-r--r--   2 hadoop supergroup        112 2015-05-23 00:42 /benchmarks/TestDFSIO/io_control/in_file_test_io_5
-rw-r--r--   2 hadoop supergroup        112 2015-05-23 00:42 /benchmarks/TestDFSIO/io_control/in_file_test_io_6
-rw-r--r--   2 hadoop supergroup        112 2015-05-23 00:42 /benchmarks/TestDFSIO/io_control/in_file_test_io_7
-rw-r--r--   2 hadoop supergroup        112 2015-05-23 00:42 /benchmarks/TestDFSIO/io_control/in_file_test_io_8
-rw-r--r--   2 hadoop supergroup        112 2015-05-23 00:42 /benchmarks/TestDFSIO/io_control/in_file_test_io_9
hadoop@node50064:~$ hadoop fs -ls /benchmarks/TestDFSIO/io_data
Found 10 items
-rw-r--r--   2 hadoop supergroup  104857600 2015-05-23 00:44 /benchmarks/TestDFSIO/io_data/test_io_0
-rw-r--r--   2 hadoop supergroup  104857600 2015-05-23 00:44 /benchmarks/TestDFSIO/io_data/test_io_1
-rw-r--r--   2 hadoop supergroup  104857600 2015-05-23 00:44 /benchmarks/TestDFSIO/io_data/test_io_2
-rw-r--r--   2 hadoop supergroup  104857600 2015-05-23 00:44 /benchmarks/TestDFSIO/io_data/test_io_3
-rw-r--r--   2 hadoop supergroup  104857600 2015-05-23 00:44 /benchmarks/TestDFSIO/io_data/test_io_4
-rw-r--r--   2 hadoop supergroup  104857600 2015-05-23 00:44 /benchmarks/TestDFSIO/io_data/test_io_5
-rw-r--r--   2 hadoop supergroup  104857600 2015-05-23 00:44 /benchmarks/TestDFSIO/io_data/test_io_6
-rw-r--r--   2 hadoop supergroup  104857600 2015-05-23 00:44 /benchmarks/TestDFSIO/io_data/test_io_7
-rw-r--r--   2 hadoop supergroup  104857600 2015-05-23 00:44 /benchmarks/TestDFSIO/io_data/test_io_8
-rw-r--r--   2 hadoop supergroup  104857600 2015-05-23 00:44 /benchmarks/TestDFSIO/io_data/test_io_9
hadoop@node50064:~$ hadoop fs -ls /benchmarks/TestDFSIO/io_write
Found 2 items
-rw-r--r--   2 hadoop supergroup          0 2015-05-23 00:44 /benchmarks/TestDFSIO/io_write/_SUCCESS
-rw-r--r--   2 hadoop supergroup         79 2015-05-23 00:44 /benchmarks/TestDFSIO/io_write/part-00000
```

#### 读10个100MB的文件
```
hadoop@node50064:~$ hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.7.X-tests.jar TestDFSIO -read -nrFiles 10 -fileSize 100MB -resFile /tmp/DFSIO-read.out
```

#### 查看读测试结果

本地文件/tmp/DFSIO-read.out包含读测试性能报告：
```
hadoop@node50064:~$ cat /tmp/DFSIO-read.out
----- TestDFSIO ----- : read
           Date & time: Sat May 23 00:59:25 EDT 2015
       Number of files: 10
Total MBytes processed: 1000.0
     Throughput mb/sec: 101.09179134654266
Average IO rate mb/sec: 160.2582244873047
 IO rate std deviation: 126.10457558779005
    Test exec time sec: 39.327


```

DFSIO 写测试在HDFS上生成的数据：
```
hadoop@node50064:~$ hadoop fs -ls /benchmarks/TestDFSIO
Found 4 items
drwxr-xr-x   - hadoop supergroup          0 2015-05-23 00:58 /benchmarks/TestDFSIO/io_control
drwxr-xr-x   - hadoop supergroup          0 2015-05-23 00:44 /benchmarks/TestDFSIO/io_data
drwxr-xr-x   - hadoop supergroup          0 2015-05-23 00:59 /benchmarks/TestDFSIO/io_read
drwxr-xr-x   - hadoop supergroup          0 2015-05-23 00:44 /benchmarks/TestDFSIO/io_write
hadoop@node50064:~$ hadoop fs -ls /benchmarks/TestDFSIO/io_read
Found 2 items
-rw-r--r--   2 hadoop supergroup          0 2015-05-23 00:59 /benchmarks/TestDFSIO/io_read/_SUCCESS
-rw-r--r--   2 hadoop supergroup         80 2015-05-23 00:59 /benchmarks/TestDFSIO/io_read/part-00000
```

#### 清除DFSIO在HDFS生成的数据
```
hadoop@node50064:~$ hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.7.X-tests.jar TestDFSIO -clean
hadoop@node50064:~$ hadoop fs -ls /benchmarks

```
