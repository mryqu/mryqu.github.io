---
title: 'GemFire查询'
date: 2013-05-15 07:30:01
categories: 
- Cache
tags: 
- gemfire
- 查询
- oql
- 对象查询语言
---
GemFire在region中存储的数据为键值对，其中值可以为任何对象，例如简单的字节数组或者复杂的嵌套对象。GemFire提供了一种查询机制可以获得满足特定条件的键、值或条目集合。GemFire支持的查询语义和语法是OQL（对象查询语言）的一个子集。OQL是由对象数据管理组制定的ODMG3.0对象模型的重要组件之一，与SQL很相似，可以查询复杂对象、对象属性和方法，支持完整的ASCII和Unicode字符集。
为了提高查询执行效率，GemFire像数据库一样支持索引。在查询执行时，查询引擎使用数据存储上的索引可以减少查询处理时间。查询是GemFire很强大的功能，但它也需要大量性能优化和容量规划也确保不拖垮系统。

## Region存储示例

本文的查询示例基于类Porfolio和Positon的对象。

### Portfolio.java

```
package query;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.gemstone.gemfire.DataSerializable;
import com.gemstone.gemfire.DataSerializer;


public class Portfolio implements Serializable, DataSerializable {

  private int ID;
  public String pkid;
  public Position position1;
  public Position position2;
  public String description;
  public HashMap positions = new HashMap();
  String type;
  public String status;
  public String [] names={"aaa","bbb","ccc","ddd"};

  public int getID() {
    return ID;
  }

  public String getPk() {
    return pkid;
  }

  public HashMap getPositions() {
    return positions;
  }

  public Position getP1() {
    return position1;
  }

  public Position getP2() {
    return position2;
  }

  public boolean isActive() {
    return status.equals("active");
  }

  public static String secIds[] = { "SUN", "IBM", "YHOO", "GOOG", "MSFT",
    "AOL", "APPL", "ORCL", "SAP", "DELL", "RHAT", "NOVL", "HP"};

 
  public Portfolio() {
  }

  public Portfolio(int i) {
    ID = i;
    if(i % 2 == 0) {
      description = null;
    } else {
      description = "XXXX";
    }
    pkid = "" + i;
    status = i % 2 == 0 ? "active" : "inactive";
    type = "type" + (i % 3);
    position1 = new Position(secIds[Position.cnt % secIds.length],
    Position.cnt * 1000);
    if (i % 2 != 0) {
      position2 = new Position(secIds[Position.cnt % secIds.length],
      Position.cnt * 1000);
    } else {
      position2 = null;
    }
    positions.put(secIds[Position.cnt % secIds.length], new Position(
    secIds[Position.cnt % secIds.length], Position.cnt * 1000));
    positions.put(secIds[Position.cnt % secIds.length], new Position(
    secIds[Position.cnt % secIds.length], Position.cnt * 1000));
  }

  public boolean equals(Object o) {
    if (!(o instanceof Portfolio)) {
      return false;
    }
    Portfolio p2 = (Portfolio)o;
    return this.ID == p2.ID;
  }

  public int hashCode() {
    return this.ID;
  }


  public String toString() {
    String out = "Portfolio [ID=" + ID + " status=" + status + " type=" + type
      + " pkid=" + pkid + "\n ";
    Iterator iter = positions.entrySet().iterator();
    while (iter.hasNext()) {
      Map.Entry entry = (Map.Entry) iter.next();
      out += entry.getKey() + ":" + entry.getValue() + ", ";
    }
    out += "\n P1:" + position1 + ", P2:" + position2;
    return out + "\n]";
  }

  public String getType() {
    return this.type;
  }

  public void fromData(DataInput in) throws IOException, ClassNotFoundException {
    this.ID = in.readInt();
    this.pkid = DataSerializer.readString(in);
    this.position1 = (Position)DataSerializer.readObject(in);
    this.position2 = (Position)DataSerializer.readObject(in);
    this.positions = (HashMap)DataSerializer.readObject(in);
    this.type = DataSerializer.readString(in);
    this.status = DataSerializer.readString(in);
    this.names = DataSerializer.readStringArray(in);
    this.description = DataSerializer.readString(in);
  }

  public void toData(DataOutput out) throws IOException {
    out.writeInt(this.ID);
    DataSerializer.writeString(this.pkid, out);
    DataSerializer.writeObject(this.position1, out);
    DataSerializer.writeObject(this.position2, out);
    DataSerializer.writeObject(this.positions, out);
    DataSerializer.writeString(this.type, out);
    DataSerializer.writeString(this.status, out);
    DataSerializer.writeStringArray(this.names, out);
    DataSerializer.writeString(this.description, out);
  }
}
```

### Position.java

