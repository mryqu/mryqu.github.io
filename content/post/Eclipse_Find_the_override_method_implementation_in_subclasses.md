---
title: '[Eclipse] Find the override method implementation in subclasses'
date: 2013-10-26 00:00:39
categories: 
- Tool
- Eclipse
tags: 
- eclipse
- override
- method
- implementation
- subclass
---
已知当前对象为org.apache.hadoop.hdfs.client.HdfsDataInputStream实例，调用其祖宗抽象类java.io.InputStream的publicint read(byte b[], int off, int len) throwsIOException方法，究竟最后使用的是那个类的实现呢？
![[Eclipse] Find the override method implementation in subclasses](/images/2013/10/0026uWfMzy78LUoXO4J55.png)
由如上类继承图可知，应该从对象类往上依次查找方法实现：HdfsDataInputStream、FSDataInputStream、......。工作很繁琐，挑战眼力！

一个快捷的方式就是进入java.io.InputStream类，选中read(byte b[], int off, intlen) 方法，按住CTRL键后点击鼠标左键，这样会出现一个菜单：
![[Eclipse] Find the override method implementation in subclasses](/images/2013/10/0026uWfMzy78LUO0EEW6a.png)
选择OpenImplementation菜单，输入HdfsDataInputStream、FSDataInputStream、......，可以更轻松的找到重写该方法的子类。
![[Eclipse] Find the override method implementation in subclasses](/images/2013/10/0026uWfMzy78LVDQRYPff.png)
最终可知使用的是java.io.DataInputStream类中的实现：
```
public final int read(byte b[], int off, int len) throws IOException {
  return in.read(b, off, len);
}
```
