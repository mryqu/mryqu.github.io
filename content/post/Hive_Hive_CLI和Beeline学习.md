---
title: '[Hive] Hive CLI和Beeline学习'
date: 2015-07-28 05:59:51
categories: 
- Hadoop/Spark
- Hive
tags: 
- hive
- shell
- hadoop
- cli
- beeline
---
### Hive CLI学习

Hive CLI使用手册很简单，但是看完了对有些参数还是不太理解，所以就翻翻Hive CLI源码对照学习吧。

#### -f和-i选项的区别

Hive CLI使用手册说-i指定的是初始化SQL文件，-f指定的是SQL脚本文件。
通过阅读源码可知，所谓的初始化SQL文件就是你期望每次执行HiveCLI都要在其他操作之前运行的一些SQL命令。执行完初始化SQL，可以接着执行-e选项中的SQL命令、-f选项中的SQL脚本文件或交互输入的命令；而-f选项和-e选项二者只能存在其一，执行完-f选项后退出CLI。

#### hiverc文件

当没有指定-i参数时，CLI会尝试加载$HIVE_HOME/bin/.hiverc、$HIVE_CONF_DIR/.hiverc和$HOME/.hiverc作为初始化文件。只要存在，这些.hiverc都会被加载执行。
通过[CliDriver类](https://github.com/apache/hive/blob/master/cli/src/java/org/apache/hadoop/hive/cli/CliDriver.java)的processInitFiles方法可知，执行初始化SQL时始终采用静默模式，即不显示执行进度信息，只显示最后结果；执行-f选项中SQL脚本时是否采用静默模式由-S选项控制。

#### Hive CLI如何处理shell命令、Hive命令和SQL的？

HiveCLI既可以处理一个SQL脚本文件、也可以处理多个SQL命令。它通过处理多行命令，以";"为分隔符，获取单个命令列表。一个单个命令，即可能是--开头的注释行，也可能是!开头的shell命令，此外SQL命令和Hive自身支持的命令。
- 对于shell命令，Hive CLI是通过ShellCmdExecutor执行的；
- 对于SQL命令，Hive CLI是通过org.apache.hadoop.hive.ql.Driver执行的；
- 对于Hive命令，HiveCLI通过SetProcessor、ResetProcessor、DfsProcessor、AddResourceProcessor、ListResourceProcessor、DeleteResourceProcessor、CompileProcessor、ReloadProcessor、CryptoProcessor这些处理进行执行。

#### --hiveconf、--define (-d)、--hivevar之间的关系

首先我们看一下[OptionsProcessor类](https://github.com/apache/hive/blob/master/cli/src/java/org/apache/hadoop/hive/cli/OptionsProcessor.java)，它通过[Apache Commons CLI](https://commons.apache.org/proper/commons-cli/)解析Hive CLI命令参数:
- 其process_stage1方法将--hiveconf参数置入系统属性中，将--define和--hivevar参数置入CliSessionState对象的hiveVariables字段
- 其process_stage2方法将--hiveconf参数置入CliSessionState对象的cmdProperties字段

接下来看一下CliSessionState对象的hiveVariables字段和cmdProperties字段使用情况:
- CliDriver.run方法将CliSessionState对象的cmdProperties字段中的键值对覆盖HiveConf对象，然后置入CliSessionState对象的overriddenConfigurations字段
- CliSessionState对象的hiveVariables字段主要用于变量替换，包括替换提示符（CliDriver.run）、替换source命令所跟文件路径及shell命令（CliDriver.processCmd）、替换SQL（Driver.compile）、替换Hive命令（DfsProcessor.run、......）

总之：
- --hiveconf参数在命令行中设置Hive的运行时配置参数，优先级高于hive-site.xml,但低于Hive交互Shell中使用Set命令设置。
- --define (-d)和--hivevar没有区别，都是用于变量替换的。

#### hivehistory文件

Hive CLI会创建$HOME/.hivehistory文件，并在其中记录命令历史记录。

#### -v参数打印出的SQL语句是变量替换后的吗？

不是，打印的是原始SQL语句。
![[Hive] Hive CLI和Beeline学习](/images/2015/7/0026uWfMzy7aXN3VbkA30.png)

#### 看了Hive CLI源码后的疑惑

- [CliDriver类](https://github.com/apache/hive/blob/master/cli/src/java/org/apache/hadoop/hive/cli/CliDriver.java)主函数实例化一个CliDriver对象，而在executeDriver方法中不用自身实例，偏偏又实例化一个CliDriver对象cli来，为啥？
- --hiveconf参数会被放入CliSessionState对象的cmdProperties字段和overriddenConfigurations字段，难道不能合并成一份么？

### Hive Beeline学习

[BeeLine类](https://github.com/apache/hive/blob/master/beeline/src/java/org/apache/hive/beeline/BeeLine.java)的dispatch负责将特定命令行分发给适合的CommandHandler。
- 其中以!起始的SQLLine命令由execCommandWithPrefix方法处理，具体实现见[Commands类](https://github.com/apache/hive/blob/master/beeline/src/java/org/apache/hive/beeline/Commands.java)的同名方法。![[Hive] Hive CLI和Beeline学习](/images/2015/7/0026uWfMzy7aZjD4Hcdd1.png)
- 其他命令则由[Commands类](https://github.com/apache/hive/blob/master/beeline/src/java/org/apache/hive/beeline/Commands.java)的sql方法处理

### 参考

[Hive LanguageManual CLI](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+Cli)  
[Hive LanguageManual VariableSubstitution](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+VariableSubstitution)  
[Hive CLI source code](https://github.com/apache/hive/tree/master/cli/src/java/org/apache/hadoop/hive/cli)  
[Beeline – Command Line Shell](https://cwiki.apache.org/confluence/display/Hive/HiveServer2+Clients#HiveServer2Clients-Beeline%E2%80%93CommandLineShell)  
[Hive Beeline CLI source code](https://github.com/apache/hive/tree/master/beeline)  