---
title: '[Oozie] Oozie构建问题'
date: 2018-07-05 06:20:10
categories: 
- BigData
tags: 
- oozie
- build
- error
- log4j
- getlevel
---

想定制Oozie构建，结果log4j总出错，移除了pig、sqoop和hive就好了。
```
root@node1:~# /vagrant/resources/oozie-5.0.0/bin/mkdistro.sh -DskipTests -Puber -Dhadoop.version=2.7.6 -Ptez -Dpig.version=0.17.0 -Dsqoop.version=1.4.7 -Dhive.version=2.3.3 -Dtez.version=0.9.1
......
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-compiler-plugin:3.7.0:testCompile (default-testCompile) on project oozie-core: Compilation failure: Compilation failure:
[ERROR] /vagrant/resources/oozie-5.0.0/core/src/test/java/org/apache/oozie/sla/TestSLACalculatorMemory.java:[836,48] cannot find symbol
[ERROR] symbol:   method getLevel()
[ERROR] location: variable firstLogEntry of type org.apache.log4j.spi.LoggingEvent
[ERROR] /vagrant/resources/oozie-5.0.0/core/src/test/java/org/apache/oozie/sla/TestSLACalculatorMemory.java:[837,33] cannot find symbol
[ERROR] symbol:   method getMessage()
[ERROR] location: variable firstLogEntry of type org.apache.log4j.spi.LoggingEvent
[ERROR] /vagrant/resources/oozie-5.0.0/core/src/test/java/org/apache/oozie/sla/TestSLACalculatorMemory.java:[838,79] cannot find symbol
[ERROR] symbol:   method getLoggerName()
[ERROR] location: variable firstLogEntry of type org.apache.log4j.spi.LoggingEvent
[ERROR] /vagrant/resources/oozie-5.0.0/core/src/test/java/org/apache/oozie/service/TestEventHandlerService.java:[213,47] cannot find symbol
[ERROR] symbol:   method getLevel()
[ERROR] location: variable logEntry of type org.apache.log4j.spi.LoggingEvent
[ERROR] /vagrant/resources/oozie-5.0.0/core/src/test/java/org/apache/oozie/service/TestEventHandlerService.java:[214,32] cannot find symbol
[ERROR] symbol:   method getMessage()
[ERROR] location: variable logEntry of type org.apache.log4j.spi.LoggingEvent
[ERROR] /vagrant/resources/oozie-5.0.0/core/src/test/java/org/apache/oozie/service/TestEventHandlerService.java:[215,82] cannot find symbol
[ERROR] symbol:   method getLoggerName()
[ERROR] location: variable logEntry of type org.apache.log4j.spi.LoggingEvent
[ERROR] /vagrant/resources/oozie-5.0.0/core/src/test/java/org/apache/oozie/service/TestEventHandlerService.java:[221,47] cannot find symbol
[ERROR] symbol:   method getLevel()
[ERROR] location: variable logEntry of type org.apache.log4j.spi.LoggingEvent
[ERROR] /vagrant/resources/oozie-5.0.0/core/src/test/java/org/apache/oozie/service/TestEventHandlerService.java:[222,32] cannot find symbol
[ERROR] symbol:   method getMessage()
[ERROR] location: variable logEntry of type org.apache.log4j.spi.LoggingEvent
[ERROR] /vagrant/resources/oozie-5.0.0/core/src/test/java/org/apache/oozie/service/TestEventHandlerService.java:[231,32] cannot find symbol
[ERROR] symbol:   method getMessage()
[ERROR] location: variable logEntry of type org.apache.log4j.spi.LoggingEvent
[ERROR] /vagrant/resources/oozie-5.0.0/core/src/test/java/org/apache/oozie/service/TestEventHandlerService.java:[240,32] cannot find symbol
[ERROR] symbol:   method getMessage()
[ERROR] location: variable logEntry of type org.apache.log4j.spi.LoggingEvent
......

root@node1:~# /vagrant/resources/oozie-5.0.0/bin/mkdistro.sh -Puber -Dhadoop.version=2.7.6 -Ptez -Dtez.version=0.9.1 -DskipTests
......
[INFO] Reactor Summary:
[INFO]
[INFO] Apache Oozie Main ........................ SUCCESS [  1.315 s]
[INFO] Apache Oozie Client ...................... SUCCESS [04:51 min]
[INFO] Apache Oozie Share Lib Oozie ............. SUCCESS [ 10.467 s]
[INFO] Apache Oozie Share Lib HCatalog .......... SUCCESS [  6.158 s]
[INFO] Apache Oozie Share Lib Distcp ............ SUCCESS [  1.704 s]
[INFO] Apache Oozie Core ........................ SUCCESS [03:20 min]
[INFO] Apache Oozie Share Lib Streaming ......... SUCCESS [  5.225 s]
[INFO] Apache Oozie Share Lib Pig ............... SUCCESS [03:04 min]
[INFO] Apache Oozie Share Lib Hive .............. SUCCESS [ 16.510 s]
[INFO] Apache Oozie Share Lib Hive 2 ............ SUCCESS [ 10.609 s]
[INFO] Apache Oozie Share Lib Sqoop ............. SUCCESS [  3.858 s]
[INFO] Apache Oozie Examples .................... SUCCESS [ 14.172 s]
[INFO] Apache Oozie Share Lib Spark ............. SUCCESS [ 19.237 s]
[INFO] Apache Oozie Share Lib ................... SUCCESS [ 54.691 s]
[INFO] Apache Oozie Docs ........................ SUCCESS [09:18 min]
[INFO] Apache Oozie WebApp ...................... SUCCESS [09:03 min]
[INFO] Apache Oozie Tools ....................... SUCCESS [  7.231 s]
[INFO] Apache Oozie MiniOozie ................... SUCCESS [  2.782 s]
[INFO] Apache Oozie Server ...................... SUCCESS [ 17.591 s]
[INFO] Apache Oozie Distro ...................... SUCCESS [13:35 min]
[INFO] Apache Oozie ZooKeeper Security Tests .... SUCCESS [  3.603 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 46:10 min
[INFO] Finished at: 2018-07-04T08:44:26+00:00
[INFO] Final Memory: 166M/986M
[INFO] ------------------------------------------------------------------------

Oozie distro created, DATE[2018.07.04-07:58:14GMT] VC-REV[unavailable], available at [/vagrant/resources/oozie-5.0.0/distro/target]
```