```
package query;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;


import com.gemstone.gemfire.DataSerializable;
import com.gemstone.gemfire.DataSerializer;


public class Position implements Serializable, DataSerializable {


  private long avg20DaysVol=0;
  private String bondRating;
  private double convRatio;
  private String country;
  private double delta;
  private long industry;
  private long issuer;
  private double mktValue;
  private double qty;
  public String secId;
  private String secLinks;
  public String secType;
  private double sharesOutstanding;
  public String underlyer;
  private long volatility;
  private int pid;
  public static int cnt = 0;


 
  public Position() {}


  public Position(String id, double out) {
    secId = id;
    sharesOutstanding = out;
    secType = "a";
    pid = cnt++;
    this.mktValue = (double)cnt;
  }


  public boolean equals(Object o) {
    if (!(o instanceof Position)) return false;
    return this.secId.equals(((Position)o).secId);
  }


  public int hashCode() {
    return this.secId.hashCode();
  }


  public static void resetCounter() {
    cnt = 0;
  }


  public double getMktValue() {
    return this.mktValue;
  }


  public String getSecId(){
    return secId;
  }


  public int getId(){
    return pid;
  }


  public double getSharesOutstanding(){
    return sharesOutstanding;
  }


  public String toString(){
    return "Position [secId=" + this.secId + " out=" + this.sharesOutstanding
    + " type=" + this.secType + " id=" + this.pid + " mktValue="
    + this.mktValue + "]";
  }


  public Set getSet(int size){
    Set set = new HashSet();
    for(int i=0;i
      set.add(""+i);
    }
    return set;
  }


  public Set getCol(){
    Set set = new HashSet();
    for(int i=0;i<2;i++){
      set.add(""+i);
    }
    return set;
  }


  public void fromData(DataInput in) throws IOException, ClassNotFoundException {
    this.avg20DaysVol = in.readLong();
    this.bondRating = DataSerializer.readString(in);
    this.convRatio = in.readDouble();
    this.country = DataSerializer.readString(in);
    this.delta = in.readDouble();
    this.industry = in.readLong();
    this.issuer = in.readLong();
    this.mktValue = in.readDouble();
    this.qty = in.readDouble();
    this.secId = DataSerializer.readString(in);
    this.secLinks = DataSerializer.readString(in);
    this.sharesOutstanding = in.readDouble();
    this.underlyer = DataSerializer.readString(in);
    this.volatility = in.readLong();
    this.pid = in.readInt();
  }


  public void toData(DataOutput out) throws IOException {
    out.writeLong(this.avg20DaysVol);
    DataSerializer.writeString(this.bondRating, out);
    out.writeDouble(this.convRatio);
    DataSerializer.writeString(this.country, out);
    out.writeDouble(this.delta);
    out.writeLong(this.industry);
    out.writeLong(this.issuer);
    out.writeDouble(this.mktValue);
    out.writeDouble(this.qty);
    DataSerializer.writeString(this.secId, out);
    DataSerializer.writeString(this.secLinks, out);
    out.writeDouble(this.sharesOutstanding);
    DataSerializer.writeString(this.underlyer, out);
    out.writeLong(this.volatility);
    out.writeInt(this.pid);
  }

}
```

### OQL查询示例

**`SELECT DISTINCT * FROM /exampleRegion WHERE status ='active'`**
此查询从/exampleRegion获取满足条件"status = active"的非重复（distinct）对象。

## OQL与SQL的对比

OQL和SQL的查询语法很相似。例如，数据库portfolio表含有id和status列，同样一个Portfolio对象含有id和status属性。
一个简单的SQL SELECT语法如下：
```
SELECT [projection-list] FROM [From clause] WHERE [Where clause]
-- SELECT id FROM portfolio WHERE status = 'active'
```

OQL语法看起来很类似：
```
SELECT [projection-list] FROM [From clause] WHERE [Where clause] 
-- SELECT ID FROM /exampleRegion WHERE status = 'active'
-- exampleRegion是GemFire缓存中的region，Portfolio对象是作为其值存储。
```

此外相对于SQL可用于查询两维数据（列和行），OQL允许查询嵌套对象。对象数据通常是嵌套的，需要从外部数据层下钻访问内嵌数据。
假如Portfolio含有多个Positions属性。数据库模型中，它被映射为扁平化结构，以两个不同表protfolio和position来表现之间的关系。在对象模型中，它被表达为Portfolio对象包含一些列Position对象。
为了获得有效portfolios中所有position的market值：

```
-- SQL将查询两个表：
SELECT pos.mktValue FROM portfolio p, position pos WHERE p.status = 'active' AND p.id = pos.id 
-- OQL会通过从上层遍历到下层来查询一个region：
SELECT pos.mktValue FROM /exampleRegion portfolio, positions.values pos WHERE portfolio.status = 'active'
```
OQL仅涉及SELECT语句，SQL包含DDL和DML语句。

## 编写并执行查询

同数据库查询一样，OQL查询非常灵活并依赖数据结构。它需要认真学习数据、查询的不同表达方式以及索引的使用。
- 决定需要查询的信息及其来源。可以从客户端或本地缓存查询服务器数据。
- 编写查询语句。对于一个SELECT语句：
  - 编写FROM子句，包含对象类型和迭代器变量。
  - 编写WHERE子句过滤数据。
  - 编写投影列表。
  - 决定是否使用索引。
- 编写执行查询的代码并处理查询结构。
- 根据测试性能和优化结构添加索引。

### 查询语句

一个查询语句是能传送给查询引擎并对数据集执行的完整OQL语句。为了创建查询语句，需要组合支持的关键词、表达式和操作符，以获得所需信息。
查询语句表达式遵从查询语言语法的各种规则，它可以包含：
- 路径表达式
- 属性名
- 方法调用
- 操作符
- 字面值（Literals）
- 查询参数
- IS_DEFINED、IS_UNDEFINED、ELEMENT、NVL和TO_DATE函数
- SELECT语句

注意的是对于查询语句上面都不是必须的。例如，SELECT语句通常被认为是查询的起始部分，但其实不是必要的。下面的表达式就是一个有效查询，如果/exampleRegion存储了超过100个值就会返回true。
`/exampleRegion.size > 100`

### 别名和同义词

在查询语句中，路径表达式(regions及其对象)可以使用别名定义，别名可以在查询的其他部分使用或引用。下面的查询语句中p用作/exampleRegion的别名。
**`SELECT DISTINCT * FROM /exampleRegion p WHERE p.status ='active'`**

