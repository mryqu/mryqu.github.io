---
title: 'Shell参数扩展'
date: 2013-06-23 18:55:00
categories: 
- Tool
- Linux
tags: 
- bash
- shell
- parameter
- expansion
---
在hadoop-env.sh中，有如下语句：
```
export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"/etc/hadoop"}
```
这种用法在[Shell Parameter Expansion](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)中进行了详尽的介绍，系统学习一下。
Bash中的$符号的作用是参数替换，将参数名替换为参数所代表的值。对于$来说，大括号是可选的，即$ABC和${ABC}代表同一个参数。但是它可以防止变量被错误解析，比如：${hello}world、${arr[1]}。
![Shell参数扩展](/images/2013/6/0026uWfMzy76LTdx0mM2c.png)

### 参数扩展

下列Bash对参数的测试项为未设置和null。如果略掉冒号，则仅测试未设置。

|表达式|含义
|-----
|${parameter:-word}|如果parameter没有被声明或者其值为空的话，则表达式替换成word；否则替换成parameter的值。
|${parameter:=word}|如果parameter没有被声明或者其值为空的话，则parameter设为word之后表达式返回parameter的值；否则替换成parameter的值。
|${parameter?word}|如果parameter没有被声明或者其值为空的话，则word被写往标准错误输出和Shell，非可交互的情况下退出；否则替换成parameter的值。
|${parameter:+word}|如果parameter没有被声明或者其值为空的话，则不进行替换；否则替换成parameter的值。
|${!varprefix*}<br>${!varprefix@}|匹配之前所有以varprefix开头进行声明的变量
|${!name[@]}<br>${!name[*]}|如果name是数组对象，返回数组下标列表；如果name以设置但不为数组对象，返回0；否则返回null。

![Shell参数扩展](/images/2013/6/0026uWfMzy76MeSPh3W40.png) ![Shell参数扩展](/images/2013/6/0026uWfMzy76Mgi6aOG5e.png)

### 字符串操作

|表达式|含义
|-----
|${% raw %}{#{% endraw %}parameter}|parameter的长度。
|${parameter:offset}|在parameter中，从位置offset开始提取子串。
|${parameter:offset:length}|在parameter中，从位置offset开始提取长度为length的子串。 
|${parameter#word}<br>${parameter##word}|从头开始扫描parameter对应值，将匹配word正则表达式的字符删除掉#为最短匹配，##为最长匹配。 
|${parameter%word}<br>${parameter%%word}|从尾开始扫描parameter对应值，将匹配word正则表达式的字符删除掉%为最短匹配，%%为最长匹配。 
|${parameter/pattern/string}<br>${parameter//pattern/string}|将parameter对应值的pattern代替为string。/表示只替换一次，//表示全部替换。 
|${parameter^pattern}<br>${parameter^^pattern}|如果pattern是单个字符，将parameter对应值中匹配pattern的字符转换为大写。^表示只转换匹配的首字母，^^表示全部转换。 
|${parameter,pattern}<br>${parameter,,pattern}|如果pattern是单个字符，将parameter对应值中匹配pattern的字符转换为小写。`,`表示只转换匹配的首字母，`,,`表示全部转换。 

![Shell参数扩展](/images/2013/6/0026uWfMzy76MitLvJVb3.png) ![Shell参数扩展](/images/2013/6/0026uWfMzy76MjVqWWr6f.png)