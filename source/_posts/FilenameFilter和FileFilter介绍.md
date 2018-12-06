---
title: 'FilenameFilter和FileFilter介绍'
date: 2013-10-18 19:26:35
categories: 
- Java
tags: 
- java
- file
- list
- filenamefilter
- filefilter
---
### FilenameFilter和FileFilter说明
java.io.File类提供了四个方法用于列举某个路径下的文件和目录，但不会递归列举子目录下的内容。其中两个是列举路径下的所有文件和目录。
- String[] list()
- File[] listFiles()另外两个是列举路径满足指定过滤器的文件和目录。
- String[] list(FilenameFilter filter)
- File[] listFiles(FileFilter filter)

### 示例
要求：返回当前目录下所有以yqu开头且以.tmp结尾的文件和目录。

#### 代码
```
package com.yqu.file;

import java.io.File;
import java.io.FileFilter;
import java.io.FilenameFilter;

public class HelloFileListing {

  public static void main(String[] args) {
    File f = new File("c:/test");

    System.out.println("\n====Method listFiles() example====");
    File[] files = f.listFiles();
    for (File fl : files) {
      String type = fl.isFile() ? "File: " : "Directory: ";
      try {
        System.out.println(type + fl.getCanonicalPath());
      } catch (Exception e) {
        e.printStackTrace();
      }
    }

    System.out.println("\n====Method listFiles(FileFilter) example====");
    files = f.listFiles(new HelloFileFilter("yqu", ".tmp"));
    for (File fl : files) {
      String type = fl.isFile() ? "File: " : "Directory: ";
      try {
        System.out.println(type + fl.getCanonicalPath());
      } catch (Exception e) {
        e.printStackTrace();
      }
    }

    System.out.println("\n====Method list(FilenameFilter) example====");
    String[] fileNames = f.list(new HelloFilenameFilter("yqu", ".tmp"));
    for (String fileName : fileNames) {
      System.out.println(fileName);
    }

  }

  public static class HelloFilenameFilter implements FilenameFilter {
    private String prefix;
    private String suffix;

    public HelloFilenameFilter(String prefix, String suffix) {
      this.prefix = prefix;
      this.suffix = suffix;
    }

    public boolean accept(File dir, String name) {
      return name.startsWith(prefix) && name.endsWith(suffix);
    }
  }

  public static class HelloFileFilter implements FileFilter {
    private String prefix;
    private String suffix;

    public HelloFileFilter(String prefix, String suffix) {
      this.prefix = prefix;
      this.suffix = suffix;
    }

    public boolean accept(File pathname) {
      String name = pathname.getName();
      return name.startsWith(prefix) && name.endsWith(suffix);
    }
  }
}
```

#### 输出
```
====Method listFiles() example====
File: C:\test\222.zip
Directory: C:\test\Next
Directory: C:\test\QE
Directory: C:\test\yqu123.tmp
File: C:\test\yqu321.tmp

====Method listFiles(FileFilter) example====
Directory: C:\test\yqu123.tmp
File: C:\test\yqu321.tmp

====Method list(FilenameFilter) example====
yqu123.tmp
yqu321.tmp
```