### 查询代码示例

```
-- 定义查询语句。 
String queryString = "SELECT DISTINCT * FROM /exampleRegion"; 

-- 通过Cache获得QueryService。 
QueryService queryService = cache.getQueryService(); 

-- 创建Query对象。 
Query query = queryService.newQuery(queryString); 

-- 在本地执行查询，返回结果集。
SelectResults results = (SelectResults)query.execute(); 

-- 获得ResultSet的大小。 
int size = results.size(); 

-- 通过ResultSet迭代遍历。
Portfolio p = (Portfolio)results.iterator().next();
```

### 查询参数执行

这与SQL预处理语句类似，查询参数可以在查询执行时设置。它允许用户创建一次查询，通过运行时传递查询条件执行多次。
注意： 客户端到服务器端的查询不支持。
查询参数由美元符号$及参数在参数数组中的下标标识。下标计数从1开始，$1指第一个绑定属性，$2指第二个绑定属性，以此类推。
对象数组的第0个元素用于第一个查询参数，以此类推。如果参数个数或参数类型与查询语句不一致，则会在执行时抛出异常。如果参数个数不一致，则会抛出QueryParameterCountInvalidException异常。如果参数类型不一致，则会抛出TypeMismatchException异常。
示例：
```
-- 定义查询语句。 
String queryString = "SELECT DISTINCT * FROM /exampleRegion p WHERE p.status = $1"; 

-- 通过Cache获得QueryService 
QueryService queryService = cache.getQueryService(); 

-- 创建Query对象。  
Query query = queryService.newQuery(queryString); 

-- 设置查询参数。
Object[] params = new Object[1]; 
params[0] = "active"; 

-- 在本地执行查询，返回结果集。
SelectResults results = (SelectResults)query.execute(params); 

-- 获得ResultSet的大小。 
int size = results.size();
```

此外查询引擎支持region路径作为查询参数。为了在FROM子句中使用参数，参数引用必须为一个集合。
例如:**`SELECT DISTINCT * FROM $1 p WHERE p.status = $1`**

### Select 语句结果(Result Set)

SELECT语句返回结果可能是UNDEFINED或者实现SelectResults接口的集合。
返回的SelectResults可以是:
- 两种情况下返回的对象集合:
  - 当投影列表仅有一个表达式且该表达式没有显式使用字段名：表达式语法
  - 当投影列表为*且FROM子句仅指定一个集合
- 包办对象的结构体集合

当结构体被返回时，结构体中每个字段的名称通过下列顺序决定：
- 如果字段通过字段名：表达式方式被显式使用，字段名将被使用。
- 如果SELECT投影类表为*且FROM子句中使用了显示迭代器表达式，迭代器变量名用作字段名称。
- 如果字段与region或属性路径相关联，路径上最后一个属性名被使用。
- 如果无法通过上述规则决定名称，查询处理器会生成任意唯一名称。

下面为SELECT投影列表和FROM子句表达式使用示例：
```
SELECT DISTINCT * FROM/exampleRegion -- 返回portfolios集合(Region将Portfolio作为值)。
SELECT DISTINCT secId FROM /exampleRegion, positions.values TYPEPosition WHERE status = 'active' --返回有效potifolios的positions属性对象的secld属性的集合。
SELECT DISTINCT "type", positions FROM /exampleRegion WHEREstatus = 'active' --返回有效portfolios的结构体集合。结构体的第二个属性为Map ( jav.utils.Map )对象，将positionsmap作为值。
SELECT DISTINCT * FROM /exampleRegion, positions.values TYPEPosition WHERE status = 'active' --返回有效portfolios的结构体集合
SELECT DISTINCT * FROM /exampleRegion portfolio, positionspositions TYPE Position WHERE portfolio.status ='active' --返回有效portfolios的结构体集合。
```

#### 限制结果数量

LIMIT关键字可选择性放在查询语句后面限制返回的行数。例如，下面的查询最到返回10行：**`SELECT * FROM /exampleRegions LIMIT 10`**
如果使用limit关键字，不要对查询结果集合做任何汇总性质的操作，因为这样并无意义。例如对使用了limit子句的查询结果使用add或addAll方法会抛出异常。

## 可查询数据

对于查询的region，所有对象必须同一类型。对非同一类的数据进行查询和索引会导致异常，但是可以使用不同子类型。为了确保数据同查询一致，可以使用region属性**key-constraint**和**value-constraint**限制region中的键和值类型。对于查询的对象，需要实现equals和hashCode方法。如果这些方法不存在，可能会放回不一致的查询结构。

## 数据可见性

查询引擎根据查询范围命名空间来解析名称和路径表达式。查询初始命名空间由下面几项组成：
- 查询上下文的region。region名称由全路径指定，全路径由斜杠/起始并在region名之间用斜杠/分隔。
- Region查询属性。可以通过region路径访问对象的对象的公开字段和方法。
- 顶级region数据。可以通过region路径访问条目键或值数据。
  - /exampleRegion.keySet 返回region中条目的键集合。
  - /exampleRegion.entrySet 返回Region.Entry对象集合。
  - /exampleRegion.values 返回region中条目的值集合。
  - /exampleRegion 返回region中条目的值集合。
  
### 下钻

