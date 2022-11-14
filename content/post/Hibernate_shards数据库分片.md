---
title: 'Hibernate shards数据库分片'
date: 2013-07-19 07:01:23
categories: 
- Service+JavaEE
tags: 
- hibernate
- shards
- 数据库
- 分片
- 水平分区
---
## 简介

Hibernate Shards是Hibernate的一个子项目，由Google工程师Max Ross创建并捐献给Hibernate社区。
http://www.hibernate.org/subprojects/shards.html
https://github.com/hibernate/hibernate-shards

Hibernate Shards是对Hibernate Core提供水平分区支持的一个框架。
- 标准Hibernate编程模型
- 灵活的分片策略
- 支持虚拟分片
- 免费/开源


## 实现Hibernate Shards

Hibernate Shards几乎可以与现有Hibernate项目无缝结合使用。
Hibernate Shards的首要目标是让程序员使用标准Hibernate Core API查询和处理已分片的数据库,因此Hibernate Shards主要由大家已经熟知的Hibernate Core接口的实现（分片感知）组成，大多数Hibernate应用程序使用Hibernate Core提供的接口，因此无需对已有代码做过多重构。

|Hibernate Core接口|Hibernate Shards实现
|-----
|org.hibernate.Session|org.hibernate.shards.session.ShardedSession
|org.hibernate.SessionFactory|org.hibernate.shards.ShardedSessionFactory
|org.hibernate.Criteria|org.hibernate.shards.criteria.ShardedCriteria
|org.hibernate.Query|org.hibernate.shards.query.ShardedQuery

唯一问题是 Hibernate Shards 需要一些特定信息和行为。比如，需要一个分片访问策略、一个分片选择策略和一个分片解析策略。这些是您必须实现的接口，虽然部分情况下，您可以使用默认策略。我们将在后面的部分逐个了解各个接口。
首先让我们看一下《HibernateShard 参考指南》中所用的数据库模式、对象模型及映射。

### 气象报告数据库模式

```
CREATE TABLE WEATHER_REPORT (
    REPORT_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CONTINENT ENUM('AFRICA', 'ANTARCTICA', 'ASIA', 'AUSTRALIA', 'EUROPE', 'NORTH AMERICA', 'SOUTH AMERICA'),
    LATITUDE FLOAT,
    LONGITUDE FLOAT,
    TEMPERATURE INT,
    REPORT_TIME TIMESTAMP
);
```

### 气象报告对象模型

```
@Entity
@Table(name="WEATHER_REPORT")
public class WeatherReport {

  @Id @GeneratedValue(generator="WeatherReportIdGenerator")
  @GenericGenerator(name="WeatherReportIdGenerator", strategy="org.hibernate.shards.id.ShardedUUIDGenerator")
  @Column(name="REPORT_ID")
  private Integer reportId;

  @Column(name="CONTINENT")
  private String continent;

  @Column(name="LATITUDE")
  private BigDecimal latitude;

  @Column(name="LONGITUDE")
  private BigDecimal longitude;

  @Column(name="TEMPERATURE")
  private int temperature;

  @Column(name="REPORT_TIME")
  private Date reportTime;

  ... // getters and setters
}
```

Hibernate分片支持任何ID生成策略，唯一的要求是对象ID必须在所有分片中是唯一的。下面是满足要求的一些简单ID生成策略：
- Native ID生成 - 使用Hibernate的native ID生成策略，且配置数据库以便ID不冲突。例如，如果使用自增ID生成且分片有5个数据库分发数据，期望不会超过1百万记录，数据库#0返回的ID从0起始，数据库#1然会的ID从200000起始...只要对数据的假设正确，主键就不会冲突。
- 应用级UUID生成 - 通过定义无需担心ID冲突，但是很可能需要为对象解决难处理的主键。
   Hibernate Shards提供了一个简单的、分片感知的UUID生成器实现 - ShardedUUIDGenerator。
