---
title: 'JDK7的Fork/Join并发框架'
date: 2013-08-06 20:02:21
categories: 
- Java
tags: 
- jdk7
- fork
- join
- 并发
- 框架
---
硬件的发展趋势非常清晰；Moore定律表明不会出现更高的时钟频率，但是每个芯片上会集成更多的内核。很容易想象让十几个处理器繁忙地处理一个粗粒度的任务边界（比如一个用户请求），但是这项技术不会扩大到数千个处理器——在这种环境下短时间内流量可能会呈指数级增长，但最终硬件趋势将会占上风。当跨入多内核时代时，我们需要找到更细粒度的并行性，否则将面临即便有许多工作需要去做而处理器却仍处于空闲的风险。如果希望跟上技术发展的脚步，软件平台也必须配合主流硬件平台的转变。最终，Java7包含的一种框架，用于表示某种更细粒度级别的并行算法：Fork/Join框架。
Fork/Join融合了分而治之（divide-and-conquer）编程技术；获取问题后，递归地将它分成多个子问题，直到每个子问题都足够小，以至于可以高效地串行地解决它们。递归的过程将会把问题分成两个或者多个子问题，然后把这些问题放入队列中等待处理（fork步骤），接下来等待所有子问题的结果（join步骤），把多个结果合并到一起。
假如充分分解任务的大小，那么创建一个线程的开销有可能超出执行该任务的开销。因此，fork/join框架使用与可用核数相匹配的适当大小的线程池，以减少这种频繁交换的开销。为避免线程空闲，框架包含了一个工作窃取方法，该方法可以使空闲线程从一个执行较慢的线程中窃取等待其处理的工作。
[ Java教程 - Fork/Join](http://docs.oracle.com/javase/tutorial/essential/concurrency/forkjoin.html)  
[ 分解和合并：Java 也擅长轻松的并行编程！](http://www.oracle.com/technetwork/cn/articles/java/fork-join-422606-zhs.html)  
[JDK 7 中的 Fork/Join 模式](http://www.ibm.com/developerworks/cn/java/j-lo-forkjoin/)  
Doug Lea：
"[A Java Fork/Join Framework](http://gee.cs.oswego.edu/dl/papers/fj.pdf)"：了解 Fork/Join 模式的实现机制和执行性能。 
[InfoQ: Doug Lea谈Fork/Join框架](http://www.infoq.com/interviews/doug-lea-fork-join)  