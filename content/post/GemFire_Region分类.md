---
title: 'GemFire Region分类'
date: 2013-05-15 07:28:53
categories: 
- Service+JavaEE
- Cache
- GemFire
tags: 
- gemfire
- 分布式缓存
- region
---
GemFire开发指南6.5的第4.2节仅列举了分区、复制（分布式）、分布式（非复制）和本地四种Region类型，但RegionShortcut类却定义了23个快捷预定义属性Region。Region的主要行为取决于数据策略、关注策略、范围、本地最大内存和冗余拷贝数（仅用于分区Region）、逐出算法和动作。

<div style="overflow-x:auto;"><table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; font-size: 10px; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><th width="200px">Region快捷预定义属性</th><th width="128px">数据策略</th><th width="97px">范围</th><th width="28px">本地<br>最大<br>内存<br><sub>注1</sub></th><th width="20px">冗余<br>拷贝<br>数<br><sub>注1</sub></th><th width="49px">逐出算法</th><th width="110px">逐出动作</th></tr><tr><td>LOCAL</td><td>NORMAL</td><td>LOCAL</td><td> </td><td> </td><td> </td><td> </td></tr><tr><td>LOCAL_HEAP_LRU</td><td>NORMAL</td><td>LOCAL</td><td> </td><td> </td><td>LRU_HEAP</td><td>LOCAL_DESTROY</td></tr><tr><td>LOCAL_OVERFLOW</td><td>NORMAL</td><td>LOCAL</td><td> </td><td> </td><td>LRU_HEAP</td><td>OVERFLOW_TO_DISK</td></tr><tr><td>LOCAL_PERSISTENT</td><td>PERSISTENT_REPLICATE</td><td>LOCAL</td><td> </td><td> </td><td> </td><td> </td></tr><tr><td>LOCAL_PERSISTENT_OVERFLOW</td><td>PERSISTENT_REPLICATE</td><td>LOCAL</td><td> </td><td> </td><td>LRU_HEAP</td><td>OVERFLOW_TO_DISK</td></tr><tr><td>PARTITION</td><td>PARTITION</td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td>PARTITION_HEAP_LRU</td><td>PARTITION</td><td> </td><td> </td><td> </td><td>LRU_HEAP</td><td>LOCAL_DESTROY</td></tr><tr><td>PARTITION_OVERFLOW</td><td>PARTITION</td><td> </td><td> </td><td> </td><td>LRU_HEAP</td><td>OVERFLOW_TO_DISK</td></tr><tr><td>PARTITION_PERSISTENT</td><td>PERSISTENT_PARTITION</td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td>PARTITION_PERSISTENT_OVERFLOW</td><td>PERSISTENT_PARTITION</td><td> </td><td> </td><td> </td><td>LRU_HEAP</td><td>OVERFLOW_TO_DISK</td></tr><tr><td>PARTITION_PROXY</td><td>PARTITION</td><td> </td><td>0</td><td> </td><td> </td><td> </td></tr><tr><td>PARTITION_PROXY_REDUNDANT</td><td>PARTITION</td><td> </td><td>0</td><td>1</td><td> </td><td> </td></tr><tr><td>PARTITION_REDUNDANT</td><td>PARTITION</td><td> </td><td> </td><td>1</td><td> </td><td> </td></tr><tr><td>PARTITION_REDUNDANT_HEAP_LRU</td><td>PARTITION</td><td> </td><td> </td><td>1</td><td>LRU_HEAP</td><td>LOCAL_DESTROY</td></tr><tr><td>PARTITION_REDUNDANT_OVERFLOW</td><td>PARTITION</td><td> </td><td> </td><td>1</td><td>LRU_HEAP</td><td>OVERFLOW_TO_DISK</td></tr><tr><td>PARTITION_REDUNDANT_PERSISTENT</td><td>PERSISTENT_PARTITION</td><td> </td><td> </td><td>1</td><td> </td><td> </td></tr><tr><td>PARTITION_REDUNDANT_<br>PERSISTENT_OVERFLOW</td><td>PERSISTENT_PARTITION</td><td> </td><td> </td><td>1</td><td>LRU_HEAP</td><td>OVERFLOW_TO_DISK</td></tr><tr><td>REPLICATE</td><td>REPLICATE</td><td>DISTRIBUTED_ACK</td><td> </td><td> </td><td> </td><td> </td></tr><tr><td>REPLICATE_HEAP_LRU</td><td>PRELOAD</td><td>DISTRIBUTED_ACK</td><td> </td><td> </td><td>LRU_HEAP</td><td>LOCAL_DESTROY</td></tr><tr><td>REPLICATE_OVERFLOW</td><td>REPLICATE</td><td>DISTRIBUTED_ACK</td><td> </td><td> </td><td>LRU_HEAP</td><td>OVERFLOW_TO_DISK</td></tr><tr><td>REPLICATE_PERSISTENT</td><td>PERSISTENT_REPLICATE</td><td>DISTRIBUTED_ACK</td><td> </td><td> </td><td> </td><td> </td></tr><tr><td>REPLICATE_PERSISTENT_OVERFLOW</td><td>PERSISTENT_REPLICATE</td><td>DISTRIBUTED_ACK</td><td> </td><td> </td><td>LRU_HEAP</td><td>OVERFLOW_TO_DISK</td></tr><tr><td>REPLICATE_PROXY</td><td>EMPTY</td><td>DISTRIBUTED_ACK</td><td> </td><td> </td><td> </td><td> </td></tr></tbody></table></div>

