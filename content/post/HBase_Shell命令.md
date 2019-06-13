---
title: '[HBase] Shell命令'
date: 2013-09-27 19:58:03
categories: 
- Hadoop+Spark
- HBase
tags: 
- hbase
- shell
- command
- usage
---
HBase提供可扩展的基于jruby(JIRB)命令行已用于执行一些命令。HBase命令行主要归为六类。



### 1) 通用HBase命令

#### status
显示集群状态。可以为‘summary’、‘simple’或‘detailed’。默认为‘summary’。
用法:
```
hbase> status
hbase> status ‘simple’
hbase> status ‘summary’
hbase> status ‘detailed’
```
#### version
输出HBase版本
用法:
```
hbase> version
```
#### whoami
显示当前HBase用户。
用法:
```
hbase> whoami
```

### 2) 表管理命令

#### alter
修改列族schema；提供表名和指定新列族schema的字典。字典必须包含所要修改的列族名。例如，

对表‘t1’修改或添加列族‘f1’从当前值到最大版本5：
```
hbase> alter ‘t1’, NAME => ‘f1’, VERSIONS => 5
```
对多个列族进行操作:
```
hbase> alter ‘t1’, ‘f1’, {NAME => ‘f2’, IN_MEMORY => true}, {NAME => ‘f3’, VERSIONS => 5}
```
删除表‘t1’中的列族‘f1’，使用下列方法之一：
```
hbase> alter ‘t1’, NAME => ‘f1’, METHOD => ‘delete’
hbase> alter ‘t1’, ‘delete’ => ‘f1’
```
也可以修改诸如MAX_FILESIZE、READONLY、MEMSTORE_FLUSHSIZE、DEFERRED_LOG_FLUSH等表属性，例如将region最大容量设为128MB：
```
hbase> alter ‘t1’, MAX_FILESIZE => ‘134217728’
```
可以通过设置表协处理器属性添加表协处理器：
```
hbase> alter ‘t1’, ‘coprocessor’=>’hdfs:///foo.jar|com.foo.FooRegionObserver|1001|arg1=1,arg2=2’
```
由于可以对一个表配置多个协处理器，一个序列号将自动附加到属性名后以唯一标识。为了理解如何加载协处理器类，协处理器属性必须匹配下列模式:
```
[coprocessor jar file location] | class name | [priority] | [arguments]
```
也可以设置表或列族特定配置：
```
hbase> alter ‘t1’, CONFIGURATION => {‘hbase.hregion.scan.loadColumnFamiliesOnDemand’ => ‘true’}
hbase> alter ‘t1’, {NAME => ‘f2’, CONFIGURATION => {‘hbase.hstore.blockingStoreFiles’ => ’10’}}
```
也可以移除表属性：
```
hbase> alter ‘t1’, METHOD => ‘table_att_unset’, NAME => ‘MAX_FILESIZE’
hbase> alter ‘t1’, METHOD => ‘table_att_unset’, NAME => ‘coprocessor$1’
```
上两个命令可以放在一个命令中：
```
hbase> alter ‘t1’, { NAME => ‘f1’, VERSIONS => 3 },{ MAX_FILESIZE => ‘134217728’ }, { METHOD => ‘delete’, NAME => ‘f2’ },OWNER => ‘johndoe’, METADATA => { ‘mykey’ => ‘myvalue’ }
```
#### create
创建表。提供表明和针对每个列族的字典及一个表配置的可选字典。
```
hbase> create ‘t1’, {NAME => ‘f1’, VERSIONS => 5}
hbase> create ‘t1’, {NAME => ‘f1’}, {NAME => ‘f2’}, {NAME => ‘f3’}
hbase> # 上一命令的缩写方法如下：
hbase> create ‘t1’, ‘f1’, ‘f2’, ‘f3’

hbase> create ‘t1’, {NAME => ‘f1’, VERSIONS => 1, TTL => 2592000, BLOCKCACHE => true}
hbase> create ‘t1’, {NAME => ‘f1’, CONFIGURATION => {‘hbase.hstore.blockingStoreFiles’ => ’10’}}
```
表配置选项可被放在参数的最后。
#### describe
描述特定表。
```
hbase> describe ‘t1’
```
#### disable
禁止特定表。
```
hbase> disable ‘t1’
```
#### disable_all
禁止匹配给定正则表达式的所有表。
```
hbase> disable_all ‘t.*’
```
#### is_disabled
判断特定表是否被禁止。
```
hbase> is_disabled ‘t1’
```
#### drop 
删除特定表。表必须先被禁止。
```
hbase> drop ‘t1’
```
#### drop_all
删除匹配给定正则表达式的所有表。
```
hbase> drop_all ‘t.*’
```
#### enable
使能特定表。
```
hbase> enable ‘t1’
```
#### enable_all
使能匹配给定正则表达式的所有表。
```
hbase> enable_all ‘t.*’
```
#### is_enabled
判断特定表是否使能。
```
hbase> is_enabled ‘t1’
```
#### exists
判断特定表是否存在。
```
hbase> exists ‘t1’
```
#### list
列举HBase中所有表。可选的正则表达式参数可被用于过滤输出
```
hbase> list
hbase> list ‘abc.*’
```
#### show_filters
显示HBase中所有过滤器。
```
hbase> show_filters
```
#### alter_status
获得alter命令状态。提供一个表名参数，返回表中收到更新的schema的region数目。
```
hbase> alter_status ‘t1’
```
#### alter_async
修改列族schema，不等待所有region收到schema变动。提供表名和指定新列族schema的字典。字典必须包含所要修改的列族名。

