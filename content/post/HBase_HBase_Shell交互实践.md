---
title: '[HBase] HBase Shell交互实践'
date: 2013-10-25 20:12:48
categories: 
- Hadoop+Spark
- HBase
tags: 
- hbase
- shell
- interacting
- practice
---
HBase Shell是对HBase的脚本接口，是一个JRuby REPL(Read-Eval-PrintLoop，“读取-求值-输出”循环)，可以通过脚本访问所有HBase客户端API。

### 单列族练习

#### 创建表friends
```
$ hbase shell

hbase(main):001:0> list
TABLE
customer
1 row(s) in 0.2050 seconds

=> ["customer", "student"]
hbase(main):002:0> create 'friends', 'd'
0 row(s) in 1.3350 seconds

=> Hbase::Table - friends
hbase(main):003:0> list
TABLE
customer
friends
2 row(s) in 0.0060 seconds

=> ["customer", "friends", "student"]
```

#### 获得表friends的描述说明
```
hbase(main):004:0> describe 'friends'
Table friends is ENABLED
friends
COLUMN FAMILIES DESCRIPTION
{NAME => 'd', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION_SCO
PE => '0', VERSIONS => '1', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL => 'FO
REVER', KEEP_DELETED_CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY => 'false',
BLOCKCACHE => 'true'}
1 row(s) in 0.1000 seconds


```

#### 插入一条数据并查询一行记录
```
hbase(main):005:0> put 'friends', 'ross', 'd:portrayedBy', 'David'
0 row(s) in 0.0990 seconds

hbase(main):006:0> get 'friends', 'ross'
COLUMNCELL
 d:portrayedBy  timestamp=1381748454624, value=David
1 row(s) in 0.0670 seconds


```

#### 插入多条数据并查询整张表
```
hbase(main):007:0> put 'friends', 'chandler', 'd:portrayedBy', 'Matthew'
0 row(s) in 0.0080 seconds

hbase(main):008:0> put 'friends', 'joey', 'd:portrayedBy', 'Matt'
0 row(s) in 0.0050 seconds

hbase(main):009:0> put 'friends', 'rachel', 'd:gender', 'female'
0 row(s) in 0.0050 seconds

hbase(main):010:0> put 'friends', 'monica', 'd:gender', 'female'
0 row(s) in 0.0060 seconds

hbase(main):011:0> put 'friends', 'phoebe', 'd:gender', 'female'
0 row(s) in 0.0070 seconds

hbase(main):012:0> scan 'friends'
ROW             COLUMN+CELL
 chandler       column=d:portrayedBy, timestamp=1381748473491, value=Matthew
 joey           column=d:portrayedBy, timestamp=1381748473532, value=Matt
 monica         column=d:gender, timestamp=1381748473574, value=female
 phoebe         column=d:gender, timestamp=1381748474832, value=female
 rachel         column=d:gender, timestamp=1381748473552, value=female
 ross           column=d:portrayedBy, timestamp=1381748454624, value=David
6 row(s) in 0.0390 seconds


```

#### 查询一行记录

其中行键joey对应有记录，而janice对应无记录：
```
hbase(main):013:0> get 'friends', 'joey'
COLUMNCELL
 d:portrayedBy  timestamp=1381748473532, value=Matt
1 row(s) in 0.0080 seconds

hbase(main):014:0> get 'friends', 'janice'
COLUMNCELL
0 row(s) in 0.0080 seconds


```

#### 查询整张表中行键大于等于janice的记录

行键chandler比janice小，因此没有显示：
```
hbase(main):016:0> scan 'friends', {STARTROW => 'janice'}
ROW             COLUMN+CELL
 joey           column=d:portrayedBy, timestamp=1381748473532, value=Matt
 monica         column=d:gender, timestamp=1381748473574, value=female
 phoebe         column=d:gender, timestamp=1381748474832, value=female
 rachel         column=d:gender, timestamp=1381748473552, value=female
 ross           column=d:portrayedBy, timestamp=1381748454624, value=David
5 row(s) in 0.0180 seconds


```

