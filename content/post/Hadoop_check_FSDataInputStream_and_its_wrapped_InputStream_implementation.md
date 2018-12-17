---
title: '[Hadoop] check FSDataInputStream and its wrapped InputStream implementation'
date: 2015-05-01 01:15:35
categories: 
- Hadoop/Spark
- Hadoop
tags: 
- hadoop
- hdfs
- hdfsdatainputstream
- dfsinputstream
---
打开一个HDFS文件，获得一个FSDataInputStream对象，其实现类到底是什么？小小探究一下。
```
package com.yqu.hadoop;

import java.io.IOException;
import java.io.InputStream;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;

public class LearnFS {

  public static void main(String[] args) {
    Configuration config = new Configuration();
    FSDataInputStream in = null;
    Path path = new Path("/user/hadoop/input/access_log.txt");

    try {
      FileSystem fs = FileSystem.get(config);
      System.out.println("Scheme: " + fs.getScheme());
      System.out.println("Uri: " + fs.getUri().toString());
      in = fs.open(path);
      if (in != null) {
        System.out.println("FSDataInputStream impl:"
            + in.getClass().getCanonicalName());
        InputStream is = in.getWrappedStream();
        if (is != null) {
          System.out.println("InputStream impl:"
              + is.getClass().getCanonicalName());
        }
      }

    } catch (Throwable t) {
      t.printStackTrace();
    } finally {
      if (in != null) {
        try {
          in.close();
        } catch (IOException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }
      }
    }
  }
}
```

测试结果是org.apache.hadoop.hdfs.client.HdfsDataInputStream和org.apache.hadoop.hdfs.DFSInputStream：
![[Hadoop] check FSDataInputStream and its wrapped InputStream implementation](/images/2015/5/0026uWfMzy78McPpTMR99.png)