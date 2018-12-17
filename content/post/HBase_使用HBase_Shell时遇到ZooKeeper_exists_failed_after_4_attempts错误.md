---
title: '[HBase] 使用HBase Shell时遇到ZooKeeper exists failed after 4 attempts错误'
date: 2016-03-05 06:21:09
categories: 
- Hadoop/Spark
- HBase
tags: 
- hbase
- shell
- zookeeper
- exist
- failed
---
今天打开HBase Shell就闪退，可是前两天还好好的。错误如下：
```
2016-03-05 00:32:23,597 ERROR [main] zookeeper.RecoverableZooKeeper: ZooKeeper exists failed after 4 attempts
2016-03-05 00:32:23,598 WARN  [main] zookeeper.ZKUtil: hconnection-0x2dba911d0x0, quorum=node50064.mryqu.com:2181,node50069.mryqu.com:2181,node51054.mryqu.com:2181, baseZNode=/hbase Unable to set watcher on znode (/hbase/hbaseid)
org.apache.zookeeper.KeeperException$ConnectionLossException: KeeperErrorCode = ConnectionLoss for /hbase/hbaseid
  at org.apache.zookeeper.KeeperException.create(KeeperException:99)
  at org.apache.zookeeper.KeeperException.create(KeeperException:51)
  at org.apache.zookeeper.ZooKeeper.exists(ZooKeeper:1045)
  at org.apache.hadoop.hbase.zookeeper.RecoverableZooKeeper.exists(RecoverableZooKeeper:220)
  at org.apache.hadoop.hbase.zookeeper.ZKUtil.checkExists(ZKUtil:419)
  at org.apache.hadoop.hbase.zookeeper.ZKClusterId.readClusterIdZNode(ZKClusterId:65)
  at org.apache.hadoop.hbase.client.ZooKeeperRegistry.getClusterId(ZooKeeperRegistry:105)
  at org.apache.hadoop.hbase.client.ConnectionManager$HConnectionImplementation.retrieveClusterId(ConnectionManager:905)
  at org.apache.hadoop.hbase.client.ConnectionManager$HConnectionImplementation.<init>(ConnectionManager:648)
  at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
  at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl:57)
  at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl:45)
  at 
  at org.apache.hadoop.hbase.client.ConnectionFactory.createConnection(ConnectionFactory:238)
  at org.apache.hadoop.hbase.client.ConnectionFactory.createConnection(ConnectionFactory:218)
  at org.apache.hadoop.hbase.client.ConnectionFactory.createConnection(ConnectionFactory:119)
  at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
  at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl:57)
  at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl:43)
  at 
  at org.jrubysupportMethod.invokeDirectWithExceptionHandling(
  at org.jrubysupportMethod.invokeStaticDirect(
  at org.jruby.invokers.StaticMethodInvoker.call(StaticMethodInvoker:58)
  at org.jruby.runtime.callsite.CachingCallSite.cacheAndCall(CachingCallSite:312)
  at org.jruby.runtime.callsite.CachingCallSite.call(CachingCallSite:169)
  at org.jruby.ast.CallOneArgNode.interpret(CallOneArgNode:57)
  at org.jruby.ast.InstAsgnNode.interpret(InstAsgnNode:95)
  at org.jruby.ast.NewlineNode.interpret(NewlineNode:104)
  at org.jruby.ast.BlockNode.interpret(BlockNode:71)
  at org.jruby.evaluator.ASTInterpreter.INTERPRET_METHOD(ASTInterpreter:74)
  at org.jruby.internal.runtime.methods.InterpretedMethod.call(InterpretedMethod:169)
  at org.jruby.internal.runtime.methods.DefaultMethod.call(DefaultMethod:191)
  at org.jruby.runtime.callsite.CachingCallSite.cacheAndCall(CachingCallSite:302)
  at org.jruby.runtime.callsite.CachingCallSite.callBlock(CachingCallSite:144)
  at org.jruby.runtime.callsite.CachingCallSite.call(CachingCallSite:148)
  at org.jruby.RubyClass.newInstance(RubyClass:822)
  at org.jruby.RubyClass$i$newInstance.call(RubyClass$i$newInstance.gen:65535)
  at org.jruby.internal.runtime.methodsMethod$
  at org.jruby.runtime.callsite.CachingCallSite.cacheAndCall(CachingCallSite:292)
  at org.jruby.runtime.callsite.CachingCallSite.call(CachingCallSite:135)
  at usr.local.hbase.bin.hirb.__file__(/usr/local/hbase/bin/hirb.rb:131)
  at usr.local.hbase.bin.hirb.load(/usr/local/hbase/bin/hirb.rb)
  at org.jruby.Ruby.runScript(Ruby:697)
  at org.jruby.Ruby.runScript(Ruby:690)
  at org.jruby.Ruby.runNormally(Ruby:597)
  at org.jruby.Ruby.runFromMain(Ruby:446)
  at org.jruby.Main.doRunFromMain(Main:369)
  at org.jruby.Main.internalRun(Main:258)
  at org.jruby.Main.run(Main:224)
  at org.jruby.Main.run(Main:208)
  at org.jruby.Main.main(Main:188)
```
首先通过jps查看JVM进程信息，没有发现QuorumPeerMain进程。看来是ZooKeeper出了问题，查看了zookeeper.out中的日志，顺着线索发现myid文件内容莫名其妙地跟我原来设定的ID不一样了。改正后，解决问题。