#### 插入多条数据并重新查询整张表
```
hbase(main):017:0> put 'friends', 'ross', 'd:occupation', 'paleontologist'
0 row(s) in 0.0080 seconds

hbase(main):018:0> put 'friends', 'joey', 'd:occupation', 'actor'
0 row(s) in 0.0050 seconds

hbase(main):019:0> put 'friends', 'chandler', 'd:occupation', 'statistical analysis and data reconfiguration'
0 row(s) in 0.0060 seconds

hbase(main):020:0> put 'friends', 'monica', 'd:occupation', 'chef'
0 row(s) in 0.0080 seconds

hbase(main):021:0> scan 'friends'
ROW             COLUMN+CELL
 chandler       column=d:occupation, timestamp=1381757551434, value=statistical 
                analysis and data reconfiguration
 chandler       column=d:portrayedBy, timestamp=1381748473491, value=Matthew
 joey           column=d:occupation, timestamp=1381757551378, value=actor
 joey           column=d:portrayedBy, timestamp=1381748473532, value=Matt
 monica         column=d:gender, timestamp=1381748473574, value=female
 monica         column=d:occupation, timestamp=1381757552772, value=chef
 phoebe         column=d:gender, timestamp=1381748474832, value=female
 rachel         column=d:gender, timestamp=1381748473552, value=female
 ross           column=d:occupation, timestamp=1381757551357, value=paleontologist
 ross           column=d:portrayedBy, timestamp=1381748454624, value=David
6 row(s) in 0.0310 seconds


```

#### 删除joey行的d:portrayedBy列并更新d:occupation列
```
hbase(main):022:0> delete 'friends', 'joey', 'd:portrayedBy'
0 row(s) in 0.0310 seconds

hbase(main):023:0> put 'friends', 'joey', 'd:occupation', 'Waiter'
0 row(s) in 0.0080 seconds

hbase(main):024:0> scan 'friends'
ROW             COLUMN+CELL
 chandler       column=d:occupation, timestamp=1381757551434, value=statistical 
                analysis and data reconfiguration
 chandler       column=d:portrayedBy, timestamp=1381748473491, value=Matthew
 joey           column=d:occupation, timestamp=1381748815753, value=Waiter
 monica         column=d:gender, timestamp=1381748473574, value=female
 monica         column=d:occupation, timestamp=1381757552772, value=chef
 phoebe         column=d:gender, timestamp=1381748474832, value=female
 rachel         column=d:gender, timestamp=1381748473552, value=female
 ross           column=d:occupation, timestamp=1381757551357, value=paleontologist
 ross           column=d:portrayedBy, timestamp=1381748454624, value=David
6 row(s) in 0.0280 seconds


```

#### 删除ross行
```
hbase(main):025:0> deleteall 'friends', 'ross'
0 row(s) in 0.0060 seconds

hbase(main):026:0> scan 'friends'
ROW             COLUMN+CELL
 chandler       column=d:occupation, timestamp=1381757551434, value=statistical 
                analysis and data reconfiguration
 chandler       column=d:portrayedBy, timestamp=1381748473491, value=Matthew
 joey           column=d:occupation, timestamp=1381748815753, value=Waiter
 monica         column=d:gender, timestamp=1381748473574, value=female
 monica         column=d:occupation, timestamp=1381757552772, value=chef
 phoebe         column=d:gender, timestamp=1381748474832, value=female
 rachel         column=d:gender, timestamp=1381748473552, value=female
5 row(s) in 0.0160 seconds


```

#### 禁止并丢弃friends表
```
hbase(main):027:0> list
TABLE
customer
friends
2 row(s) in 0.0090 seconds

=> ["customer", "friends", "student"]
hbase(main):028:0> disable 'friends'
0 row(s) in 2.2720 seconds

hbase(main):029:0> drop 'friends'
0 row(s) in 1.2460 seconds

hbase(main):030:0> list
TABLE
customer
1 row(s) in 0.0040 seconds

=> ["customer", "student"]
hbase(main):031:0> exit
$
```

