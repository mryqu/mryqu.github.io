---
title: '[MapR培训笔记]Hadoop基础'
date: 2015-11-25 06:23:37
categories: 
- BigData
tags: 
- hadoop
- mapr-fs
---
## 学习目标

- **大数据介绍**: 理解大数据定义，判断是否存在大数据问题，描述如何用Hadoop解决大数据问题；
- **Hadoop核心元素**:描述分布式文件系统如何工作，map/reduce如何在分布式文件系统上处理数据；
- **Hadoop工具生态系统**: 了解Hadoop相关工具及其作用；
- **解决大数据用例**: 描述Hadoop生态系统如何协同解决各种大数据用例，如何在不同场景下选择工具。

## 第一课 数据如何变大

### 学习目标

- 定义大数据及大数据问题
- 描述Hadoop主要部件

### 大数据

差不多是4V中的前三个,以及使数据难于描述、存储或处理的一些其他特性
- **Volume（大量）**:太大以至于系统无法处理
- **Variety（多样）**: 太多不同种类的数据，无法简单描述
- **Velocity（高速）**: 数据产生太快以至于系统无法处理
- **Value（价值）**:

### Hadoop主要部件

![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMgy70N1a925Ada.jpg)

Google收到大数据挑战后，认识到无法用传统关系型数据库解决，创建了GFS+BigTabel+Map/Reduce。
- GFS将文件分割成块，分布在集群的节点上。文件块在不同节点进行复制，以防止节点故障导致的数据丢失。
- BigTable是使用GFS存储和获取数据的（分布式、多级）数据库系统。BigTable使用行键、列键和时戳映射到所存储的数据，可以不重写已有数据在不同时间对相同信息进行采集。行被分片为称之为Tablet的子表，分布到集群内。BigTable被设计成可以处理大量数据，可以无需重新配置已有文件的情况下向集群添加新的节点。
- 并行处理范式map/reduce被用于处理存储在GPS上的数据。map/reduce代表处理的两个步骤。在mapping阶段，所有数据在逻辑上分割，map函数应用于所有割片以生成键值对。框架对所有来自mapper的键值对进行排序然后在reducer之间分片。在reduce阶段，reduce函数应用于所有分片。map/reduce是一种分而治之的方式，将单个庞大的作业分解成一系列小的可管理的任务。

Google实验多年后发表了论文阐述了他们的大数据解决方案。DougCutting以此在Yahoo开发一个项目，后来开源成Apache基金会项目下的Hadoop（Cutting儿子玩具象的名字）。
Mapr利用Hadoop理念，开发了更快、更稳定的企业版Hadoop。

## 第二课 Hadoop核心

### 学习目标

- 本地&分布式文件系统
- MapR-FS中的数据管理
- （使用命令行）执行数据管理
- Map Reduce范式

### 本地文件系统

HFS/NTFS（读写）和CDFS（只读）都是本地文件系统。文件系统中每个文件都由一个iNode和一系列数据块构成。iNode存储文件元数据，例如文件类型、权限、所有者、文件名和最后一次修改时间等信息，它还存储文件所存储的数据块的指针。数据块用于存储文件的实际内容。
本地文件系统的常见问题
- 硬盘故障：本地硬盘镜像（RAID-1）
- 丢失：云镜像
- 人为失误
  - 误删：定期增量备份
  - 空间不足：增加硬盘、硬盘阵列（RAID-0）

### 分布式文件系统

分布式文件系统行为与RAID-0类似，但硬盘分布在多个服务器上。由Sun微系统公司开发的网络文件系统NFS仍广泛用于在网络内存储和获取数据。
分布式文件系统当处理数据时致力于透明性，即对于客户端程序来说，文件系统与本地文件系统类似，分布式文件系统不可见。由于数据在网络内多个机器内分布，分布式文件系统使用数据定位器存储数据位置信息。与本地文件系统中的iNode类似，数据定位器只想数据在分布式文件系统中存储的位置。

### MapR-FS存储

MapRFS是分布式文件系统，是Hadoop的MapR分发版的底层文件系统。它支持所有前面提到的本地文件系统特性，包括读写访问、本地或远程镜像，及在联机时对文件系统扩容的能力。此外，MapR文件系统可以加载并直接处理已有HDFS或NFS文件系统中的数据。

### 物理存储