对表‘t1’修改或添加列族‘f1’从当前值到最大版本5：
```
hbase> alter_async ‘t1’, NAME => ‘f1’, VERSIONS => 5 删除表‘t1’中的列族‘f1’:
hbase> alter_async ‘t1’, NAME => ‘f1’, METHOD => ‘delete’or a shorter version:hbase> alter_async ‘t1’, ‘delete’ => ‘f1’
```
也可以修改诸如MAX_FILESIZE、READONLY、MEMSTORE_FLUSHSIZE、DEFERRED_LOG_FLUSH等表属性，例如将region最大容量设为128MB：
```
hbase> alter ‘t1’, METHOD => ‘table_att’, MAX_FILESIZE => ‘134217728’
```
可以把多个命令换成一个命令中：
```
hbase> alter ‘t1’, {NAME => ‘f1’}, {NAME => ‘f2’, METHOD => ‘delete’}
```
检查是否所有region已被更新，使用alter_status

### 3) 数据操作命令

#### count
获得表中行数。该操作可能会耗费很长时间。(运行 ‘$HADOOP_HOME/bin/hadoop jar hbase.jar rowcount’以执行一个计数mapreduce作业)。默认当前行数每1000行显示一次，计数间隔可选指定。行数扫描默认是能缓存扫描，默认缓存容龄为10行。如果你的行大小较小，可以增大概参数。例如：
```
hbase> count ‘t1’
hbase> count ‘t1’, INTERVAL => 100000
hbase> count ‘t1’, CACHE => 1000
hbase> count ‘t1’, INTERVAL => 10, CACHE => 1000
```
相同的命令也可以运行在一个表引用上。假设有对表‘t1’的的引用t，相应命令为：
```
hbase> t.count
hbase> t.count INTERVAL => 100000
hbase> t.count CACHE => 1000
hbase> t.count INTERVAL => 10, CACHE => 1000
```
#### delete
在特定表/行/列及可选的时戳坐标放置一个删除单元值。删除必须严格匹配被删除单元的标记。当扫描时，删除单元抑制更旧的版本。从表‘t1’的行‘r1’、列‘c1’删除一个单元并标识时间‘ts1’：
```
hbase> delete ‘t1’, ‘r1’, ‘c1’, ts1 
```
相同的命令也可以运行在一个表引用上。假设有对表‘t1’的的引用t，相应命令为：
```
hbase> t.delete ‘r1’, ‘c1’, ts1
```
#### deleteall
删除给定行的全部单元。提供表名、行、及可选的列和时戳。例如：
```
hbase> deleteall ‘t1’, ‘r1’
hbase> deleteall ‘t1’, ‘r1’, ‘c1’
hbase> deleteall ‘t1’, ‘r1’, ‘c1’, ts1
```
相同的命令也可以运行在一个表引用上。假设有对表‘t1’的的引用t，相应命令为：
```
hbase> t.deleteall ‘r1’
hbase> t.deleteall ‘r1’, ‘c1’
hbase> t.deleteall ‘r1’, ‘c1’, ts1
```
#### get
获取行或单元内容。提供表名、行及可选的列、时戳、时间范围和版本的词典。例如
```
hbase> get ‘t1’, ‘r1’
hbase> get ‘t1’, ‘r1’, {TIMERANGE => [ts1, ts2]}
hbase> get ‘t1’, ‘r1’, {COLUMN => ‘c1’}
hbase> get ‘t1’, ‘r1’, {COLUMN => [‘c1’, ‘c2’, ‘c3’]}
hbase> get ‘t1’, ‘r1’, {COLUMN => ‘c1’, TIMESTAMP => ts1}
hbase> get ‘t1’, ‘r1’, {COLUMN => ‘c1’, TIMERANGE => [ts1, ts2], VERSIONS => 4}
hbase> get ‘t1’, ‘r1’, {COLUMN => ‘c1’, TIMESTAMP => ts1, VERSIONS => 4}
hbase> get ‘t1’, ‘r1’, {FILTER => “ValueFilter(=, ‘binary:abc’)”}
hbase> get ‘t1’, ‘r1’, ‘c1’
hbase> get ‘t1’, ‘r1’, ‘c1’, ‘c2’
hbase> get ‘t1’, ‘r1’, [‘c1’, ‘c2’]
```
除了默认‘toStringBinary’格式，‘get’也支持基于列的定制格式。一个用户可在get规范中列名增加定义格式器。定义格式器方式如下：
- 或者使用org.apache.hadoop.hbase.util.Bytes类中的方法名(例如toInt、toString)
- 或者使用定制类及方法名: 例如‘c(MyFormatterClass).format’。