新的命名空间加入基于SELECT语句FROM子句的查询范围。在下面的查询示例中，FROM表达式鉴定为/exampleRegion内条目值集合。这些值的属性加入初始查询范围，status从新的查询范围内被解析出来。
**`SELECT DISTINCT * FROM /exampleRegion p WHERE p.status ='active'`**
每个FROM子句表达式必须解析为对象集合，且集合可用于查询表达式进行迭代。在上例中，条目值集合被WHERE子句迭代，将status字段与字符串‘active’比较，并将匹配的值对象放入结果集合。
在下面的查询中，FROM子句的第一个表达式指定的集合用于SELECT语句的其他部分（包括FROM子句第二个表达式）。
**`SELECT DISTINCT * FROM/exampleRegion, positions.values positions WHERE positions.qty >1000.00`**

### 属性可见性

可以访问当前查询范围内任何对象或对象属性。在查询过程中，对象属性可被映射为对象的公开字段和方法。在FROM规范中，查询范围内的任何对象都是有效的，因此在查询一开始所有本地缓存region及其属性都在查询范围内。
对于存在公开getter方法“getSecId()”的属性**Position.secId** 查询语句可以为如下方式：
```
SELECT DISTINCT * FROM /exampleRegion p where p.position1.secId= '1'
SELECT DISTINCT * FROM /exampleRegion p where p.position1.SecId= '1'
SELECT DISTINCT * FROM /exampleRegion p wherep.position1.getSecId() = '1'
```
查询引擎首先尝试使用公开字段值解析属性，如果公开字段不存在则尝试使用字段的getter方法。

### 名称范围

当两个不同名称范围（包）下的同名类用于OQL查询时需要指定对象的类名。**IMPORT** 语句用于建立查询中的类名。
```
IMPORT package.Position;****SELECT DISTINCT * FROM /exampleRegion, positions.valuespositions TYPE Position WHERE positions.mktValue >=25.00
```

### 指定对象类型

指定对象类型有助于查询引擎以更优的速度处理查询。除了在配置中指定对象类型 (使用key-constraint和value-constraint)，也可以在查询语句中显式指定对象类型。
```
SELECT DISTINCT * FROM /exampleRegion, positions.valuespositions TYPE Position WHERE positions.mktValue >=25.00
```

## 性能考虑

同在关系数据库上运行的查询处理器一样，查询的写法对执行性能有很大关系。此外，是否使用索引取决于每个查询是如何制定的。下面是在优化查询性能时需要考虑的一些事情：
- 索引不用于包含NOT的表达式。因此在查询的WHERE语句中qty >= 10可以对qty建立索引来提高性能，然而NOT(qty< 10)不会采用索引。
- 对于AND操作符，如果使用索引的条件能放在其他查询条件前，查询会更高效。

## 索引

GemFire查询引擎支持索引。使用索引，查询性能能显著提高。查询在没有索引帮助下需要迭代遍历集合中的每个对象。如果存在匹配部分或全部查询规范的索引，查询将仅迭代有索引的集合上，因此能检查查询处理时间。
当创建索引时，需要注意的是：
- 当被索引的数据改变时索引也需要更新，这导致维护代价。需要很多更新且不常使用的索引相比不用索引消耗更多系统资源。
- 索引消耗内存。
- 索引在溢出region仅有限支持。

### 索引创建

索引可以通过程序创建或者使用xml定义。

#### java

```
QueryService qs = cache.getQueryService();
qs.createIndex("myFuncIndex", IndexType.FUNCTIONAL, "status", "/exampleRegion");
qs.createIndex("myPrimIndex", IndexType.PRIMARY_KEY, "id", "/exampleRegion");
```

#### xml
```
<region name="portfolios">
 <region-attributes . . . >
 </region-attributes>
 <index name="myIndex">
 <functional from-clause="/exampleRegion" 
     expression="status"/>
 </index>
 <index name="myKeyIndex">
 <primary-key field="id"/>
 </index>
 <entry>
```

### 索引类型

#### 函数索引

排序索引允许属性与常量的比较。比较可以用任何关系操作符，且不限于属性和属性路径。比较可以是带有参数的复杂函数，只要属性、属性路径或函数是支持Comparable接口的对象。其次，索引表达式对复杂对象也是可用的。下面是有效可比较的对象示例：
java.util.Date objectjava.lang.Integer Floatjava.lang.String Stringjava.lang.Boolean Boolean

#### 主键

它让查询服务了解region中键和值的关系。
注：主键索引无法排序。没有排序，仅能使用相等测试。无法进行其他比较。为了获得主键上的排序索引，在用作主键的属性上创建函数索引。
注：查询服务不会自动获知region键和值的关系。因此，必须创建主键索引。
用于主键索引的FROM子句必须就是region路径。索引表达式是作用于条目值处理键的表达式。例如，region将Portfolios作为值，Portfolios的id字段作为键，索引的表达式为id。

### 索引维护(同步或异步的)

索引自动与引用的region数据保持一致。region属性IndexMaintenanceSynchronous指定当region数据改变时同步地更新索引还是通过后台线程异步地更新索引。异步索引维护对同一region主键批量执行多个更新。默认同步模式，它能对region数据提供最大的一致性。
AttributesFactory.setIndexMaintenanceSynchronous()
下面的声明式索引创建设置维护模式为异步的：
```
<region-attributes index-update-type="asynchronous"> 
</region-attributes>
```

### 索引内部结构

RangeIndex和CompactRangeIndex是用于维护（在可查询对象上创建的）索引的两种内部数据结构。

#### CompactRangeIndex

