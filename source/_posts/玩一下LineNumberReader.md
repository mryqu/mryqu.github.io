---
title: '玩一下LineNumberReader'
date: 2014-03-26 19:37:23
categories: 
- Java
tags: 
- linenumberreader
- java
- 文件
- 行数
---
找资料的副产品就是发现了LineNumberReader这个类，跟它的父类BufferedReader相比多了计算文件行数的功能。记不得以前是否用过了，这里记录一下备用。
```
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.LineNumberReader;

public class TestFileLineNum {

  public static int countLinesV1(String flName) throws IOException {
    BufferedReader reader = new BufferedReader(new FileReader(flName));
    int cnt = 0;    

    while (reader.readLine() != null) {
      cnt++  ;
    }
    reader.close();
    return cnt;
  }

  public static int countLinesV2(String flName) throws IOException {
    LineNumberReader reader = new LineNumberReader(new FileReader(flName));  
    while (reader.readLine() != null) {
    }
    int cnt = reader.getLineNumber();
    reader.close();
    return cnt;
  }

  public static void main(String[] args) throws IOException {
    for(int i=0;i<4;i  ) {
      String flName = "test" + i + ".txt";
      System.out.println("File "+flName+" has "+countLinesV2(flName)+" line(s).");
    }
  }
}
```