- 分布式hilo生成 - 该思路是仅在一个分片上使用hilo表，其确保高/低位机制所生成的ID在所有分片内唯一。这种方式有两个缺陷：访问hilo表可能成为ID生成的并经；在单个数据库上存储hilo表会造成系统的单点失效。
   Hibernate Shards提供了一个分布式hilo生成机制实现 - ShardedTableHiLoGenerator。 该实现基于org.hibernate.id.TableHiLoGenerator。
   ID生成与分片解析紧密相关。分片解析是使用一个对象ID找到对象所在的分片。有两种方式完成这一目的：
- 使用ShardResolutionStrategy
- 在ID生成时将分片ID放入对象ID，并在分片解析时获得分片ID。其优势在于Hibernate Shards无需查找数据库表就可以更快速地从对象ID解析出分片ID。Hibernate Shards无需任何对分片ID编码/解码的特殊机制，只需要使用实现ShardEncodingIdentifierGenerator接口的ID生成器。Hibernate Shards所含有的两个ID生成器中，ShardedUUIDGenerator实现了该接口。

### 配置及加载

```
<!-- Contents of shard0.hibernate.cfg.xml -->
<hibernate-configuration>
  <session-factory name="HibernateSessionFactory0"> <!-- note the different name -->
    <property name="dialect">org.hibernate.dialect.MySQLInnoDBDialect</property>
    <property name="connection.driver_class">com.mysql.jdbc.Driver</property>
    <property name="connection.url">jdbc:mysql://dbhost0:3306/mydb</property>
    <property name="connection.username">my_user</property>
    <property name="connection.password">my_password</property>
    <property name="hibernate.connection.shard_id">0</property> <!-- new -->
    <property name="hibernate.shard.enable_cross_shard_relationship_checks">true</property> <!-- new -->
  </session-factory>
</hibernate-configuration>
```

```
<!-- Contents of shard1.hibernate.cfg.xml -->
<hibernate-configuration>
  <session-factory name="HibernateSessionFactory1"> <!-- note the different name -->
    <property name="dialect">org.hibernate.dialect.MySQLInnoDBDialect</property>
    <property name="connection.driver_class">com.mysql.jdbc.Driver</property>
    <property name="connection.url">jdbc:mysql://dbhost1:3306/mydb</property>
    <property name="connection.username">my_user</property>
    <property name="connection.password">my_password</property>
    <property name="hibernate.connection.shard_id">1</property> <!-- new -->
    <property name="hibernate.shard.enable_cross_shard_relationship_checks">true</property> <!-- new -->
  </session-factory>
</hibernate-configuration>
```

```
public SessionFactory createSessionFactory() {
  AnnotationConfiguration prototypeConfig = new AnnotationConfiguration().configure("shard0.hibernate.cfg.xml");
  prototypeConfig.addAnnotatedClass(WeatherReport.class);
  List shardConfigs = new ArrayList();
  shardConfigs.add(buildShardConfig("shard0.hibernate.cfg.xml"));
  shardConfigs.add(buildShardConfig("shard1.hibernate.cfg.xml"));
  shardConfigs.add(buildShardConfig("shard2.hibernate.cfg.xml"));
  ShardStrategyFactory shardStrategyFactory = buildShardStrategyFactory();
  ShardedConfiguration shardedConfig = new ShardedConfiguration(
    prototypeConfig,
    shardConfigs,
    shardStrategyFactory);
  return shardedConfig.buildShardedSessionFactory();
}

ShardStrategyFactory buildShardStrategyFactory() {
  ShardStrategyFactory shardStrategyFactory = new ShardStrategyFactory() {
    public ShardStrategy newShardStrategy(List shardIds) {
      RoundRobinShardLoadBalancer loadBalancer = new RoundRobinShardLoadBalancer(shardIds);
      ShardSelectionStrategy pss = new RoundRobinShardSelectionStrategy(loadBalancer);
      ShardResolutionStrategy prs = new AllShardsShardResolutionStrategy(shardIds);
      ShardAccessStrategy pas = new SequentialShardAccessStrategy();
      return new ShardStrategyImpl(pss, prs, pas);
    }
  };
  return shardStrategyFactory;
}

ShardConfiguration buildShardConfig(String configFile) {
  Configuration config = new Configuration().configure(configFile);
  return new ConfigurationToShardConfigurationAdapter(config);
}
```

