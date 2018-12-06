---
title: 'Java线程是否会被垃圾回收？'
date: 2013-07-30 20:33:07
categories: 
- Java
tags: 
- thread
- gc
- weakreference
- 线程
- 垃圾回收
---
如果将线程启动后，然后线程变量置空，线程会怎么样？

```
import java.lang.ref.WeakReference;

public class TestThread {
  public static void testUnreferencedThread() {
    // anonymous class extends Thread
    Thread t = new Thread() {
      public void run() {
        // infinite loop
        while (true) {
          try {
            Thread.sleep(1000);
          } catch (InterruptedException e) {}
          // as long as this line printed out, you know it is alive.
          System.out.println("thread is running...");
        }
      }
    };
    t.start();

    WeakReference<Thread> wr = new WeakReference<Thread>(t);
    t = null;

    // no more references for Thread t
    // another infinite loop
    while (true) {
      try {
        Thread.sleep(3000);
      } catch (InterruptedException e) {}
      System.gc();

      StringBuilder sb = new StringBuilder();
      sb.append("Executed System.gc(),");

      if(wr.get()==null) {
        sb.append(" thread variable has been GCed");
      } else {
        sb.append("WeakReference still keep ").append(wr.get());
      }
      System.out.println(sb.toString());
    } // The program will run forever until you use ^C to stop it
  }

  public static void main(String[] s) {
    testUnreferencedThread();
  }
}
```

上面的例程运行结果是两个线程在程序被强制终止之前一直运行。
```
thread is running...
thread is running...
thread is running...
Executed System.gc(),WeakReference still keep Thread[Thread-0,5,main]
thread is running...
thread is running...
thread is running...
Executed System.gc(),WeakReference still keep Thread[Thread-0,5,main]
thread is running...
thread is running...
...
...
...
```

运行中的线程是称之为垃圾回收根对象的一种，不会被垃圾回收。当垃圾回收器判断一个对象是否可达，总是使用垃圾回收根对象作为参考点。
例如，主线程并没有被引用，但是不会被垃圾回收。
垃圾回收根对象是可在堆之外被访问的对象。一个对象可由于下列原因成为GC根对象：
- System Class
  由自举/系统类加载器加载的类。例如，rt.jar中所有诸如java.util.*的类。
- JNI Local
  原生代码中的本地变量，例如用户定义的JNI代码或JVM内部代码。
- JNI Global
  原生代码中的全局变量，例如用户定义的JNI代码或JVM内部代码。
- Thread Block
  当前活跃的线程块中引用的对象。
- Thread
  启动且未停止的线程。
- Busy Monitor
  其wait()或notify()方法被调用，或被同步synchronized的对象。例如，通过调用synchronized(Object)或者进入其某个synchronized方法。静态方法对应类，非静态方法对应对象。
- Java Local
  本地变量。例如，仍在线程的栈中的方法输入参数或本地创建的对象。
- Native Stack
 （例如用户定义的JNI代码或JVM内部代码这样的）原生代码的入或出参数。通常发生在许多方法有原生部分，方法参数处理的对象成为GC根对象。例如，参数用于文件、网络I/O或反射。
- Finalizer
  在队列中等待其finalizer运行的对象。
- Unfinalized
  拥有finalize方法，但是还没有被终结且不在finalizer队列的对象。
- Unreachable
  从其他根对象不可达的对象，但是被内存分析器标记为根对象。
- Unknown
  没有根类型的对象。一些转储(dump)，例如IBM可移植对转储文件，没有根信息。对于这些转储，内存分析器解析程序将没有被其他根对象引用的对象标记为此类根对象。

### 参考

[Java Thread Garbage collected or not](http://stackoverflow.com/questions/2423284/java-thread-garbage-collected-or-not)  
[Garbage Collection Roots](http://help.eclipse.org/indigo/topic/org.eclipse.mat.ui.help/concepts/gcroots.html)  