集群是一组使用分布文件系统（例如MapR-FS）的计算机。集群中每个计算机称为一个节点，每个节点有一或多个物理硬盘。
在MapR-FS中，硬盘组合成组，称为存储池（storagepool）。默认一个存储池有三块硬盘组成。当数据写往存储池，数据在三个磁盘拆分写入，增加写速度。每个节点包含一或多个存储池，所有节点上的所有存储池构成了MapR-FS上的全部可用存储。

### 逻辑存储

MapR-FS将数据写入称之为容器（container）的逻辑单元。一个容器默认大小32GB，一个存储池通常有多个容器。容器内的数据在集群内节点间复制以防止单点故障或硬盘故障。
容器组合成卷（volume）。卷是跨集群内一组节点的数据资源逻辑抽象概念。所有容器及其副本在卷拓扑内的节点上分布。MapR-FS使用称之为容器定位数据库（CDLB）的特定服务存储容器及其副本的位置。CLDB为MapR-FS执行数据定位功能。它为数据存储在那个容器及找到集群内容器及其副本提供查找信息。
许多集群存储策略定义在卷这一级。

### 定义

拓扑（Topology）、快照（Snapshots）、配额（Quotas）、复制（Replication）、镜像（Mirrors）、权限（Permissions）、压缩（Compression）。
- **拓扑**:可以配置不同的拓扑以实施某些数据存放在某些物理位置，例如机架和节点。通过这种方式，你可以设计数据来开发引用局部性以获得性能、可用性和其他适用于你的任意标准。之后可以将这些拓扑与卷进行关联。
- **压缩**: 卷内数据当被写入硬盘时会被自动压缩。
- **镜像**:可以配置策略集群内本地镜像或远程另一集群镜像。镜像对磁盘故障济公一定程度的保护，远程镜像当整个集群故障时可用于灾难恢复。
- **卷快照**:在维护活动卷的持续一致性的同时，员徐创建数据的时间点版本。快照对用户错误提供一定程度的保护，也可以让你在任意时间返回某个数据集版本。快照可以手工创建，也可以基于计划自动定期执行。
- **配额**:磁盘空间使用的上限。每个卷、用户或组都可以有一个配额。用户和组配额适用于对该用户和组所负责的所有卷的大小之和。硬配额在达到配额后会阻止写入，软配额则是发送告警邮件。
- **权限**: 卷级别的权限可被设置为dump、restore、modify、delete或fullcontrol。卷内的文件和目录可以有标准的UNIX权限。
- **复制**:包含卷内容的容器可被冗余复制。默认的复制因子为3，原始数据加上两个备份，但是每个卷都可以设置自己的复制因子。卷内所有容器具有相同的复制设置。

### 汇总

MapR文件系统支持POSIX语义及NFS导出。
MapR文件系统被写入到一个卷，卷是复制、镜像、快照、拓扑和使用权限等数据管理功能的一个管理抽象。
卷数据保存在容器内，卷用于定义数据位置及数据复制。
容器被写入到存储池，存储池是一个或多个物理硬盘。

### 知识检查
![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMgy70UJrSpen3f.jpg)
答案<font color="#B4B4B4">D</font>

### 执行数据管理

HDFS和MapR-FS命令：
- **hadoop fs -mkdir mydir**: 创建新目录
- **haoop fs -copyFromLocal /etc/hosts mydir**:从本地文件系统复制文件到MapR-FS
- **hadoop fs -lsr mydir**: 递归列举目录内容
- **hadoop fs -cat mydir/hosts**: 显示一个文件的内容
- **hadoop fs -rm mydir/h**: 删除指定文件

MapR-FS特有命令：
- **hadoop mfs -ln mydir yourdir**: 在两个目录之间建立链接
- **hadoop mfs -setcompression off mydir**: 关闭目录下的文件压缩
- **hadoop mfs -setchunksize 65536 mydir**: 设置目录下文件的块大小

可在MapR-FS下工作的标准POSIX命令：
- **mkdir**: 创建目录
- **cp**: 复制文件
- **ls**: 列举目录内容
- **ln**: 在两个目录之间建立链接
- **rm**: 删除文件
- **tail**: 选定文件指定部分（显示或复制）
- **grep和awk**: 按模式搜索输入
- **sed**: 流式编辑文件

### Map Reduce历史

map reduce过程由于Hadoop而出名，但是它不是一个新概念，早在70年代的Lisp编程就可以看到。
![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMzy70YsntGsj8b.jpg)
Google使用map reduce以各种方式增强web搜索经验，例如用于帮助索引网页内容以及PageRank算法。
![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMzy70YtKI3p903.jpg)
### Map Reduce过程
![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMzy70Yu6tSoI8c.png)