CompactRangeIndex 是具有简单数据结构、范围最小化用于索引维护的一种范围索引。此索引不支持投影属性存储。
当前CompactRangeIndex仅支持在region路径上创建的索引。当下列条件成立时被选为索引实现：
- 索引维护是同步模式。
- 索引表达式为路径表达式。
- FROM子句仅有一个迭代器。即对于每个region条目仅有一个值且索引直接用于region的值上(不支持键、条目)。

#### RangeIndex

当CompactRangeIndex无法使用时使用。下列为RangeIndex使用时的示例。
```
createIndex("statusIndex","status","/portfolios, positions");
createIndex("secIdIndex","b.secId","/portfolios pf, pf.positions.values b"); 
createIndex("intFunctionIndex","intFunction(pf.getID)","/portfolios pf, pf.positions b");
createIndex("kIndex","pf","/portfolios.keys pf");
```

### 索引示例

```
-- Primary key index. The field doesn't has to be present. 
createIndex("pkidIndex", IndexType.PRIMARY_KEY, "p.pkid1", "/root/exampleRegion p"); 
createIndex("Index4", IndexType.PRIMARY_KEY,"ID","/portfolios"); 

-- Simple index 
createIndex("pkidIndex", IndexType.FUNCTIONAL, "p.pkid", "/root/exampleRegion p"); 

-- On Set type 
createIndex("setIndex", IndexType.FUNCTIONAL, "s", "/root/exampleRegion p, p.sp s"); 

-- Positions is a map 
createIndex("secIdIndex", IndexType.FUNCTIONAL,"b.secId","/portfolios pf, pf.positions.values b"); 

-- Index expression as function.
createIndex("intFunctionIndex", IndexType.FUNCTIONAL,"intFunction(pf.getID)","/portfolios pf, pf.positions b");

-- On Keys 
createIndex("keyIndex", IndexType.FUNCTIONAL, "keys","/portfolios.keySet keys");  
createIndex("kIndex", IndexType.FUNCTIONAL, "pf","/portfolios.keys pf");
createIndex("keyIndex", IndexType.FUNCTIONAL, "ks.hashCode","/portfolios.keys ks"); 
createIndex("k1Index", IndexType.FUNCTIONAL, "key","/portfolios.entries"); 

-- On Entry 
createIndex("entryIndex", IndexType.FUNCTIONAL, "value.getID()","/portfolios.entrySet pf"); 

-- Misc. 
createIndex("cIndex", IndexType.FUNCTIONAL,"pf.getCW(pf.ID)","/portfolios pf");
createIndex("funcReturnSecIdIndex", IndexType.FUNCTIONAL,"pf.funcReturnSecId(element(select distinct pos from /portfolios pf, pf.positions.values as pos where pos.sharesOutstanding = 5000))","/portfolios pf, pf.positions b"); 
createIndex("NVLIndex1",IndexType.FUNCTIONAL, "nvl(pf.position2, pf.position1).secId", "/portfolios pf");
```

### 索引使用指南

使用索引优化查询需要仔细计划、测试和调优。定义不佳的索引不会提高查询性能，相反会降低查询性能。

#### 一般规则

- 如果查询的FROM子句与索引非常匹配，一般情况下索引会提高查询性能。
- 查询评估引擎没有复杂的基于成本的优化器，而是基于索引数量和须评估的操作数选择一个最佳索引或多个索引。

#### 对单个region查询使用索引
- 带有一个比较操作的查询可通过主键或功能键（取决于比较的属性是否为主键）提高性能。
  `SELECT DISTINCT * FROM/exampleRegion portfolio WHERE portfolio.pkid ='123'`
  如果pkid是/exampleRegionregion的键，在pkid上创建主键索引是最佳选择，因为主键索引不会增加维护负担。如果pkid不是键，在pkid上创建功能索引能够提高性能。
- 对于多个比较操作，可以在一个或多个属性上创建功能索引。尝试如下：
  - 在期望获得最小结果集的条件创建一个索引。检查使用索引后的性能。
  - 保留第一个索引，在第二个条件上增加索引。第二个索引可能会降低性能。如果性能降低的话，删除第二个索引、仅保留第一个索引。查询中比较的次序会影响性能。通常在OQL查询中，应该将获得最少结构的比较放在前面。
    对于下面的查询，应该在name、age或两者上尝试功能索引：
    ```
    SELECT DISTINCT * FROM /exampleRegion portfolio WHEREportfolio.status = 'active' and portfolio.ID > 45
    ```
    对于嵌套查询，深入到最低级索引以及查询，会获得较好性能。下面的查询深入了一级：
    ```
    SELECT DISTINCT * FROM/exampleRegion portfolio, portfolio.positions.values positionswhere positions.secId = 'AOL' and positions.MktValue >1
    ```

#### 在同等联接（Equi-join）查询中使用索引

同等联接查询是在WHERE子句中以同等条件联接两个region进行查询。
- 在每个同等联接条件的每一侧创建功能索引。查询引擎会迭代左侧键和右侧索引进行相等匹配来快速评估查询的同等联接条件。
  注意：同等联接查询需要功能索引。主键索引不会用于同等联接查询。
  对下面的查询：
  ```
  SELECT DISTINCT inv.name, ord.orderID, ord.status 
  FROM /investors inv, /orders ord 
  WHERE inv.investorID = ord.investorID 
  ```
  创建两个索引：
  FROM子句索引的表达式/investors invinv.investorID/orders ordord.investorID