### Hbase Shell执行脚本练习
```
$ cat friends.rb
if !list.include?("friends")
  create 'friends', 'd'
end

put 'friends', 'ross', 'd:portrayedBy', 'David'
put 'friends', 'chandler', 'd:portrayedBy', 'Matthew'
put 'friends', 'joey', 'd:portrayedBy', 'Matt'
put 'friends', 'rachel', 'd:gender', 'female'
put 'friends', 'monica', 'd:gender', 'female'
put 'friends', 'phoebe', 'd:gender', 'female'

put 'friends', 'ross', 'd:occupation', 'paleontologist'
put 'friends', 'joey', 'd:occupation', 'actor'
put 'friends', 'chandler', 'd:occupation', 'statistical analysis and data reconfiguration'
put 'friends', 'monica', 'd:occupation', 'chef'

exit
$ hbase shell -n friends.rb

TABLE
customer
1 row(s) in 0.2340 seconds

0 row(s) in 1.2530 seconds

0 row(s) in 0.1790 seconds

0 row(s) in 0.0060 seconds

0 row(s) in 0.0040 seconds

0 row(s) in 0.0070 seconds

0 row(s) in 0.0040 seconds

0 row(s) in 0.0040 seconds

0 row(s) in 0.0030 seconds

0 row(s) in 0.0040 seconds

0 row(s) in 0.0030 seconds

0 row(s) in 0.0040 seconds

$ hbase shell

hbase(main):001:0> list
TABLE
customer
friends
2 row(s) in 0.2010 seconds

=> ["customer", "friends", "student"]
hbase(main):002:0> scan 'friends'
ROW             COLUMN+CELL
 chandler       column=d:occupation, timestamp=1381748474147, value=statistical
                analysis and data reconfiguration
 chandler       column=d:portrayedBy, timestamp=1381748474109, value=Matthew
 joey           column=d:occupation, timestamp=1381748474143, value=actor
 joey           column=d:portrayedBy, timestamp=1381748474116, value=Matt
 monica         column=d:gender, timestamp=1381748474129, value=female
 monica         column=d:occupation, timestamp=1381748474151, value=chef
 phoebe         column=d:gender, timestamp=1381748474133, value=female
 rachel         column=d:gender, timestamp=1381748474124, value=female
 ross           column=d:occupation, timestamp=1381748474138, value=paleontologist
 ross           column=d:portrayedBy, timestamp=1381748474094, value=David
6 row(s) in 0.1620 seconds
```

### 多列族练习

#### 创建有两个列族的表并插入多条数据
```
$ hbase shell

hbase(main):001:0> create 'student', {NAME=>'addr'}, {NAME=>'score'}
0 row(s) in 1.4160 seconds

=> Hbase::Table - student
hbase(main):002:0> put 'student',  'jason',  'addr:city', 'xian'
0 row(s) in 0.1420 seconds

hbase(main):003:0> put 'student',  'jason',  'addr:state', 'ShanXi'
0 row(s) in 0.0050 seconds

hbase(main):004:0> put 'student',  'jason',  'score:numb', '1234'
0 row(s) in 0.0050 seconds

hbase(main):005:0> put 'student',  'jason',  'score:date', '2013-10-01'
0 row(s) in 0.0050 seconds

hbase(main):006:0> put 'student',  'nancy',  'addr:city', 'beijing'
0 row(s) in 0.0060 seconds

hbase(main):007:0> put 'student',  'nancy',  'addr:state', 'BeiJing'
0 row(s) in 0.0040 seconds

hbase(main):008:0> put 'student',  'nancy',  'score:numb', '6666'
0 row(s) in 0.0040 seconds

hbase(main):009:0> put 'student',  'tina',  'addr:city', 'tianjin'
0 row(s) in 0.0060 seconds

hbase(main):010:0> put 'student',  'tina',  'addr:state', 'TianJin'
0 row(s) in 0.0050 seconds

hbase(main):011:0> put 'student',  'jason',  'addr:city', 'chengdu'
0 row(s) in 0.0050 seconds

hbase(main):012:0> put   'student',  'jason',  'addr:state', 'SiChuan'
0 row(s) in 0.0050 seconds

hbase(main):013:0> put   'student',  'jason',  'score:numb', '5555'

hbase(main):014:0> put   'student',  'nancy',  'addr:state', 'ShanXi'
0 row(s) in 0.0040 seconds

hbase(main):015:0> put   'student',  'alex', 'addr:state', 'HeNan'
0 row(s) in 0.0080 seconds


```