MapReduce过程有三个阶段：map、shuffle和reduce。
map阶段输入在TaskTracker节点中分割，任务被分配给数据所在的节点。map阶段的节点基于输入中的记录发出键值对。
shuffle阶段由Hadoop框架处理，mapper的输出被分片发往reducer。
在reducer阶段，每个reducer接受一个或多个分片，读取键并遍历与键关联的值列表。Reducer基于应用逻辑返回零或多个键值对。

word count算法示例：
![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMzy70YuaHid4fa.jpg)

## 第三课 Hadoop生态系统

### 学习目标

- **Flume**: 将流数据收集到集群的工具
- **Sqoop**: 在外部数据存储（RDBMS、NoSQL）和Hadoop集群之间传输数据的工具
- **Hbase**: Hadoop上的表数据库
- **Hive**: 对Hadoop集群上存储的数据进行SQL相似的查询
- **Oozie**: Hadoop任务管理
- **Pig**: 分析非结构化数据的数据流脚本语言
- **Mahout**: 使用Hadoop进行机器学习
- **Drill**: 用于结构化、半结构化和嵌套数据的低延迟查询引擎
- **Spark**: 用于集群计算的数据处理引擎

### Hadoop生态系统

![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMgy6Y7Tkt7mnbf.jpg)
Hadoop的两个核心要素，map-r文件系统和map-reduce，用于存储和处理数据，但是这仅是Hadoop成为平台的开端。
进入的数据是各种结构化和非结构化的格式，Hadoop能用于处理许多不同数据源的数据。为了处理不同数据源，几个应用被开发出来将不同类型的数据收集到Hadoop分布式文件系统。除了map-reduce作为Hadoop中最初的处理范式，各种额外的分析和处理工具被开发出来增加Hadoop的使用范围。最后，各种工具被开发出来对Hadoop分布式处理的结果进行可视化、再挖掘或进行其他处理。
所有的这些城区一起构成了Hadoop生态系统。当学习Hadoop生态系统后，你会注意到一些工具提供类似的功能，其中一些甚至替代核心功能。Hadoop生态系统的一个优点就是允许用户选择最适合自己需求的工具。

### Flume

![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMzy70YUvCO1ue4.jpg)
Flume是一个可靠的、可伸缩的服务，可用于将流数据收集到Hadoop集群。Flume作为一个代理执行，包括三个关键元素：
- 源：从系统日志、web服务器日志、Facebook数据或Twitter订阅等外部源消费事件
- 通道：临时保留流事件
- 目的：从通道删除事件并发送到外部仓库，例如MapR-FS集群。

处理流可被用作单过程，将数据从单个流源取到集群内。大多数对Flume的使用以更复杂的配置使用这些元素的某些组合。常见的用例为多跳、扇入和复用。
![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMzy70Z4vuYa521.png)
- **多跳（Multi-hop）**:在多跳用例中，多个源-通道-目的配置连接成一系列，第一个流的目的成为第一个流的源，直到整个流结束。
- **扇入（Fan-in）：在扇入用例中，多个流数据源合并成一个源。**:
- **复用（Multiplex）：在复用用例中，输入数据根据用户输入被送往不同的通道，之后发往不同的仓库或同一仓库的不同分区。**:

无需写与数据源API通信的特定脚本，Flume可以从不同的数据源收集数据，并发往多个仓库。此外，Flume可以配置为在导入数据的同时识别错误并进行反应，使你无需自己实现错误逻辑。

### Sqoop

![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMzy70Z5FwzNxbb.jpg)
Sqoop是一个在外部数据存储和Hadoop集群之间传输数据的工具。Sqoop是一个命令行工具，可用于RDBMS和NoSQL数据。
可以任何客户端运行sqoop，包括你的笔记本。Sqoop将只调用仅含map的MapReduce作业在外部数据存储和Hadoop集群之间传输数据。使用MapReduce对处理提供了并行和容错能力，在集群上的数据可被存储在MapR-FS、Hive表、或HBase表。
Sqoop可在Hadoop集群和外部数据存储之间执行一个表或多个表的导入/导出。，也可以用作执行增量导入或导出，即发生变化的数据会被传输。这些选项通常一起使用，先执行批量导入/导出，然后在此基础上执行增量导入/导出。

### HBase

Apache HBase是一个开源、分布式、版本化的非关系数据库。HBase被设计成处理大量不一致的数据，尤其适合：
- 从系统度量或用户点击等数据源中收集上百万甚至上亿行和列有价值的数据
- 存储聊天或邮件等列之间有不一致值的稀疏数据
- 连续捕获数据并需要随机读写访问，例如web应用的后端或搜索索引![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMzy70ZdS9rC35b.png)

