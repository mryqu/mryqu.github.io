---
title: '[Hive] 遇到Relative path in absolute URI:${system:java.io.tmpdir}/${system:user.name}'
date: 2015-07-25 07:33:55
categories: 
- BigData
tags: 
- hive
- java.io.tmpdir
- systemuser.name
- relativepath
- absoluteuri
---
安装问Hive，启动一下CLI试一下效果。结果直接崩了，错误提示：Relative path in absolute URI:${system:java.io.tmpdir}/${system:user.name}。
![issue](/images/2015/7/0026uWfMzy76Vr11nOC86.jpg)
[ Hive AdminManual Configuration](https://cwiki.apache.org/confluence/display/Hive/AdminManual+Configuration)里面的例子是将hive.exec.scratchdir设定为/tmp/mydir。即使按照示例来配置，还是会报hive.downloaded.resources.dir属性错误。后来看到网上有人说主要是Hadoop路径不支持带":"，所以会报错。

解决方法：
- hive.exec.local.scratchdir: /tmp/${user.name}
- hive.downloaded.resources.dir: /tmp/${user.name}_resources

![solution](/images/2015/7/0026uWfMzy76VPiNahAe2.png)
可以登入Hive Shell了！
![login hive shell](/images/2015/7/0026uWfMzy76VPBJNOtc5.jpg)