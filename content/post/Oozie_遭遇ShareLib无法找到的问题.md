---
title: '[Oozie] 遭遇ShareLib无法找到的问题'
date: 2018-07-13 05:40:09
categories: 
- Hadoop+Spark
- Oozie
tags: 
-  oozie
- setup
- sharelib
- hadoop
- 5.0.0
---

折腾几天，终于装好了Oozie 5.0.0，并且启动了Oozie守护进程。
```
vagrant@node1:~$ oozie admin -oozie http://10.211.55.101:11000/oozie -status
log4j:WARN No appenders could be found for logger (org.apache.hadoop.security.authentication.client.KerberosAuthenticator).
log4j:WARN Please initialize the log4j system properly.
log4j:WARN See http://logging.apache.org/log4j/1.2/faq.html#noconfig for more info.
System mode: NORMAL
```
![oozie](/images/2018/07/oozie.png)

不过运行MapReduce demo总是出错，找不到Oozie的共享库，日志如下：
```
2018-07-12 04:45:50,228  WARN ActionStartXCommand:523 - SERVER[node1] USER[vagrant] GROUP[-] TOKEN[] APP[map-reduce-wf] JOB[0000001-XXXXXXXXXXXXXXX-oozie-root-W] ACTION[0000001-XXXXXXXXXXXXXXX-oozie-root-W@mr-node] Error starting action [mr-node]. ErrorType [FAILED], ErrorCode [It should never happen], Message [File /user/root/share/lib does not exist]
org.apache.oozie.action.ActionExecutorException: File /user/root/share/lib does not exist
        at org.apache.oozie.action.hadoop.jaxaActionExecutor.addSystemShareLibForAction(JaxaActionExecutor.jaxa:646)
        at org.apache.oozie.action.hadoop.JaxaActionExecutor.addAllShareLibs(JaxaActionExecutor.jaxa:760)
        at org.apache.oozie.action.hadoop.JaxaActionExecutor.setLibFilesArchives(JaxaActionExecutor.jaxa:746)
        at org.apache.oozie.action.hadoop.JaxaActionExecutor.submitLauncher(JaxaActionExecutor.jaxa:984)
        at org.apache.oozie.action.hadoop.JaxaActionExecutor.start(JaxaActionExecutor.jaxa:1512)
        at org.apache.oozie.command.wf.ActionStartXCommand.execute(ActionStartXCommand.jaxa:243)
        at org.apache.oozie.command.wf.ActionStartXCommand.execute(ActionStartXCommand.jaxa:68)
        at org.apache.oozie.command.XCommand.call(XCommand.jaxa:290)
        at org.apache.oozie.service.CallableQueueService$CompositeCallable.call(CallableQueueService.jaxa:334)
        at org.apache.oozie.service.CallableQueueService$CompositeCallable.call(CallableQueueService.jaxa:263)
        at Jaxa.util.concurrent.FutureTask.run(FutureTask.jaxa:266)
        at org.apache.oozie.service.CallableQueueService$CallableWrapper.run(CallableQueueService.jaxa:181)
        at Jaxa.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.jaxa:1149)
        at Jaxa.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.jaxa:624)
        at Jaxa.lang.Thread.run(Thread.jaxa:748) 
```
折腾了无数次oozie-setup.sh sharelib命令，root和vagrant用户都试过。还在oozie-site.xml中指定了oozie.service.WorkflowAppService.system.libpath属性。结果统统失败。
```
vagrant@node1:~$ sudo -sE
root@node1:~#/usr/local/oozie/bin/oozie-setup.sh sharelib create -fs hdfs://10.211.55.101 -locallib /usr/local/oozie/oozie-sharelib-5.0.0.tar.gz
root@node1:~#/usr/local/oozie/bin/oozied.sh start
root@node1:~#exit
vagrant@node1:~$ oozie admin -configuration | grep oozie.service.WorkflowAppService.system.libpath
oozie.service.WorkflowAppService.system.libpath : /user/root/share/lib
vagrant@node1:~$ oozie admin -shareliblist -oozie http://localhost:11000/oozie
[Available ShareLib]
```
之后找到了[Oozie/OOZIE-3208 "It should never happen" error messages should be more specific to root cause](https://issues.apache.org/jira/browse/OOZIE-3208)，不过就是改善一下错误消息并且在5.1.0里发布，还是没找到问题所在。

再之后发现自Oozie4.2.0开始oozie.service.WorkflowAppService.system.libpath的默认值变了：
![oozie-default](/images/2018/07/oozie-default.png)

将oozie-site.xml中oozie.service.WorkflowAppService.system.libpath属性值改为hdfs://10.211.55.101/user/root/share/lib，结果出错信息变成了"IllegalArgumentException: Wrong FS: hdfs://10.211.55.101/user/root/share/lib, expected: file:///"。
```
2018-07-12 08:20:29,526 ERROR ShareLibService:517 - SERVER[node1] org.apache.oozie.service.ServiceException: E0104: Could not fully initialize service [org.apache.oozie.service.ShareLibService], Not able to cache sharelib. An Admin needs to install the sharelib with oozie-setup.sh and issue the 'oozie admin' CLI command to update the sharelib
org.apache.oozie.service.ServiceException: E0104: Could not fully initialize service [org.apache.oozie.service.ShareLibService], Not able to cache sharelib. An Admin needs to install the sharelib with oozie-setup.sh and issue the 'oozie admin' CLI command to update the sharelib
        at org.apache.oozie.service.ShareLibService.init(ShareLibService.jaxa:148)
        at org.apache.oozie.service.Services.setServiceInternal(Services.jaxa:386)
        at org.apache.oozie.service.Services.setService(Services.jaxa:372)
        at org.apache.oozie.service.Services.loadServices(Services.jaxa:304)
        at org.apache.oozie.service.Services.init(Services.jaxa:212)
        at org.apache.oozie.server.guice.ServicesProvider.get(ServicesProvider.jaxa:31)
        at org.apache.oozie.server.guice.ServicesProvider.get(ServicesProvider.jaxa:25)
        at com.google.inject.internal.BoundProviderFactory.get(BoundProviderFactory.jaxa:55)
        at com.google.inject.internal.ProviderToInternalFactoryAdapter$1.call(ProviderToInternalFactoryAdapter.jaxa:46)
        at com.google.inject.internal.InjectorImpl.callInContext(InjectorImpl.jaxa:1031)
        at com.google.inject.internal.ProviderToInternalFactoryAdapter.get(ProviderToInternalFactoryAdapter.jaxa:40)
        at com.google.inject.Scopes$1$1.get(Scopes.jaxa:65)
        at com.google.inject.internal.InternalFactoryToProviderAdapter.get(InternalFactoryToProviderAdapter.jaxa:40)
        at com.google.inject.internal.SingleParameterInjector.inject(SingleParameterInjector.jaxa:38)
        at com.google.inject.internal.SingleParameterInjector.getAll(SingleParameterInjector.jaxa:62)
        at com.google.inject.internal.ConstructorInjector.construct(ConstructorInjector.jaxa:84)
        at com.google.inject.internal.ConstructorBindingImpl$Factory.get(ConstructorBindingImpl.jaxa:254)
        at com.google.inject.internal.BoundProviderFactory.get(BoundProviderFactory.jaxa:53)
        at com.google.inject.internal.ProviderToInternalFactoryAdapter$1.call(ProviderToInternalFactoryAdapter.jaxa:46)
        at com.google.inject.internal.InjectorImpl.callInContext(InjectorImpl.jaxa:1031)
        at com.google.inject.internal.ProviderToInternalFactoryAdapter.get(ProviderToInternalFactoryAdapter.jaxa:40)
        at com.google.inject.Scopes$1$1.get(Scopes.jaxa:65)
        at com.google.inject.internal.InternalFactoryToProviderAdapter.get(InternalFactoryToProviderAdapter.jaxa:40)
        at com.google.inject.internal.SingleParameterInjector.inject(SingleParameterInjector.jaxa:38)
        at com.google.inject.internal.SingleParameterInjector.getAll(SingleParameterInjector.jaxa:62)
        at com.google.inject.internal.ConstructorInjector.construct(ConstructorInjector.jaxa:84)
        at com.google.inject.internal.ConstructorBindingImpl$Factory.get(ConstructorBindingImpl.jaxa:254)
        at com.google.inject.internal.InjectorImpl$4$1.call(InjectorImpl.jaxa:978)
        at com.google.inject.internal.InjectorImpl.callInContext(InjectorImpl.jaxa:1024)
        at com.google.inject.internal.InjectorImpl$4.get(InjectorImpl.jaxa:974)
        at com.google.inject.internal.InjectorImpl.getInstance(InjectorImpl.jaxa:1013)
        at org.apache.oozie.server.EmbeddedOozieServer.main(EmbeddedOozieServer.jaxa:255)
Caused by: java.lang.IllegalArgumentException: Wrong FS: hdfs://10.211.55.101/user/root/share/lib, expected: file:///
        at org.apache.hadoop.fs.FileSystem.checkPath(FileSystem.jaxa:648)
        at org.apache.hadoop.fs.RawLocalFileSystem.pathToFile(RawLocalFileSystem.jaxa:82)
        at org.apache.hadoop.fs.RawLocalFileSystem.listStatus(RawLocalFileSystem.jaxa:427)
        at org.apache.hadoop.fs.FileSystem.listStatus(FileSystem.jaxa:1516)
        at org.apache.hadoop.fs.FileSystem.listStatus(FileSystem.jaxa:1556)
        at org.apache.hadoop.fs.ChecksumFileSystem.listStatus(ChecksumFileSystem.jaxa:674)
        at org.apache.hadoop.fs.FileSystem.listStatus(FileSystem.jaxa:1516)
        at org.apache.hadoop.fs.FileSystem.listStatus(FileSystem.jaxa:1556)
        at org.apache.oozie.service.ShareLibService.getLatestLibPath(ShareLibService.jaxa:734)
        at org.apache.oozie.service.ShareLibService.updateShareLib(ShareLibService.jaxa:597)
        at org.apache.oozie.service.ShareLibService.init(ShareLibService.jaxa:138)
        ... 31 more
```
最后在oozie-site.xml添加了oozie.service.HadoopAccessorService.hadoop.configurations属性值*=/usr/local/hadoop/etc/hadoop/，终于可以找到共享库了：
```
vagrant@node1:~$ oozie admin -shareliblist
[Available ShareLib]
hive
distcp
mapreduce-streaming
spark
oozie
hcatalog
hive2
sqoop
pig
```
### 参考

*****

[Oozie Quick Start](http://oozie.apache.org/docs/5.0.0/DG_QuickStart.html)  
[Oozie Command Line Interface Utilities](http://oozie.apache.org/docs/5.0.0/DG_CommandLineTool.html)  
[Oozie Examples](http://oozie.apache.org/docs/5.0.0/DG_Examples.html)  
[Oozie Share Lib does not exist error](http://hadooptutorial.info/oozie-share-lib-does-not-exist-error/)  