HBase由三类服务器组成，以主从架构创建，但所有服务器一起工作提供表的存储和查找服务。
- RegionServer为读写的数据服务。RegionServer与MapR-FS数据节点搭配，这使得ReginServer服务的数据具有数据本地性。
- Master server负责监控集群内所有RegionServer的健康情况，并为数据定位提供元数据服务。
- HBase客户请求数据的一个子集，定位服务所关注行的RegionServer。客户端直接向RegionServer发送读/写请求，不会访问Masterserver来服务请求。
- Zookeeper服务协调场景内的全部服务器。Zookeeper是集中式服务，为所有服务器维护配置信息、命名、分布式同步、心跳和组服务。

### Hive

![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMzy70ZsdcEFAe2.jpg)
Hive是构建于Hadoop之上的数据仓库基础架构，使用MapReduce提供SQL相似语法进行查询。HiveQL语言提供与SQL机构类似的一系列操作，用于转化成MapReduce程序来产生所期望的查询结果。对Hadoop的访问更加简单，Hive查询可以各种方式提交，包括通过CLI、REST之类的web接口，以及通过ODBC或JDBC。
Hive的核心是驱动。当查询提交给Hive，驱动负责执行查询并返回接口。驱动解析查询并转化为一或多个mapreduce作业。对于查询中每个复杂自居，例如JOIN或过滤，额外的mapreduce作业将串行执行，第一个mapreduce作业的结果导入第二个作业，以此类推。因此，Hive适合对非常大或复杂的完全数据集进行查询，其中mapreduce可以利用并行处理和容错能力。

### Oozie

![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMzy70ZsiCiRP01.jpg)
OOzie是用于创建复杂Hadoop工作流的可伸缩、可扩展的调度程序系统。Oozie可用于管理工作流内多种类型的作业，包括MapReduce、Pig、Hive、Sqoop、distcp以及任意脚本和Java程序。
Hadoop工作流一般分厂复杂，包括以串行、并行方式运行的多个应用程序。Oozie中的工作流以有向无环图（directeda-cyclic graph，DAG）的形式表现。
![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMzy70Zspumad31.jpg)
当在Oozie内创建工作流，客户端可以使用CLI、Java API或RESTAPI之类的web服务编写并编码到一个XML文件。客户端之后向Oozie服务器提交工作流。OOzie服务器联系Hadoop集群内适当的端点以在适当的时间启动每一部分作业。
使用Oozie管理复杂工作流细节，Hadoop应用开发人员无需人工查看作业就可以提交一系列作业，并在转到下一步之前做决定。除了复杂的工作流，Oozie可以显著减少时间相关、定时执行或需要等待数据采集的作业的人工投入量

### Pig

![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMty71tHP90XAb6.png)
Pig是一个分析数据的平台。Pig由称之为“PigLatin”的数据流脚本语言及将这些脚本转化成一些列MapReduce程序的基础设施组成。通过使用MapReduce，PigLatin脚本可用于Hadoop平台对大而复杂的数据集执行转换。
Pig的一个常见用途是数据流水线。例如，你想要从web服务器向数据仓库导入日志。使用Pig，你可以从多个服务器加载日志文件，对一或多个文件实行过滤。可以将这些源连接（JOIN）到一起，在最终排序到期望位置之前执行其他转换。对PigLatin中执行数据转换的每一行代码，一个新的MapReduce程序将被创建用于执行转换。
![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMty71tHUHIeda9.jpg)
Pig也常用于对非结构化数据的即席（adhoc）查询，无需使用模式（schema）。Pig通过用户定义函数实现高度可扩展，这些函数可以用Java、Python、JavaScript、Ruby或Groovy编写。为了查询和转换非常大的、复杂的或非结构化的数据集，Pig提供了一个非常简单的平台来访问MapReduce的平行和容错功能。

### Mahout