将cf:qualifier1和cf:qualifier2都格式化为整数的示例如下：
```
hbase> get ‘t1’, ‘r1’ {COLUMN => [‘cf:qualifier1:toInt’, ‘cf:qualifier2:c(org.apache.hadoop.hbase.util.Bytes).toInt’] }
```
注意，你仅可以对一个列(cf:qualifer)指定格式器，不能指定一个用于一个列族所有列的格式器。相同的命令也可以运行在一个表引用上（通过get_table或create_table获得）。假设有对表‘t1’的的引用t，相应命令为：
```
hbase> t.get ‘r1’
hbase> t.get ‘r1’, {TIMERANGE => [ts1, ts2]}
hbase> t.get ‘r1’, {COLUMN => ‘c1’}
hbase> t.get ‘r1’, {COLUMN => [‘c1’, ‘c2’, ‘c3’]}
hbase> t.get ‘r1’, {COLUMN => ‘c1’, TIMESTAMP => ts1}
hbase> t.get ‘r1’, {COLUMN => ‘c1’, TIMERANGE => [ts1, ts2], VERSIONS => 4}
hbase> t.get ‘r1’, {COLUMN => ‘c1’, TIMESTAMP => ts1, VERSIONS => 4}
hbase> t.get ‘r1’, {FILTER => “ValueFilter(=, ‘binary:abc’)”}
hbase> t.get ‘r1’, ‘c1’
hbase> t.get ‘r1’, ‘c1’, ‘c2’
hbase> t.get ‘r1’, [‘c1’, ‘c2’]
```
#### get_counter
获取特定表/行/列坐标上计数器单元值。一个单元在HBase上可用原子增加函数管理且数据为二进制编码。例如：
```
hbase> get_counter ‘t1’, ‘r1’, ‘c1’
```
相同的命令也可以运行在一个表引用上。假设有对表‘t1’的的引用t，相应命令为：
```
hbase> t.get_counter ‘r1’, ‘c1’
```
#### incr
在特定表/行/列坐标对单元值增值。从表‘t1’的行‘r1’、列‘c1’对单元值增值1（默认，可略）或10：
```
hbase> incr ‘t1’, ‘r1’, ‘c1’
hbase> incr ‘t1’, ‘r1’, ‘c1’, 1
hbase> incr ‘t1’, ‘r1’, ‘c1’, 10
```
相同的命令也可以运行在一个表引用上。假设有对表‘t1’的的引用t，相应命令为：
```
hbase> t.incr ‘r1’, ‘c1’
hbase> t.incr ‘r1’, ‘c1’, 1
hbase> t.incr ‘r1’, ‘c1’, 10
```
#### put
在特定表/行/列及可选的时戳坐标放置一个单元值。从表‘t1’的行‘r1’、列‘c1’放置一个单元值并标识时间‘ts1’：
```
hbase> put ‘t1’, ‘r1’, ‘c1’, ‘value’, ts1
```
相同的命令也可以运行在一个表引用上。假设有对表‘t1’的的引用t，相应命令为：
```
hbase> t.put ‘r1’, ‘c1’, ‘value’, ts1
```
#### scan
扫描一个表；提供表名和可选的扫描器规范词典。扫描器规范可能包含下列一或多个项:TIMERANGE、FILTER、LIMIT、STARTROW、STOPROW、TIMESTAMP、MAXLENGTH、COLUMNS、CACHE。

如果没有指定列，所有列将被扫描。要扫描列族所有成员，将‘col_family:’中的限定符置空。过滤器可以两种方式指定：
- 使用过滤器语句 - 更多信息见HBASE-4176 JIRA所附的过滤器语言文档
- 使用过滤器的整个包名