- 如果在查询中有单region查询及同等联接查询，仅在能至少为查询中每一region创建一个索引的情况下为单region创建索引。任何对region的子集所加的索引都会降低性能。
  对于下面的查询：
  ```
  SELECT DISTINCT *
  FROM /investors inv, /securities sc, inv.heldSecurities inv_hs
    WHERE sc.status = "active"
    AND inv.name = "xyz"
    AND inv.age > 75
    AND inv_hs.secName = sc.secName
  ```
  对同等联接条件创建如下索引：
  FROM子句索引的表达式/investors inv, inv.heldSecuritiesinv_hsinv_hs.secName/securities scsc.secName
  之后，如果能创建更多索引，可在sc.status和inv.age或inv.name两者之一或全部上加索引。

## 在溢出OverflowRegion使用索引

可在溢出region查询中使用索引，限制如下：
- 必须使用同步索引维护方式。
- 索引from子句必须仅指定一个迭代器，而且必须引用键或条目值，而不能是region的entrySet。
- 索引数据自身不会存储和溢出到磁盘上。

**在使用多个region的同等关联查询中使用索引**
识别所有同等联接条件。之后，在联接所有region的同时为同等联接条件创建尽可能多的索引。如果为了更好地过滤数据存在冗余的同等联接条件用于联接两个region，为这些联接创建冗余的索引会对性能不利。仅为每个region对的一个同等联接条件创建索引。

## 查询分区region

分区region的基本存储单元是桶，存在于GemFire节点并包好所有映射到一个哈希值的全部条目。对分区region进行查询，系统会分发查询到所有节点的所有桶上，然后将结果集合并再返回查询结果。

### 查询限制

分区region查询与非分区region查询一样，除了下面的限制。如果对分区region的查询不符合限制会产生异常UnsupportedOperationException。
- 分区region及分区region和复制region之间的联接仅通过函数服务提供支持。对分区region的联接查询不支持客户端服务器API。
- 如果分区region和其他region同在一个节点上，可以对分区region及分区region和复制region之间进行联接查询。同等联接查询仅在同一节点上的分区region可行，且同一节点上的列用于查询的WHERE子句中。对于多列分区，一个AND子句需要在WHERE子句中。
- 同等联接查询允许用于分区region及分区region和本地复制region，只要复制region存在于所有分区region节点之上。为了在分区region和其他region（无论是否分区region）执行联接查询，需要在函数服务执行上下文中使用query.execute方法。
- 查询必须仅为一个SELECT表达式(相对于任意的OQL表达式)，前接零个或多个IMPORT语句。
- 只要仅有一个分区region被引用，SELECT表达式可以任意复杂，包括嵌套SELECT表达式。
- 分区region引用仅可在第一个FROM子句迭代器。其他FROM子句迭代器不能引用任何region(例如下钻到分区region的值).
- 第一个FROM子句迭代比仅包含一个对分区region的引用(引用可以为参数，例如$1)。
- 第一个FROM子句迭代器不能包含子查询，但其他FROM子句迭代器可以有子查询。
- 可在分区region查询中使用ORDER BY，但是ORDER BY指定的字段必须在投影列表中。

### 带有大结果集的查询

查询结果的大小取决于查询限定和整个数据集大小。分区region可以装载比其他region类型更多的数据，因此更有可能在分区region查询中获得大的结果集。如果结果集特别大，有可能导致接收结果的节点内存溢出。

## 查询扩展

### 函数

查询语言支持下面这些函数：
- ELEMENT(expr) -从集合或数组中抽出单个元素。如果参数并非含有一个元素的集合或数组，则方法抛出FunctionDomainException异常。
  示例：`ELEMENT(SELECT DISTINCT * FROM /exampleRegion WHERE id ='XYZ-1').status = 'active'`
- IS_DEFINED(expr) -如果表达式结果不为UNDEFINED返回TRUE。
- IS_UNDEFINED(expr)- 如果表达式结果为UNDEFINED返回TRUE。在大多数查询中，查询结果不会包含未定义值。IS_UNDEFINED函数允许包含未定义值，因此可以识别带有未定义值的元素。示例：**SELECT DISTINCT * FROM /exampleRegion p WHEREIS_UNDEFINED(p.status)**
- NVL(expr1, expr2) -如果expr1为空则返回expr2。表达式可以为绑定参数、路径表达式或字面值。
- TO_DATE (date_str, format_str) -返回Java Date类对象。date_str表示日期，format_str表示date_str所使用的日期格式。format_str会通过java.text.SimpleDateFormat进行解析。

### 字面值