注1：仅用于分区region
http://www.gemstone.com/docs/current/product/docs/japi/com/gemstone/gemfire/cache/RegionShortcut.html
 
|数据策略|行为
|-----
|EMPTY|在本地缓存中没有数据存储。Region始终表现为空。没有内存成本的、零数据存储占用的生产者本地缓存收发其他缓存节点的时间，零数据存储占用的消费者仅接受事件。为了使空Region接受事件，需设置关注策略为ALL。
|NORMAL(默认)|本地使用的数据存储在本地缓存。此策略允许缓存内容不用于其他缓存节点的内容。
|REPLICATE|Region使用其他节点缓存的数据初始化。初始化后，分布式Region的所有事件会自动复制到本地缓存，在本地缓存保持整个分布式Region的复制。不允许会导致内容与其他缓存节点不一致的操作。此策略与本地范围共用时，行为与正常Region相同。
|PARTITION|通过使用自动数据分布，数据在本地和远程缓存中分区。
|PERSISTENT_REPLICATE|行为与复制Region一样同时数据在硬盘中持久化。
|PERSISTENT_PARTITION|行为与分区Region一样同时数据在硬盘中持久化。
|PRELOADED|初始化时行为像复制Region，之后行为像正常Region。

http://www.gemstone.com/docs/current/product/docs/japi/com/gemstone/gemfire/cache/DataPolicy.html

 
|关注策略|行为
|-----
|ALL|注册对分布式或分区Region中所有条目的事件进行关注，无论这些条目是否存在于本地缓存。
|CACHE_CONTENT(默认)|仅对存在于本地缓存的条目事件进行关注。对于分区Region，本地节点必须保存条目数据的主备份。

http://www.gemstone.com/docs/current/product/docs/japi/com/gemstone/gemfire/cache/InterestPolicy.html

 
|范围|行为
|-----
|GLOBAL|条目更新过程中自动使用GemFire锁服务。这确报即使两个节点通过更新同一条目也保持一致性。一个更新会在所有节点先执行，然后第二个跟新才执行。对于下面的分布式确认或分布式无确认，两个节点同时更新同一条目时，该条目在两个节点的值可能会不一致。
|DISTRIBUTED_ACK|条目更新过程中不会上锁，但执行更新的节点会在获得其他节点响应之后结束操作，因此可以避免简单通信问题（例如网络传输层临时故障期间分布失效）。
|DISTRIBUTED_NO_ACK(默认)|与确认式分布类似，但节点执行更新时不会等待其他节点响应。两个节点除了可能更新后数据不一致，而且无法保证更新被分布成功。
|LOCAL|非分布式。Region尽对在该GemFire节点内运行的线程可见。

http://www.gemstone.com/docs/current/product/docs/japi/com/gemstone/gemfire/cache/Scope.html

 
|逐出算法|行为
|-----
|NONE (默认)|无逐出。
|LRU_ENTRY|通过Region中条目数量驱动逐出行动的算法。
|LRU_HEAP|通过当前所消耗的Java虚拟机堆空间百分比驱动逐出行动的算法。
|LRU_MEMORY|通过Region所消耗内存字节数驱动逐出行动的算法。

http://www.gemstone.com/docs/current/product/docs/japi/com/gemstone/gemfire/cache/EvictionAlgorithm.html

 
|逐出动作|行为
|-----
|NONE|无逐出。
|LOCAL_DESTROY (默认)|对最近最少使用到的条目执行本地销毁。
|OVERFLOW_TO_DISK|将最近最少使用到的条目写入硬盘并将内存中条目的值置为null以释放堆空间。该动作仅在Region配置为可访问磁盘数据时可用。

http://www.gemstone.com/docs/current/product/docs/japi/com/gemstone/gemfire/cache/EvictionAction.html