在上述示例中，一共分配了四个配置。第一个分配的配置是AnnotationConfiguration对象，用于构造与分片无关的信息；之后分配的三个配置是ShardConfiguration对象将仅用于构造分片特定的数据库url、数据库用户和密码、数据库标识符和缓存region前缀。
因此shard1.hibernate.cfg.xml与shard1.hibernate.cfg.xml中与分片无关的信息将被忽略。

### 分片访问策略

Hibernate Shards使用ShardAccessStrategy决定如何对多个分片实行数据库操作。Hibernate Shards 无需确定查询什么（这是 Hibernate Core 和基础数据库需要做的），但是它确实意识到，在获得答案之前可能需要对多个分片进行查询。因此，Hibernate Shards提供了两种极具创意的逻辑实现方法：一种方法是根据序列机制（一次一个）对切分进行查询，直到获得答案为止；另一种方法是并行访问策略，这种方法使用一个线程模型一次对所有分片进行查询。

#### 顺序策略

SequentialShardAccessStrategy会让查询在分片上顺序执行。取决于所执行的查询类型，有可能因为它每次都按相同的顺序在分片执行查询避免使用这种实现。
如果执行很多限制结果集行数、非排序的查询，就会导致分片上糟糕的使用率(排在前面的分片很忙，排在后面的分片很闲。在这种情况下，可以考虑使用LoadBalancedSequentialShardAccessStrategy，它会在每次调用后收到分片的轮询视图，因此可以平衡地分发查询负载。

#### 并行策略

ParallelShardAccessStrategy会让查询在分片上并行执行。当使用这种实现，需要提供适合应用程序性能和吞吐量的线程池执行器java.util.concurrent.ThreadPoolExecutor。 示例如下:
```
ThreadFactory factory = new ThreadFactory() {
  public Thread newThread(Runnable r) {
    Thread t = Executors.defaultThreadFactory().newThread(r);
    t.setDaemon(true);
    return t;
  }
};

ThreadPoolExecutor exec =
  new ThreadPoolExecutor(
    10,
    50,
    60,
    TimeUnit.SECONDS,
    new SynchronousQueue(),
    factory);

return new ParallelShardAccessStrategy(exec);
```

### 分片选择策略

Hibernate Shards使用ShardSelectionStrategy判断新增对象应该存储到哪个分片。该接口的实现完全取决于开发者，Hibernate Shards默认提供了一个轮询选择策略RoundRobinShardSelectionStrategy,但一般不这样使用。
通常采用基于属性的分片。一般是用户根据表自己实现一个基于对象属性分片的策略类ShardSelectionStrategy ，例如，以下WeatherReport基于“大陆”属性选择分区：
```
public class WeatherReportShardSelectionStrategy implements ShardSelectionStrategy {
  public ShardId selectShardIdForNewObject(Object obj) {
    if(obj instanceof WeatherReport) {
      return ((WeatherReport)obj).getContinent().getShardId();
    }
    throw new IllegalArgumentException();
  }
}
```

使用Hibernate级联功能存储多级对象时，仅在存储顶级对象时考虑ShardSelectionStrategy。所有子对象自动存储在父对象所在的分片。
如果阻止开发人员在对象层级超过一级之上创建新对象，ShardSelectionStrategy会更容易实现。实现方式为让ShardSelectionStrategy实现感知模型中的顶级对象，如果遇到一个对象不在顶级对象集合就抛出异常。
如果不希望采用这个限制，需要记得对于基于对象属性分片选择，每个对象都必须存在用于选择分片的属性并传递给session.save()。

### 分片解析策略

Hibernate Shards通过对象ID使用ShardResolutionStrategy判断对象所在的分片集合。对于气象报告应用程序，每个大陆关联一些ID。每当给WeatherReport分配ID，就会选取落入WeatherReport所属大陆的合法范围内的ID。ShardResolutionStrategy可以通过ID和上述信息识别WeatherReport所在的分片。
```
public class WeatherReportShardResolutionStrategy extends AllShardsShardResolutionStrategy {
  public WeatherReportShardResolutionStrategy(List shardIds) {
    super(shardIds);
  }

  public List selectShardIdsFromShardResolutionStrategyData(
        ShardResolutionStrategyData srsd) {
    if(srsd.getEntityName().equals(WeatherReport.class.getName())) {
      return Continent.getContinentByReportId(srsd.getId()).getShardId();
    }
    return super.selectShardIdsFromShardResolutionStrategyData(srsd);
  }
}
```
值得指出的是当我们还没有实现对实体名/ID与分片进行映射的缓存，ShardResolutionStrategy是放入这一缓存的绝佳之所。
分区解析与ID生成紧密绑定，如果选择的ID生成器(实现ShardEncodingIdentifierGenerator接口的生成器，例如Hibernate Shards提供的ShardedUUIDGenerator)生成的对象ID包含分片ID，则ShardResolutionStrategy将不被调用。
Hibernate Shards提供的默认AllShardsShardResolutionStrategy，会返回所有分区ID。


## 重分片和虚拟分片

当应用程序的数据集增长超出原先分配给应用程序的数据库能力，需要增加更多的数据库，通常（为了实现合适的负载均衡或满足应用程序不变性）也需要在分片上重新分布数据，这就是重分片。
重分片是个复杂的问题，为了减轻重分片带来的痛苦，Hibernate Shards对虚拟分片提供支持。
通常，每个对象存储在一个分片上，重分片包括两个任务：将对象移到另一个分片，并改变对象与分片的映射。对象与分片的映射可能是对象ID包含分片ID，或对象所使用的分片解析策略的内部逻辑。
前者，重分片需要改变所有对象ID和外键。后者重分片需要需要改变给定分片解析策略的运行时配置来改变分片解析策略的机制。
不幸的是，一旦我们考虑到Hibernate Shards不支持跨分片的关系，改变对象与分片的映射的问题会更加严重。这一限制让我们无法将对象图的子集从一个分片移到另一个分片。
改变对象与分片的映射可以通过增加一层重定向来简化 - 每个对象存在于一个虚拟分片，每个虚拟分片映射到一个物理分片。开发人员在设计时必须决定应用程序所需的最大物理分片数。这个物理分片数将被用作虚拟分片的个数，然后虚拟分片映射到应用程序当前所需的物理分片。因为Hibernate Shards的分片选择策略、分片解析策略和ShardEncodingIdentifierGenerator都做用于虚拟分片，对象将在虚拟分片上正确分布。当重分片时，可以通过修改虚拟分片与物理分片的关系就很容易地改变对象与分片的映射。
如果担心无法正确估计应用程序将来所需的最大物理分片数，可以尽量往高估。虚拟分片很廉价，这种方式比必须增加虚拟分片性价比高的多。
为了使能虚拟分片，需要在创建ShardedConfiguration传入一个虚拟分片ID与物理分片ID的映射。下例是将4个虚拟分片映射到2个物理分片。
```
Map virtualShardMap = new HashMap();
virtualShardMap.put(0, 0);
virtualShardMap.put(1, 0);
virtualShardMap.put(2, 1);
virtualShardMap.put(3, 1);

ShardedConfiguration shardedConfig =
  new ShardedConfiguration(
    prototypeConfiguration,
    configurations,
    strategyFactory,
    virtualShardMap);

return shardedConfig.buildShardedSessionFactory();
```

此后想要改变虚拟分片与物理分片的映射，仅需要改变传给此构造器的virtualShardToShardMap。
我们提到在重分片的第二个任务是将数据从一个物理分片移到另一个。由于这是应用程序特定的、且随着应用程序热重分片、部署框架等潜在需求而复杂多变的，HibernateShards对比不提供支持。


## 限制

- 通过JPA配置SessionFactory目前无法使用Hibernate Shards。
- 不支持查询中的distinct、order-by和聚集函数
- 对Hibernate API的不完全实现，一部分较少使用Hibernate API没有实现
- 不支持跨分区的关系操作。无法创建存在于不同分片上对象A与B的绑定。
- 不支持在非受管环境（例如Servlet容器，应用程序需要负责获得数据库的连接）下的分布事物。
- 使用有状态拦截器org.hibernate.Interceptor需要更多处理。
- 不支持ID为基本类型的实体对象。
- 将复制数据（相同的数据存在于所有分片）与分片数据绑定可能会有问题，无法确保复制数据的分片与分片数据所在分片是同一分片。