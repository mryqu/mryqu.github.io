---
title: 'Joda-Time笔记'
date: 2013-12-01 00:31:39
categories: 
- Java
tags: 
- joda
- time
- java
- date
- calendar
---
### [Joda](http://www.joda.org/)简介

[Joda](http://www.joda.org/)项目致力于为Java平台提供替代API的一些质量保证的基础库。包括如下子项目：
- [Joda-Time](http://www.joda.org/joda-time/) -日期和时间库
- [Joda-Money](http://www.joda.org/joda-money/) -货币库
- [Joda-Beans](http://www.joda.org/joda-beans/) -下一代JavaBeans
- [Joda-Convert](http://www.joda.org/joda-convert/) -字符串与对象转换库
- [Joda-Collect](http://www.joda.org/joda-collect/) - 提供JDK或[Google Guava](http://code.google.com/p/guava-libraries/)没有的集合数据类型
- [Joda-Primitives](http://www.joda.org/joda-primitives/) -提供原始数据类型集合

### [Joda-Time](http://www.joda.org/joda-time/)简介

其中[Joda-Time](http://www.joda.org/joda-time/)由于JDK自身时间日期API的不给力而被广泛使用，已经成为事实上的标准时间日期库。[Joda-Time](http://www.joda.org/joda-time/)在JavaSE8将融入JDK API内，使用者可以使用<tt style="color: rgb(34, 34, 34); line-height: 20px; background-color: rgb(255, 255, 255);">java.time</tt> (JSR-310)内的API了。Joda-Time在时区、时间差和时间解析等方面支持多种历法系统，但仍然提供很简单的API。默认的历法是ISO8601标准，此外也支持Gregorian([现行公历、格里历](https://zh.wikipedia.org/wiki/%E5%85%AC%E5%8E%86))、Julian([儒略历](https://zh.wikipedia.org/zh-cn/%E5%84%92%E7%95%A5%E6%9B%86))、Buddhist([佛历](https://zh.wikipedia.org/wiki/%E4%BD%9B%E6%9B%86))、Coptic([科普特历](https://zh.wikipedia.org/wiki/%E7%A7%91%E6%99%AE%E7%89%B9%E5%8E%86))、Ethiopic([埃塞俄比亚历](https://zh.wikipedia.org/wiki/%E5%9F%83%E5%A1%9E%E4%BF%84%E6%AF%94%E4%BA%9E%E6%9B%86))和Islamic([伊斯兰历](https://zh.wikipedia.org/wiki/%E4%BC%8A%E6%96%AF%E5%85%B0%E5%8E%86))历法系统。
为什么要使用Joda-Time（以下简称Joda）？考虑创建一个用时间表示的某个随意的时刻，例如2000年1月1日0时0分。如何创建一个用时间表示这个瞬间的JDK对象？使用java.util.Date？事实上这是行不通的，因为自JDK1.1 之后的每个 Java 版本的 Javadoc 都声明应当使用java.util.Calendar。Date中Date(intyear, int month, int date) 、Date(int year, int month, int date, inthrs, int min)、Date(int year, int month, int date, int hrs, int min,int sec)已经废弃、不建议使用，严重限制了您创建此类对象的途径。然而，Date确实有一个构造函数Date(long date)，您可以用来创建用时间表示某个瞬间的对象（除“当前时间”以外）。该方法使用距离1970年1月1日子时格林威治标准时间（也称为_epoch_）以来的毫秒数作为一个参数，对时区进行校正。
那么Calendar又如何呢？可以使用下面的方式创建必需的实例：
```
Calendar calendar = Calendar.getInstance();
calendar.set(2000, Calendar.JANUARY, 1, 0, 0, 0);
```

使用Joda，代码应该类似如下所示：
```
DateTime dateTime = new DateTime(2000, 1, 1, 0, 0, 0, 0);
```

这一行简单代码没有太大的区别。但是如果使问题稍微复杂化，假设希望在这个日期上加上90天并输出结果。使用JDK，需要如下代码：
```
Calendar calendar = Calendar.getInstance();
calendar.set(2000, Calendar.JANUARY, 1, 0, 0, 0);
SimpleDateFormat sdf =
  new SimpleDateFormat("E MM/dd/yyyy HH:mm:ss.SSS");
calendar.add(Calendar.DAY_OF_MONTH, 90);
System.out.println(sdf.format(calendar.getTime()));
```

使用Joda，代码如下所示：
```
DateTime dateTime = new DateTime(2000, 1, 1, 0, 0, 0, 0);
System.out.println(dateTime.plusDays(90).toString("E MM/dd/yyyy HH:mm:ss.SSS");
```

两者之间的差距拉大了（Joda用了两行代码，JDK则是 5 行代码）。
现在假设希望输出这样一个日期：距离Y2K45天之后的某天在下一个月的当前周的最后一天的日期。坦白地说，使用Calendar处理这个问题实在太痛苦了，即使是简单的日期计算，比如上面这个计算。使用Joda，代码如下所示：
```
DateTime dateTime = new DateTime(2000, 1, 1, 0, 0, 0, 0);
System.out.println(dateTime.plusDays(45).plusMonths(1).dayOfWeek()
                   .withMaximumValue().toString("E MM/dd/yyyy HH:mm:ss.SSS");
```
输出为：
```
Sun 03/19/2000 00:00:00.000
```

如果您正在寻找一种易于使用的方式替代JDK日期处理，那么您真的应该考虑Joda，具体原因如下：
- 易于使用
- 易于扩展
- 丰富特性
- 最新的时区计算
- 历法支持
- 易于互操作
- 性能更佳
- 良好的测试覆盖率
- 完整的文档
- 成熟
- 开源

### Joda-Time关键概念
![Joda-Time笔记](/images/2013/12/0026uWfMgy6TqyG6TPWa0.jpg)

### Joda 和 JDK 互操作性

Calendar类缺乏可用性，这一点很快就能体会到，而Joda弥补了这一不足。Joda的设计者还做出了一个决定，这可以说是它取得成功的关键一点：JDK互操作性。Joda的类能够（正如您将看到的一样，有时会采用一种比较迂回的方式）生成java.util.Date（和Calendar）的实例。这使您能够保留现有的依赖JDK的代码，但是又能够使用Joda 处理复杂的日期/时间计算。
例如，完成上一示例计算后。只需要稍作更改就可以将结果返回到JDK中：
```
Calendar calendar = Calendar.getInstance();
DateTime dateTime = new DateTime(2000, 1, 1, 0, 0, 0, 0);
dateTime = dateTime.plusDays(45).plusMonths(1).dayOfWeek().withMaximumValue();
System.out.println(dateTime.toString("E MM/dd/yyyy HH:mm:ss.SSS");
calendar.setTime(dateTime.toDate());
```
就是这么简单，完成了计算，但是可以继续在JDK对象中处理结果。这是Joda的一个非常棒的特性。
Joda也接受使用JDK对象用来构造Joda对象。
Joda构造函数将指定从epoch到某个时刻所经过的毫秒数来进行构造。它根据JDK Date对象的毫秒值创建一个DateTime对象。epoch与Joda定义是相同的，Joda的时间精度也用毫秒表示：
```
java.util.Date jdkDate = obtainDateSomehow();
long timeInMillis = jdkDate.getTime();
DateTime dateTime = new DateTime(timeInMillis);
```

下面这个例子与前例类似，唯一不同之处是我在这里将Date或Calendar对象直接传递给构造函数：
```
// Use a Date
java.util.Date jdkDate = obtainDateSomehow();
dateTime = new DateTime(jdkDate);

// Use a Calendar
java.util.Calendar calendar = obtainCalendarSomehow();
dateTime = new DateTime(calendar);
```

### 参考

[Joda-Time项目主页](http://www.joda.org/joda-time/)    
[IBM developerWorks：Joda-Time](http://www.ibm.com/developerworks/library/j-jodatime/)    
[开源时间开发工具Joda-time介绍](http://blog.csdn.net/dhdhdh0920/article/details/7415359)    
[Joda项目主页](http://www.joda.org/)    