GemFire支持下面的字面值类型：
- boolean - 布尔值，TRUE或FALSE
- integer和long -如果后缀为ASCII字母L则整型字面值为long类型，否则为init类型。
- floating point- 如果后缀为ASCII字母L则浮点型字面值为float类型，否则为double类型（可选择性使用ASCII字母D作为后置）。浮点型字面值可选择性使用指数后缀E或e，指数后缀后面可为有符号或无符号数值。
- string - 字符串字面值通过单引号分割。内嵌的单引号使用两个表示。例如，字符串'Hello'会认为是数值Hello，字符串'Hesaid, ''Hello'''会认为是Hesaid, 'Hello'。嵌入的新行会被认为是字符字面值的一部分。
- char -前缀为CHAR的字符串字面值为char类型，否则为string类型。单引号的字符字面值为CHAR ''''(四个单引号)。
- date -前缀为DATE的使用JDBC格式的java.sql.Date对象：DATEyyyy-mm-dd。yyyy代表年，mm代表月，dd代表日。年必须用四位数字表示，而不允许用两位数字。
- time -前缀为TIME的使用JDBC格式（基于24小时制）的java.sql.Time对象：TIMEhh:mm:ss。hh代表小时，mm代表分钟，ss代表秒。
- timestamp - 前缀为TIMESTAMP的使用JDBC格式的java.sql.Timestamp对象：TIMESTAMPyyyy-mm-dd hh:mm:ss.fffffffff。yyyy-mm-dd代表日期，hh:mm:ss代表时间，fffffffff代表秒的小数部分(最大九位数字)。
- NIL -- 与NULL等效。
- NULL --与Java中的null相同。
- UNDEFINED--可用于任意数据类型的特殊字面值。当访问一个空值属性的属性时期结果为UNDEFINED。注意：当访问一个值为null的属性时，其结果不是未定义的。例如查询访问属性address.city且address为null，则结果为未定义的。如果查询访问address，结果不是未定义的，而是NULL。

**使用java.util.Date比较数值**:可以使用java.util.Date值比较临时字面值DATE、TIME和TIMESTAMP。查询语言没有用于java.util.Date的字面值。

### 在查询语句中使用注释

可在查询语句中包含注释。单行注释可以用两个双破折号起始。多行注释以/*起始，以*/结尾。
```
SELECT DISTINCT * FROM/exampleRegion WHERE status = 'active' -- here is anothercomment
SELECT DISTINCT * FROM /* here is
a comment */ /exampleRegion  WHERE status='active'
```

### 方法调用

要在查询中使用方法，需要将属性名映射到想要调用的公开方法上。
```
SELECT DISTINCT * FROM/exampleRegion p WHERE p.positions.size >= 2 --映射为positions.size()
```
当通过查询处理器调用返回值为void的方法，其返回值为null。

#### 调用无参方法

如果属性名映射为无参公开方法，则在查询语句中可将方法名当作属性使用。例如emps.isEmpty等同于emps.isEmpty()，查询会在positions上调用isEmpty方法并返回所有没有positions的portfolios集合。
```
SELECT DISTINCT * FROM/exampleRegion p WHERE p.positions.isEmpty
```

#### 调用有参方法
```
SELECT DISTINCT * FROM/exampleRegion p WHERE p.name.startsWith('Bo')
```
对于重载方法，查询处理器通过运行时参数类型与方法所需参数类型进行匹配决定所调用的方法。如果仅有一个方法签名匹配所提供的参数，它会被调用。查询处理使用运行时类型匹配方法签名。
如果多于一个方法可被调用，查询处理器选择与给定参数最匹配的方法。例如，一个重载方法有多个相同参数个数的版本，一个用Person类型参数，另一个用Person子类Employee类型参数，且Employee是最匹配的对象类型。如果传递给方法的参数同两种类型都相符，查询处理采用带有Employee参数类型的方法。
参数处理器使用方法名和参数运行时类型决定适于调用的方法。因为使用运行时类型，值为null的参数没有任何类型信息，因此可以与任何类型的参数匹配。当使用了值为null的参数且查询处理器无法判断适用的方法，将抛出异常AmbiguousNameException。

### 操作符

#### 比较操作符

比较两个值并返回结果，TRUE或FALSE。支持的比较操作符为：
```
= 等于    <> 不等于    != 不等于    < 小于    <= 小于等于    > 大于    >= 大于等于
```
等于和不等于操作符同其他比较操作符相比具有最低优先级。它们可用于同null比较。如果相同UNDEFINED比较，使用IS_DEFINED或IS_UNDEFINED操作符而不是这些比较操作符。

#### 逻辑操作符

支持的逻辑操作符为AND和OR，当表达式同事使用两种操作符时，AND优先级高于OR。

#### 一元操作符

一元操作符对单个值或表达式进行操作，优先级低于表达式中的比较操作符。GemFire支持一元操作符NOT，其操作数须为boolean。

#### Map和下标操作符

Map和下标操作符可以访问键值对（例如map和region）及有序集合（例如数组、列表、字符串）中的元素。操作符表现为集合名跟中括号“[]”。映射和索引在中括号中指定。
数组、列表和字符串单元可以通过下标访问，下标从零起始。myList[index]代表myList列表里第（index+1）个元素。Map和region值可以通过键用相同语法访问。对于region，map操作符仅在本地缓存获取而不会使用netSearch。myRegion[keyExpression]等同于myRegion.getEntry(keyExpression).getValue。

#### 点和斜杠操作符

点操作符‘.’分割路径表达式上的属性名，与其等效的写法是右箭头"-> "。斜杠操作符用于访问子region时分割region名称。

### LIKE断言

GemFire有限支持like断言，表示为：
```
WHERE x LIKE ''
```
LIKE可用于表达“等于”：
```
SELECT DISTINCT * FROM/exampleRegion p where p.status LIKE 'active'
```
如果字符串加通配符'%'或'*'，表现为“起始”。
```
SELECT DISTINCT * FROM/exampleRegion p where p.status LIKE 'activ%'
```
通配符仅能用于句尾。如果在其他位置发现通配符将抛出异常。可以将转义的通配符放在字符串的任何位置。like断言会使用存在的索引。

### IN表达式

IN表达式是boolean类型表达式，指示一个表达式是否包含于兼容类型表达式集合中。
如果e1和e2是表达式，e2是一个集合且e1是与e2同类型或其子类的对象或字面值，则e1 INe2是一个boolean类型的表达式。其返回值为：
- TRUE 若e1不是UNDEFINED且包含于集合e2
- FALSE 若e1不是UNDEFINED且不包含于集合e2
- UNDEFINED 若e1为UNDEFINED
例如2 IN SET(1, 2, 3)为TRUE。另一个例子是所查询的集合由子查询定义。
```
SELECT DISTINCT * FROM/exampleRegion p WHERE p.ID IN (SELECT p2.ID FROM /exampleRegion2p2 WHERE p2.status = 'active')
```
内部SELECT语句返回 /exampleRegion2中所有status为active的条目id集合。外部SELECT迭代/exampleRegion，将每个条目的id同集合比较。对于每个条目，如果IN表达式返回TRUE，相关联的名称和地值加入外部SELECT集合。

### 类型转换

GemFire查询处理器在某些情况下为了执行包含不同类型的表达式会采取隐含类型转换和提升。查询处理器执行双目数值提升,方法调用转换和临时类型转换。

#### 双目数值提升（Binary numericpromotion）

查询处理器遇到比较操作符（<、 <=、>、>=、=和<>）时对操作数执行双目数值提升，按照下面的规则次序将操作数提升为操作数中宽度最大类型。
- 如果有操作数为double类型，则其他操作数转换为double类型
- 如果有操作数为float类型，则其他操作数转换为float类型
- 如果有操作数为long类型，则其他操作数转换为long类型
- 操作数转换为int char类型

#### 方法调用转换

查询语言中方法调用转换遵从Java方法调用转换，除了查询语言使用运行时类型而不是编译时类型，并且处理null参数时与Java不同。因为使用运行时类型，值为null的参数没有任何类型信息，因此可以与任何类型的参数匹配。当使用了值为null的参数且查询处理器无法判断适用的方法，将抛出异常AmbiguousNameException。

#### 临时类型转换

查询语言支持的临时类型包括java.util.Date、java.sql.Date、java.sql.Time和java.sql.Timestamp，这些类型被当作相同类型处理，能够互相按照纳秒数进行比较并用于索引。 

## 查询语言预留字

### 预留字

下列单词为查询语言预留不能用作标识符。标注星号的单词目前没有被GemFire使用，但预留用于未来实现。

<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><td><pre style="box-sizing: border-box; overflow: auto; padding: 1em;margin: 1em 0; line-height: 1.55em; word-break: break-all; word-wrap: break-word; border-radius: 4px; border: 1px dashed #2f6fab; background-color: #f9f9f9;"><code style="box-sizing: border-box; font-family: inconsolata, monaco, courier, monospace; font-size: inherit; padding: 0px; color: inherit; border-radius: 0px; white-space: pre-wrap; background-color: transparent;">abs\*
all\*
and
andthen\*
any\*
array
as
asc\*
avg\*
bag\*
boolean
by\*
byte
char
collection
count\*
date
declare\*
define\*
desc\*</code></pre></td><td><pre style="box-sizing: border-box; overflow: auto; padding: 1em;margin: 1em 0; line-height: 1.55em; word-break: break-all; word-wrap: break-word; border-radius: 4px; border: 1px dashed #2f6fab; background-color: #f9f9f9;"><code style="box-sizing: border-box; font-family: inconsolata, monaco, courier, monospace; font-size: inherit; padding: 0px; color: inherit; border-radius: 0px; white-space: pre-wrap; background-color: transparent;">dictionary
distinct
double
element
enum\*
except\*
exists\*
false
first\*
flatten\*
float
for\*
from\*
group\*
having\*
import
in
int
intersect\*
interval\*</code></pre></td><td><pre style="box-sizing: border-box; overflow: auto; padding: 1em;margin: 1em 0; line-height: 1.55em; word-break: break-all; word-wrap: break-word; border-radius: 4px; border: 1px dashed #2f6fab; background-color: #f9f9f9;"><code style="box-sizing: border-box; font-family: inconsolata, monaco, courier, monospace; font-size: inherit; padding: 0px; color: inherit; border-radius: 0px; white-space: pre-wrap; background-color: transparent;">is_defined
is_undefined
last\*
like
limit
list\*
listtoset\*
long
map
max\*
min\*
mod\*
nil
not
null
nvl
octet
or
order\*
<br></code></pre></td><td><pre style="box-sizing: border-box; overflow: auto; padding: 1em;margin: 1em 0; line-height: 1.55em; word-break: break-all; word-wrap: break-word; border-radius: 4px; border: 1px dashed #2f6fab; background-color: #f9f9f9;"><code style="box-sizing: border-box; font-family: inconsolata, monaco, courier, monospace; font-size: inherit; padding: 0px; color: inherit; border-radius: 0px; white-space: pre-wrap; background-color: transparent;">orelse\*
query\*
select
set
short
some\*
string
struct\*
sum\*
time
timestamp
to_date
true
type
undefine\*
undefined
union\*
unique\*
where
<br></code></pre></td></tr></tbody></table>

访问任何用查询预留字相同的方法、属性或命名对象，使用双括号将名称括起来。例如：`SELECT DISTINCT "type" FROM /root/portfolios WHERE status ='active'****SELECT DISTINCT * FROM /region1 WHERE emps."select"() <100000`

### 语言注记

- 查询语言关键字例如SELECT、NULL和DATE是大小写不敏感的。标识符例如属性名、方法名和路径表达式是大小写敏感的。
- 注释行以 -- (双破折号)起始。
- 注释块以/*起始，以*/结尾。
- 字符串字面值用单引号分隔，内嵌单引号使用两个表示。例如：
   ```
   'Hello' value = Hello 
   ```
   ```
   'He said, ''Hello''' value = He said, 'Hello'
   ```
- 字符字面值使用CHAR关键字加上使用单引号括起来的字符表示。单引号字符本省表示为'''' (使用了四个单引号)。
- TIMESTAMP字符值小数部分最大长度为9位数字。
