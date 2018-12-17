---
title: 'JDK7中的双端队列Deque实现'
date: 2013-08-08 20:12:21
categories: 
- Java
tags: 
- jdk7
- deque
- 双端队列
---
双端队列Deque（全名double-endedqueue）是一种数据结构，可在双端队列的两端插入、获取或删除元素。队列和栈可以认为是双端队列的特列。
![JDK7中的双端队列Deque实现](/images/2013/8/72ef7beatx6BHlTPhBsce.png)

Deque常用的方法：
<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><td></td><td align="center" colspan="2"><b>First Element (Head)</b></td><td align="center" colspan="2"><b>Last Element (Tail)</b></td></tr><tr><td></td><td><em>Throws exception</em></td><td><em>Special value</em></td><td><em>Throws exception</em></td><td><em>Special value</em></td></tr><tr><td><b>Insert</b></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#addFirst(E)">addFirst(e)</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#offerFirst(E)">offerFirst(e)</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#addLast(E)">addLast(e)</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#offerLast(E)">offerLast(e)</a></td></tr><tr><td><b>Remove</b></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#removeFirst()">removeFirst()</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#pollFirst()">pollFirst()</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#removeLast()">removeLast()</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#pollLast()">pollLast()</a></td></tr><tr><td><b>Examine</b></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#getFirst()">getFirst()</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#peekFirst()">peekFirst()</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#getLast()">getLast()</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#peekLast()">peekLast()</a></td></tr></tbody></table>

Deque扩展了Queue接口，当Deque用作FIFO队列时，元素从双端队列队尾加入，从队首移出。从Queue接口继承的方法等同于Deque如下方法：
<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><td><b><tt style="font-size: 1.2em;">Queue</tt>&nbsp;Method</b></td><td><b>Equivalent&nbsp;<tt style="font-size: 1.2em;">Deque</tt>&nbsp;Method</b></td></tr><tr><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Queue.html#add(E)">add(e)</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#addLast(E)">addLast(e)</a></td></tr><tr><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Queue.html#offer(E)">offer(e)</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#offerLast(E)">offerLast(e)</a></td></tr><tr><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Queue.html#remove()">remove()</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#removeFirst()">removeFirst()</a></td></tr><tr><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Queue.html#poll()">poll()</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#pollFirst()">pollFirst()</a></td></tr><tr><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Queue.html#element()">element()</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#getFirst()">getFirst()</a></td></tr><tr><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Queue.html#peek()">peek()</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#peek()">peekFirst()</a></td></tr></tbody></table>

Deques也可作为LIFO栈。该接口应该优先于遗留的Stack类使用。当双端队列用作栈时，元素从队首入栈和出栈。Stack方法等同与Deque如下方法：
<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><td><b>Stack Method</b></td><td><b>Equivalent&nbsp;<tt style="font-size: 1.2em;">Deque</tt>&nbsp;Method</b></td></tr><tr><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#push(E)">push(e)</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#addFirst(E)">addFirst(e)</a></td></tr><tr><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#pop()">pop()</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#removeFirst()">removeFirst()</a></td></tr><tr><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#peek()">peek()</a></td><td><a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#peekFirst()">peekFirst()</a></td></tr></tbody></table>
注意：当deque用作队列或堆栈时，<a href="http://docs.oracle.com/javase/7/docs/api/java/util/Deque.html#peek()">peek</a>方法也可正常工作，都从deque起始位置移除元素。


## JDK6加入的Deque实现

LinkedList: 一个基于链接节点实现的无界双端队列。允许null元素。
ArrayDeque: 一个基于可变长度数组实现的无界双端队列。不允许null元素。

就效率而言，ArrayDeque在两端添加或删除元素时比LinkedList更高效。ArrayDeque用作栈时比Stack更快，用作队列时比LinkedList更快。
LinkedList实现比ArrayDeque实现更复杂，耗费更多的内存。当遍历双端列表时删除当前元素，LinkedList比ArrayDeque更高效。
继承BlockingQueue的BlockingDeque接口及其实现LinkedBlockingDeque：一个基于链接节点实现的可选有界双端队列。如果LinkedBlockingDeque在构造时没有设定容量大小，添加元素永远不会有阻塞队列的等待（至少在其中有Integer.MAX_VALUE元素之前不会）。
LinkedBlockingDeque实现采用一个独占锁，所有对队列的操作都进行了锁保护，因而很好的支持双向阻塞的特性。缺点是由于独占锁，所以不能同时进行两个操作，这样性能上就大打折扣。
LinkedBlockingDeque实现具有显对低的开销及相对低的可扩展性。如果仅需要FIFO队列功能，最好使用LinkedBlockingQueue，LinkedBlockingQueue具有相同的开销但是有更好的伸缩性(例如很多线程竞争时保持更好的性能)。
[深入浅出 Java Concurrency (24): 并发容器 part 9 双向队列集合 Deque](http://www.blogjava.net/xylz/archive/2010/08/12/328587.html)  
[深入浅出 Java Concurrency (25): 并发容器 part 10 双向并发阻塞队列 BlockingDeque](http://www.blogjava.net/xylz/archive/2010/08/18/329227.html)  


## JDK7加入的Deque实现

ConcurrentLinkedDeque：一个基于链接节点实现的无界无阻塞双端队列。收集关于队列大小的信息会很慢，需要遍历队列。
ConcurrentLinkedDeque具有跟LinkedBlockingDeque相反的表现：相对高的开销及很好的可伸缩性（使用CAS操作进行非堵塞操作，减少了锁的开销，避免序列化瓶颈）。
[[concurrency-interest] BlockingDeque and revised Deque](http://cs.oswego.edu/pipermail/concurrency-interest/2004-November/001140.html)  


## Deque应用：回文（Palindrome）检查

Deque的应用不是很多，很容易使用双端队列解决的一个有趣问题是经典的回文问题。回文是正着读和倒着读都一样的字符串，例如radar、toot和madam。
回文检查方案是采用Deque存储字符串的字符，将字符串中的字符从左到右插入Deque尾部，则deque头部将持有字符串的首字符，deque尾部将持有字符串的末字符。然后从Deque两端移出字符进行比较，直到Deque内字符数为0或1为止。
![JDK7中的双端队列Deque实现](/images/2013/8/72ef7beatx6BHmzXoZw1e.png)
```
public class PalindromeChecker {

  public static boolean palchecker(String str) {
    if(str==null || str.isEmpty())
      return false;
    
    ArrayDeque aDeque = new ArrayDeque (str.length()); 
    
    for(int i=0;i
      char ch = str.charAt(i);
      aDeque.addLast(new Character(ch));
    }
    
    boolean res = true;
    while (aDeque.size()>1 && res) {
      Character first = aDeque.removeFirst();
          Character last = aDeque.removeLast();
          if(!first.equals(last))
            res = false;
    }
    
    return res;
  }
  
  public static void main(String[] args) {
    System.out.println(palchecker("lsdkjfskf"));
    System.out.println(palchecker("radar"));
  }
}
```