例如：
```
hbase> scan ‘.META.’
hbase> scan ‘.META.’, {COLUMNS => ‘info:regioninfo’}
hbase> scan ‘t1’, {COLUMNS => [‘c1’, ‘c2’], LIMIT => 10, STARTROW => ‘xyz’}
hbase> scan ‘t1’, {COLUMNS => ‘c1’, TIMERANGE => [1303668804, 1303668904]}
hbase> scan ‘t1’, {FILTER => “(PrefixFilter (‘row2’) AND (QualifierFilter (>=, ‘binary:xyz’))) AND (TimestampsFilter ( 123, 456))”}
hbase> scan ‘t1’, {FILTER => org.apache.hadoop.hbase.filter.ColumnPaginationFilter.new(1, 0)}
```
对于专家，有个用于开关扫描器块缓存的额外选项 — CACHE_BLOCKS, 默认为开。例如：
```
hbase> scan ‘t1’, {COLUMNS => [‘c1’, ‘c2’], CACHE_BLOCKS => false}
```
此外对于专家，还有一个用于命令扫描器返回（包含删除标记和未分配删除单元）所有单元的高级选项 — RAW，默认为禁止。该选项不能与指定特定列的请求共用。例如：
```
hbase> scan ‘t1’, {RAW => true, VERSIONS => 10}
```
除了默认‘toStringBinary’格式，‘get’也支持基于列的定制格式。一个用户可在get规范中列名增加定义格式器。定义格式器方式如下：
- 或者使用org.apache.hadoop.hbase.util.Bytes类中的方法名(例如toInt、toString)
- 或者使用定制类及方法名: 例如‘c(MyFormatterClass).format’。

将cf:qualifier1和cf:qualifier2都格式化为整数的示例如下：
```
hbase> get ‘t1’, ‘r1’ {COLUMN => [‘cf:qualifier1:toInt’, ‘cf:qualifier2:c(org.apache.hadoop.hbase.util.Bytes).toInt’] }
```
注意，你仅可以对一个列(cf:qualifer)指定格式器，不能指定一个用于一个列族所有列的格式器。
相同的命令也可以运行在一个表引用上，首先需要获得表的引用，相应命令为：
```
hbase> t = get_table ‘t’
hbase> t.scan
```
注意在使用表引用时，仍可以提供所有过滤器、列、选项等。
#### truncate
禁止、删除并重生特定表。例如：
```
hbase>truncate ‘t1’
```

### 4) HBase工具命令

#### assign
分配一个region。使用须注意。如果一个region已经被分配，该命令会强制重新分配。仅供专家使用。例如：
```
hbase> assign ‘REGION_NAME’
```
#### balancer
触发集群均衡器。
如均衡器运行且能够让region服务器取消所有region以进行均衡（重新分配自身是异步的），则返回true。否则返回false（如果region处于状态变迁则不会运行）。
例如：
```
hbase> balancer
```
#### balance_switch
使能/禁止均衡器。返回上一均衡器状态。例如：
```
hbase> balance_switch true
hbase> balance_switch false
```
#### close_region
关闭单个region。请求master将集群上一个region关闭。如果提供‘SERVER_NAME’的话，请求所在regionserver直接关闭region。关闭region，master期望‘REGIONNAME’是完全限定region名。当请求所在regionserver直接关闭一个region，仅能提供region的编码名。
例如一个region名为TestTable,0094429456,1289497600452.527db22f95c8a9e0116f0cc13c680396。
编码的region名则为527db22f95c8a9e0116f0cc13c680396。服务器名是主机名、端口名及regionserver的启动代码。例如：host187.example.com,60020,1289493121758。例如：该命令以关闭运行在regionserver上region作为结束。该操作无需引入master（master不会了解该关闭）。一旦关闭，region将保持关闭状态。使用assign来重新打开/分配。使用unassign或move来分配集群内其他位置的region。使用须谨慎，仅供专家使用。
例如：
```
hbase> close_region ‘REGIONNAME’
hbase> close_region ‘REGIONNAME’, ‘SERVER_NAME’
```
#### compact
提供一个表参数压缩所有region，或提供一个region row参数压缩单个region。也可以压缩region内单个列族。例如：

