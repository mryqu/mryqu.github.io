---
title: 'update-alternatives与JAVA_HOME'
date: 2016-11-02 06:15:02
categories: 
- Tool
tags: 
- ubuntu
- update-alternatives
- java home
- dynamic
- switch
---
### 测试

#### /etc/profile配置
```
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:$JAVA_HOME/bin
```
#### 使用update-alternatives切换JAVA
```
hadoop@note50064:~$ which java
/usr/bin/java
hadoop@note50064:~$ sudo update-alternatives --config java
There are 2 choices for the alternative .

  Selection    Path                                            Priority   Status
------------------------------------------------------------
  0            /usr/lib/jvm/java-7-oracle/jre/bin/java          1072      auto mode
* 1            /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java   1071      manual mode
  2            /usr/lib/jvm/java-7-oracle/jre/bin/java          1072      manual mode

Press enter to keep the current choice[*], or type selection number:
hadoop@note50064:~$ ls -l /usr/bin/java
lrwxrwxrwx 1 root root 22 Nov 21 03:26 /usr/bin/java -> /etc/alternatives/java
hadoop@note50064:~$ ls -l /etc/alternatives/java
lrwxrwxrwx 1 root root 46 Nov  1 01:44 /etc/alternatives/java -> /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java
hadoop@note50064:~$ java -version
java version "1.7.0_121"
OpenJDK Runtime Environment (IcedTea 2.6.8) (7u121-2.6.8-1ubuntu0.14.04.1)
OpenJDK 64-Bit Server VM (build 24.121-b00, mixed mode)
hadoop@note50064:~$ $JAVA_HOME/bin/java -version
java version "1.7.0_121"
OpenJDK Runtime Environment (IcedTea 2.6.8) (7u121-2.6.8-1ubuntu0.14.04.1)
OpenJDK 64-Bit Server VM (build 24.121-b00, mixed mode)
hadoop@note50064:~$
hadoop@note50064:~$ sudo update-alternatives --config java
There are 2 choices for the alternative .

  Selection    Path                                            Priority   Status
------------------------------------------------------------
  0            /usr/lib/jvm/java-7-oracle/jre/bin/java          1072      auto mode
* 1            /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java   1071      manual mode
  2            /usr/lib/jvm/java-7-oracle/jre/bin/java          1072      manual mode

Press enter to keep the current choice[*], or type selection number: 2
update-alternatives: using /usr/lib/jvm/ in manual mode
hadoop@note50064:~$ ls -l /etc/alternatives/java
lrwxrwxrwx 1 root root 39 Nov  1 01:45 /etc/alternatives/java -> /usr/lib/jvm/java-7-oracle/jre/bin/java
hadoop@note50064:~$ java -version
java version "1.7.0_80"

hadoop@note50064:~$ $JAVA_HOME/bin/java -version
java version "1.7.0_121"
OpenJDK Runtime Environment (IcedTea 2.6.8) (7u121-2.6.8-1ubuntu0.14.04.1)
OpenJDK 64-Bit Server VM (build 24.121-b00, mixed mode)
```
### 分析

Alternatives是使用符号连接管理已装软件位置的工具。例外我们通常在命令行使用的java命令使用的是/usr/bin/java；而/usr/bin/java指向/etc/alternatives/java，/etc/alternatives/java指向的是真正某个JRE/JDK包下的java命令。
尽管可以使用Alternatives工具切换JAVA，但是由于我的JAVA_HOME始终指向OpenJDK，所以$JAVA_HOME/bin/java不会随Alternatives的指定而切换。这样使用JAVA_HOME环境变量的Hadoop等工具一直用OpenJDK。

### 方案

更改/etc/profile配置：
```
export 
export JDK_HOME=$(readlink -f /usr/bin/
export CLASSPATH=.:$JDK_HOME/lib/dt.jar:$JDK_HOME/lib/tools.jar
export PATH=$PATH:$JAVA_HOME/bin
```
这样通过update-alternatives命令更改java和javac后，重启命令行后JAVA_HOME和JDK_HOME也随之更新。
这个方案自己不甚满意，有时间再继续研究吧。

### 参考
* * *
[What is the difference between JAVA_HOME and update-alternatives?](http://unix.stackexchange.com/questions/123412/what-is-the-difference-between-java-home-and-update-alternatives)  
[Setting up your Linux environment to support multiple versions of Java](https://grymoire.wordpress.com/2014/11/20/setting-up-your-linux-environment-to-support-multiple-versions-of-java/)  
[Using the Debian alternatives system](https://debian-administration.org/article/91/Using_the_Debian_alternatives_system)  
[update-alternatives - Linux man page](https://linux.die.net/man/8/update-alternatives)  