![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMty71tI1lTzP31.jpg)
Mahout是一套可扩展机器学习库。它包含一套核心算法，支持数据聚类（clustering，基于相似的主题收集新的数据项）、分类（classification或categorization，创建一套标签，将新文章打上最适合的标签）或协同过滤（collaborativefiltering，通常指推荐系统）。Mahout也支持底层矩阵数学库，以支持自有算法。Mahout传统使用次序算法和MapReduce算法，但是对ApacheSpark和H20（原名oxdata）的支持已经加入Mahout。
![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMty71tIiycMl35.jpg)
推荐系统引擎工作在装满用户（user）、物品（item）及用户对物品的评分（rating）的数据库上。例如，我们想基于具有类似排名历史的其他用户所购买的物品向一个用户推荐一个新物品。当我们的服务准备好一个新的推荐，首先将用户、物品和评分数据加载并存储到DataModel。
一旦具有自己的DataModel，我们需要定义如何比较我们的用户。首先我们需要提供一个UserSimilarity模型。Mahout具有多个UserSimilarity选项使用不同的度量来比较用户。我们可以选择最适合我们要比较数据的相似性度量。
下一步我们定义UserNeighborhood，这是用于比较的相似用户范围。例如，UserNeighborhood为5将给推荐引擎与所分析用户最相似的5个用户。推荐系统运行所选择的UserSimilarity模型通过DataModel查看每个用户对每个物品的评分。对于我们想要推荐新物品的用户，它会选出5个最接近的用户。这些用户评分醉方的物品将会推荐给我们的用户。
推荐引擎能获得非常复杂的结果、以多种方式过滤推荐物品，可离线执行计算。

### Drill

![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMty71tIpRxD826.png)
Drill是用于大数据探索的查询引擎。在提供工业标准ANSISQL熟悉感和生态系统的同时，Drill从一开始就设计成支持半结构化数据高性能分析，可以快速处理现代大数据应用产生的数据。Drill能对文件中的自描述数据，例如JSON、Parquet、文本，以及MapR-DB和HBase表，执行动态查询，无需请求Hive元数据存储中的元数据定义。Drill通过对所有Hive文件格式和HiveUDF的支持，可以在Hive表和视图上执行查询。
Drill中的核心元素是Drillbit。Drillbit是一个守护进程服务，可以安装在集群的所有节点上，任意一个Drillbit能偶接收并处理查询请求。
当一个Drill查询请求到达集群，它被传给某一节点上的drillbit。该drillbit变成了驱动drillbit，负责管理解析查询，为快速有效执行生成优化后的分布式查询计划。驱动drillbit从ZooKeeper获得集群内有效drillbit节点列表，为最大数据本地化选择执行各种查询片段的合适节点。驱动drillbit根据执行计划，在单个节点上调度查询片段的执行。单个节点执行完查询片段后将数据返回给驱动drillbit，然后由驱动drillbit返回给客户端。
drill对数据源支持的灵活性使其可以足够有效，可为在多个数据仓库上执行合并查询（consolidatingquery）或探索未知数据仅使用drill一个工具就能执行所有查询。

### Spark

![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMty71tICDLkA20.jpg)
Spark是在例如Hadoop之类的分布式计算集群上执行通用数据分析的框架。Spark提供了内存内计算，极大增强了MapReduce之上的数据处理速度。Spark运行在已有Hadoop集群之上，可以访问存储在MapR-FS之类的分布式文件系统或Hbase中的Hadoop数据。
Spark也可以通过Spark SQL进行直接Hive查询处理Hive中的结构化数据，可以通过SparkStraming处理HDFS、Flume、Kafka、Twitter或自定义数据源上的流数据。
Spark应用可用Java、Scala或Python编写，这让Spark便于用于数据分析。
![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMty71tIOtiF7b5.jpg)
Spark在用于迭代作业时能特别有效地优化结果，即对相同数据集执行多次机器学习算法。在这种情况下，Spark将数据装载为内存中只读的对象弹性分布式数据集（resilientdistributeddataset，RDD）。在RDD中的数据在集群内节点上分片。如果分片丢失，它可以在内存内重建，提供与Hadoop共同的容错能力。
在机器学习算法的第一个迭代内，Spark和MapReduce具有相似的速度。然而，MapReduce需要从磁盘重新加载数据并为每个迭代启动一个新的作业，而RDD能够缓存在内存中重复使用无需重新加载数据，这使得处理速度显著增加。
通过Spark应用开发的灵活性，RDD的速度和容错能力，流数据、图计算和机器学习的内建库支持，Spark为下一代并行处理分析提供了一个易于使用的平台。

## 第四课 用例

### 学习目标

- 数据仓库优化
- 大规模日志分析
- 创建一个推荐引擎

### Hadoop生态系统回顾