#### 查询行键为jason的所有addr列族数据
```
hbase(main):016:0> get  'student', 'jason', {COLUMNS=>['addr']}
COLUMN                  CELL
 addr:city              timestamp=1381757474426, value=chengdu
 addr:state             timestamp=1381757474446, value=SiChuan
2 row(s) in 0.0360 seconds


```

#### 查询行键为jason的所有score:numb列数据
```
hbase(main):017:0> get  'student', 'jason', {COLUMNS=>['score:numb']}
COLUMN                  CELL
 score:numb             timestamp=1381757474588, value=5555
1 row(s) in 0.0080 seconds


```

#### 让score列族存储更多版本的数据
```
hbase(main):018:0> describe 'student'
Table student is ENABLED
student
COLUMN FAMILIES DESCRIPTION
{NAME => 'addr', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION_
SCOPE => '0', VERSIONS => '1', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL 
=> 'FOREVER', KEEP_DELETED_CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY =>
 'false', BLOCKCACHE => 'true'}
{NAME => 'score', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION
_SCOPE => '0', VERSIONS => '1', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL
 => 'FOREVER', KEEP_DELETED_CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY =>
 'false', BLOCKCACHE => 'true'}
2 row(s) in 0.0300 seconds

hbase(main):019:0> alter  'student' , NAME => 'score', VERSIONS => 3
Updating all regions with the new schema...
1/1 regions updated.
Done.
0 row(s) in 1.9230 seconds

hbase(main):020:0> describe 'student'
Table student is ENABLED
student
COLUMN FAMILIES DESCRIPTION
{NAME => 'addr', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION_SCOPE => '0', VERSIONS => '1', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL => 'FOREVER', KEEP_DELETED_CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY => 'false', BLOCKCACHE => 'true'}
{NAME => 'score', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION_SCOPE => '0', VERSIONS => '3', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL =>
'FOREVER', KEEP_DELETED_CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY => 'false', BLOCKCACHE => 'true'}
2 row(s) in 0.0200 seconds


```

#### 获取一个单元格更多版本的数据
```
hbase(main):021:0> put   'student',  'jason',  'score:numb', '1235'
0 row(s) in 0.0080 seconds

hbase(main):022:0> put   'student',  'jason',  'score:numb', '1236'
0 row(s) in 0.0190 seconds

hbase(main):023:0> get   'student', 'jason', {COLUMNS=>['score:numb']}
COLUMN                  CELL
 score:numb             timestamp=1381748525860, value=1236
1 row(s) in 0.0100 seconds

hbase(main):024:0> get  'student', 'jason', {COLUMNS=>['score:numb'], VERSIONS => 3}
COLUMN           CELL
 score:numb      timestamp=1381748525860, value=1236
 score:numb      timestamp=1381748524871, value=1235
 score:numb      timestamp=1381757474588, value=5555
3 row(s) in 0.0120 seconds


```

#### 获取行键大于等于j、小于t的的数据
```
hbase(main):025:0> scan  'student',  { STARTROW => 'j', STOPROW => 't'}
ROW              COLUMN+CELL
 jason           column=addr:city, timestamp=1381757474426, value=chengdu
 jason           column=addr:state, timestamp=1381757474446, value=SiChuan
 jason           column=score:date, timestamp=1381757474194, value=2013-10-01
 jason           column=score:numb, timestamp=1381748525860, value=1236
 nancy           column=addr:city, timestamp=1381757474320, value=beijing
 nancy           column=addr:state, timestamp=1381757474607, value=ShanXi
 nancy           column=score:numb, timestamp=1381757474364, value=6666
2 row(s) in 0.0340 seconds

hbase(main):026:0> scan 'student'
ROW              COLUMN+CELL
 alex            column=addr:state, timestamp=1381757475608, value=HeNan
 jason           column=addr:city, timestamp=1381757474426, value=chengdu
 jason           column=addr:state, timestamp=1381757474446, value=SiChuan
 jason           column=score:date, timestamp=1381757474194, value=2013-10-01
 jason           column=score:numb, timestamp=1381748525860, value=1236
 nancy           column=addr:city, timestamp=1381757474320, value=beijing
 nancy           column=addr:state, timestamp=1381757474607, value=ShanXi
 nancy           column=score:numb, timestamp=1381757474364, value=6666
 tina            column=addr:city, timestamp=1381757474385, value=tianjin
 tina            column=addr:state, timestamp=1381757474405, value=TianJin
4 row(s) in 0.0330 seconds


```

