---
title: 'JDK7中的队列实现'
date: 2013-08-07 20:02:21
categories: 
- Java
tags: 
- jdk7
- queue
- 队列
---
## JDK7之前已有的队列实现

JDK7之前已有的队列实现分为两类：用于一般用途的实现和用于并发的实现。

### 用于一般用途的队列实现

LinkedList实现了Queue接口，为offer、poll等方法提供了先入先出队列操作。
PriorityQueue类是基于堆（数据结构）的优先队列。如果PriorityQueue在构造时指定比较器Comparator，则用比较器对元素排序，否则使用元素的自然排序（通过其java.util.Comparable实现）。队列的取操作（poll、remove、peek和element）访问队列头部的元素。队列头部是顺序上最小的元素或具有相同最小值的元素之一。PriorityQueue的iterator方法提供的爹抬起不保证按特定顺序遍历PriorityQueue中的元素。

### 并发队列实现

java.util.concurrent包下包含一系列同步的Queue接口和类。
ConcurrentLinkedQueue基于链接节点的、线程安全的队列。并发访问不需要同步。因为它在队列的尾部添加元素并从头部删除它们，所以只要不需要知道队列的大小。ConcurrentLinkedQueue对公共集合的共享访问就可以工作得很好。收集关于队列大小的信息会很慢，需要遍历队列。
http://www.cs.rochester.edu/research/synchronization/pseudocode/queues.html
JDK5加入了BlockingQueue接口和五个阻塞队列类。阻塞队列BlockingQueue扩展了Queue的操作，元素添加操作会在没有空间可用时阻塞，而元素获取操作会在队列中没有任何东西时阻塞。
五个队列所提供的各有不同：
- ArrayBlockingQueue：一个基于数组实现的有界（大小有限）队列。
- LinkedBlockingQueue：一个基于链接节点实现的可选有界队列。如果LinkedBlockingQueue在构造时没有设定容量大小，添加元素永远不会有阻塞队列的等待（至少在其中有Integer.MAX_VALUE元素之前不会）。
- PriorityBlockingQueue：一个基于堆实现的无界优先级队列。
- DelayQueue：一个基于堆实现的、基于时间的调度队列。
- SynchronousQueue：一个利用BlockingQueue接口的会合（rendezvous）机制。它没有内部容量。它就像线程之间的手递手机制，类似于生活中一手交钱一手交货这种情况。在队列中加入一个元素的生产者会等待另一个线程的消费者。当这个消费者出现时，这个元素就直接在消费者和生产者之间传递，永远不会加入到阻塞队列中。公平模式下等待线程按照FIFO顺序访问队列，非公平模式下等待线程访问顺序不定。


## JDK7的TransferQueue

JDK7加入了继承自BlockingQueue的TransferQueue接口和及其实现LinkedTransferQueue：一个基于链接节点实现的无界TransferQueue。
TransferQueue可以让使用者决定使用正常的BlockingQueue语义还是有保障的手递手机制，因而比SynchronousQueue更通用和有效。当队列内已经存在元素时，调用transfer会确保所有已有元素在此传递元素之前被处理。DougLea称之为容量智能化，LinkedTransferQueue实际上是ConcurrentLinkedQueue,(在公平模式下)SynchronousQueue, 无界的LinkedBlockingQueues等的超集。
TransferQueue混合了若干高级特性的同时，也提供了更高的性能。LinkedTransferQueue相比不公平模式SynchronousQueue，性能超过3倍；相比公平模式SynchronousQueue，性能超过14倍。SynchronousQueueJDK5实现是使用两个队列（用于等待生产者和等待消费者）,用一个锁保护这两个队列。而LinkedTransferQueue实现使用CAS操作进行非堵塞操作，减少了锁的开销，避免序列化瓶颈。
获得TransferQueue队列大小会很慢，需要遍历队列。
http://tech.puredanger.com/2009/02/28/java-7-transferqueue/  
http://www.blogjava.net/yongboy/archive/2012/02/04/369575.html  