在第三课里，我们介绍了Hadoop生态系统里的几个部分。这里我们将它们归为如下几类，数据源、数据获取（Ingestion）、数据处理和数据处理结果使用。除了归类，这些话题也组成了经典的Hadoop工作流：
- 我们拥有某种或多种数据需要进行信息探究
- 该数据可以使用一种或多种生态系统组件获取并存入Hadoop集群
- 之后使用一种或多种生态系统组件处理数据
- 这些数据处理结果可被我们的组织查看和使用，并可能被再次处理用于进一步研究

#### 数据源

大数据始于数据源，可能是传统结构化数据或新的复杂类型数据，Hadoop对所有数据源提供了单个仓库。
- SQL - 结构化查询语言SQL是用于查询和转换存储在关系型数据库管理系统中的数据。
- NoSQL - NoSQL是无需以表格格式存储的数据模型统称。通常，NoSQL指扁平或嵌套格式的数据。
- 日志数据 - 计算机系统日志抓取了各种各样关于组织内部系统、外部客户交互的信息及其使用方式。
- 流数据 -很多基于web源的流数据，例如Twitter订阅、Facebook帖子、web点击或表单数据都是流数据示例。

#### 数据获取

为了处理多种数据源，几种应用被开发用于获取不同类型数据到Hadoop分布式文件系统。
- Flume - Flume是一个可靠的、可伸缩的将流数据收集到Hadoop集群的服务。
- Sqoop -Sqoop是一个在外部数据存储和Hadoop集群之间传输数据的工具。Sqoop是对RDBMS和NoSQL数据都可使用的一个命令行工具。
- NFS - 网络文件系统是一种分布式文件系统协议，使得计算访问网络之间的文件如同本地挂载存储一般。
- Kafka - Kafka是一个快速、可伸缩的开源消息服务，将日志数据分发到集群内。

#### 数据处理

除了map-reduce作为最初的Hadoop处理范式，很多其他分析和处理工具被开发出来用于其他Hadoop使用。
- MapReduce - Map reduce是多步处理，将大数据分块，然后对每块执行函数生成最终结果。
- Spark -Spark是在Hadoop等分布式计算集群上执行通用数据分析的框架。Spark提供内存内计算，并加大提高了MapReduce上数据处理速度。
- Drill -Drill是用于大数据探索的查询引擎。Drill能对文件中的自描述数据，例如JSON、Parquet、文本，以及MapR-DB和HBase表，执行动态查询，无需请求Hive元数据存储中的元数据定义。
- Pig- Pig是一个分析数据的平台。Pig由称之为“PigLatin”的数据流脚本语言及将这些脚本转化成一些列MapReduce程序的基础设施组成。
- Mahout -Mahout是一套可扩展机器学习库。它包含一套核心算法，支持数据聚类、分类或协同过滤（通常指推荐系统）。
- Oozie -OOzie是用于创建复杂Hadoop工作流的可伸缩、可扩展的调度程序系统。Oozie可用于管理工作流内多种类型的作业，包括MapReduce、Pig、Hive、Sqoop、distcp以及任意脚本和Java程序。
- Hive-Hive是构建于Hadoop之上的数据仓库基础架构，使用MapReduce提供SQL相似语法进行查询。HiveQL语言提供与SQL机构类似的一系列操作，用于转化成MapReduce程序来产生所期望的查询结果。
- HBase - HBase是Hadoop NoSQL数据库，对大量数据提供随机、实时读写访问。
- Elasticsearch -Elasticsearch是构建在Lucene之上的可伸缩搜索服务器，提供实时或近实时搜索。
- Solr- Solr是开源搜索平台，是Apache Lucene项目的一部分。

#### 使用结果

各种工具被开发用来可视化、再挖掘或使用Hadoop分布式处理的结果。
- 数据仓库 -数据仓库适用于数据的集中式仓库。它存储的数据通常来自多个数据源，例如市场、财务和人力资源等内部操作系统数据，或web网站或外部数据源的数据。
- Kibana -Kibana是用于搜索和数据分析的基于浏览器的仪表盘。Kibana由HTML和JavaScript构建，易于仅在一个web服务器上搭建和使用。
- Banana - Banana基于Kibana，用于为存储在Solr内的可视化数据创建仪表板。
- SiLK -SiLK是基于Lucene的Solr搜索平台的接口。SiLK提供用于执行搜索并对仪表盘和报告内数据进行可视化。
- Web层 - Web网站经常向客户直接传递大数据处理结果，例如基于客户之前听过的歌曲推荐新歌。

### 数据仓库优化
![[MapR培训笔记]Hadoop基础](/images/2015/11/0026uWfMty71tPdRTns12.jpg)