#### 删除行键为nancy的addr:city列的数据

MapR发行版还支持删除某一行某一列族的全部数据。
```
hbase(main):027:0> delete   'student',  'nancy',  'addr:city'
0 row(s) in 0.0200 seconds

hbase(main):028:0> get 'student', 'nancy'
COLUMN           CELL
 addr:state      timestamp=1381757474607, value=ShanXi
 score:numb      timestamp=1381757474364, value=6666
2 row(s) in 0.0100 seconds


```

#### 统计表中行数
```
hbase(main):029:0> count 'student'
4 row(s) in 0.0240 seconds

=> 4
```

### 命名空间练习
```
hadoop@node50064:~$ hbase shell

hbase(main):001:0> list_namespace
NAMESPACE
default
hbase
2 row(s) in 0.2330 seconds

hbase(main):002:0> list
TABLE
customer
friends
student
3 row(s) in 0.0190 seconds

=> ["customer", "friends", "student"]
hbase(main):003:0> create_namespace 'yqu_ns'
0 row(s) in 0.2910 seconds

hbase(main):004:0> create 'yqu_ns:person', 'd'
0 row(s) in 13.7110 seconds

=> Hbase::Table - yqu_ns:person
hbase(main):005:0> create 'person', 'd'
0 row(s) in 13.6960 seconds

=> Hbase::Table - person
hbase(main):006:0> list_namespace
NAMESPACE
default
hbase
yqu_ns
3 row(s) in 0.0120 seconds

hbase(main):007:0> list
TABLE
customer
friends
person
student
yqu_ns:person
5 row(s) in 0.0090 seconds

=> ["customer", "friends", "person", "student", "yqu_ns:person"]
hbase(main):008:0> list_namespace_tables 'default'
TABLE
customer
friends
person
student
4 row(s) in 0.0250 seconds

hbase(main):009:0> list_namespace_tables 'yqu_ns'
TABLE
person
1 row(s) in 0.0060 seconds

hbase(main):010:0> drop_namespace 'yqu_ns'

ERROR: org.apache.hadoop.hbase.constraint.ConstraintException: Only empty namespaces can be removed. Namespace yqu_ns has 1 tables
        at org.apache.hadoop.hbase.master.TableNamespaceManager.remove(TableNamespaceManager.
        at org.apache.hadoop.hbase.master.HMaster.deleteNamespace(HMaster.
        at org.apache.hadoop.hbase.master.MasterRpcServices.deleteNamespace(MasterRpcServices.
        at org.apache.hadoop.hbase.protobuf.generated.MasterProtos$MasterService$2.callBlockingMethod(MasterProtos.
        at org.apache.hadoop.hbase.ipc.RpcServer.call(RpcServer.
        at org.apache.hadoop.hbase.ipc.CallRunner.run(CallRunner.
        at org.apache.hadoop.hbase.ipc.RpcExecutor.consumerLoop(RpcExecutor.
        at org.apache.hadoop.hbase.ipc.RpcExecutor$1.run(RpcExecutor.
        at 

Here is some help for this command:
Drop the named namespace. The namespace must be empty.


hbase(main):011:0> disable 'yqu_ns:person'
0 row(s) in 2.3230 seconds

hbase(main):012:0> drop 'yqu_ns:person'
0 row(s) in 3.5720 seconds

hbase(main):013:0> drop_namespace 'yqu_ns'
0 row(s) in 0.0200 seconds

hbase(main):014:0> list_namespace
NAMESPACE
default
hbase
2 row(s) in 0.0130 seconds

hbase(main):015:0>
```
