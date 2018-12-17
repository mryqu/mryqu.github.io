---
title: '*nux中的Here documents和Here strings'
date: 2014-01-01 21:09:54
categories: 
- Tool
- Linux
tags: 
- here-document
- heredoc
- here-string
- here-text
- here-script
---
### 介绍

here document(又称之为here-document、here-text、heredoc、hereis、here-string或here-script)，是shell中的一种特殊重定向方式，用来将输入重定向到一个交互式的shell脚本或程序。格式如下：
```
command << [-]delimiter
    here-document
delimiter
```

here documents始于Unixshell的最通用语法，在<<紧跟一个分割标识符（通常为EOF或END），跟随一堆多行字符，最后一行用分割标识符收尾。

注意：
- 结尾的分割标识符一定要顶格写，前后不能有任何字符，包括空格和tab缩进。
- 开始的分割标识符前后的空格会被省略掉。
- 开始的分割标识符前如果使用-的话，内容部分每行前面的 tab (制表符)将会被删除掉。这种用法是为了编写HereDocument的时候可以将内容部分进行缩进，方便代码阅读。

here strings语法跟here documents类似。格式如下：
```
command <<< word
```

### 实践及测试

#### Here documents简单测试
![*nux中的Here documents和Here strings](/images/2014/1/0026uWfMzy78bgi2ukU58.png)
#### Here documents中变量替换和执行命令测试
通常，Heredocuments中内容会进行变量替换，反勾号中的命令也会执行。可以通过在开始的分割标识符上加单引号禁掉这种行为。
![*nux中的Here documents和Here strings](/images/2014/1/0026uWfMzy78bi9ytjD35.png)
#### Here string简单测试
![*nux中的Here documents和Here strings](/images/2014/1/0026uWfMzy78biimKJ08e.png)
#### 在shell文件中使用Here documents
![*nux中的Here documents和Here strings](/images/2014/1/0026uWfMzy78blVDiD638.png)![*nux中的Here documents和Here strings](/images/2014/1/0026uWfMzy78bmgJWDO24.png)

### 参考

[Here document](https://en.wikipedia.org/wiki/Here_document)    
[Bash Reference Manual - Here Documents](https://www.gnu.org/software/bash/manual/bashref.html#Here-Documents)    
[Bash Reference Manual - Here Strings](https://www.gnu.org/software/bash/manual/bashref.html#Here-Strings)    
[Java 的多行字符串 Here Document 的实现](http://unmi.cc/java-implement-here-document/)    
[](http://stackoverflow.com/questions/2500436/how-does-cat-eof-work-in-bash)    