压缩一个表中所有region：
```
hbase> compact ‘t1’
```
压缩整个region：
```
hbase> compact ‘r1’
```
仅压缩一个region中一个列族：
```
hbase> compact ‘r1’, ‘c1’
```
压缩一个表中一个列族：
```
hbase> compact ‘t1’, ‘c1’
```
#### flush
提供一个表参数flush所有region，或提供一个region row参数flush单个region。例如：
```
hbase> flush ‘TABLENAME’
hbase> flush ‘REGIONNAME’
```
#### major_compact
提供一个表参数重量级压缩所有region，或提供一个region row参数重量级压缩单个region。也可以重量级压缩region内单个列族。例如：

压缩一个表中所有region:
```
hbase> major_compact ‘t1’
```
压缩整个region:
```
hbase> major_compact ‘r1’
```
压缩一个region内单个列族:
```
hbase> major_compact ‘r1’, ‘c1’
```
压缩一个表内单个列族:
```
hbase> major_compact ‘t1’, ‘c1’
```
#### move
移动region。可以可选地指定目标regionserver或随机选择一个。注意：需要传递编码后的region名，而不是region名。因此这个命令与其他命令稍有不同。编码的region名是region名的哈希后缀。例如一个region名为TestTable,0094429456,1289497600452.527db22f95c8a9e0116f0cc13c680396. 编码的region名则为527db22f95c8a9e0116f0cc13c680396。服务器名是主机名、端口名及regionserver的启动代码。例如：host187.example.com,60020,1289493121758。例如：
```
hbase> move ‘ENCODED_REGIONNAME’
hbase> move ‘ENCODED_REGIONNAME’, ‘SERVER_NAME’
```
#### split
分割整表或将一个region。使用第二个参数，可以为region显式指定分割键。例如：
```
split ‘tableName’
split ‘regionName’ # format: ‘tableName,startKey,id’
split ‘tableName’, ‘splitKey’
split ‘regionName’, ‘splitKey’
```
#### unassign
取消分配一个region。unassign将关闭当前位置的region，之后重新打开。传递true强制取消分配（‘强制’将在重新分配前清除其在master内存内的所有状态。如果导致双重分配，使用hbck-fix解决。） 使用须谨慎，仅供专家使用。例如：
```
hbase> unassign ‘REGIONNAME’
hbase> unassign ‘REGIONNAME’, true
```
#### hlog_roll
滚动日志记录器。即开始向新文件写日志消息。regionserver应作为一个参数提供。服务器名是主机名、端口名及regionserver的启动代码。例如：host187.example.com,60020,1289493121758?(在masterui或shell中查询详细状态可获知服务器名)。
```
hbase>hlog_roll
```
#### zk_dump
导出ZooKeeper所见的HBase集群状态。例如：
```
hbase>zk_dump
```

### 5) 集群复制命令

添加所要复制到的对端集群，集群键组成类似于：hbase.zookeeper.quorum:hbase.zookeeper.property.clientPort:zookeeper.znode.parent，
这提供了HBase连接其他集群的全路径。例如：
```
hbase> add_peer ‘1’, “server1.mryqu.com:2181:/hbase”
hbase> add_peer ‘2’, “zk1,zk2,zk3:2182:/hbase-prod”
```
#### remove_peer
停止特定复制流并删除所有元数据信息。例如：
```
hbase> remove_peer ‘1’
```
#### list_peers
列举所有复制对端集群。
```
hbase> list_peers
```
#### enable_peer
重启已被禁止的向特定对端集群的复制。例如：
```
hbase> enable_peer ‘1’
```
#### disable_peer
停止向特定对端集群的复制，但是仍保留复制相关元数据。例如：
```
hbase> disable_peer ‘1’
```
#### start_replication
重启所有复制功能。每个启动的流的状态不确定。
警告：启动/停止复制仅在临界负荷情况下可能被使用。
示例:
```
hbase> start_replication
```
#### stop_replication
停止所有复制功能。每个停掉的流的状态不确定。
警告：启动/停止复制仅在临界负荷情况下可能被使用。
示例:
```
hbase> stop_replication
```

### 6) 安全命令

赋予用户特定权限。
语法：所赋予的权限可以是“RWXCA”中零或多个字母。READ(‘R’), WRITE(‘W’), EXEC(‘X’), CREATE(‘C’), ADMIN(‘A’)
```
hbase> grant ‘bobsmith’, ‘RW’, ‘t1’, ‘f1’, ‘col1’
```
</tr>#### revoke
取消一个用户访问权限。
语法：revoke
```
hbase> revoke ‘bobsmith’, ‘t1’, ‘f1’, ‘col1’
```
#### user_permission
显示特定用户的所有权限。
语法：user_permission
```
hbase> user_permission ‘table1’
```

英文原文：[HBase shell commands](https://learnhbase.wordpress.com/2013/03/02/hbase-shell-commands/)
