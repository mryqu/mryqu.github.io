---
title: '在Ubuntu中禁掉IPv6'
date: 2015-03-20 08:38:13
categories: 
- Tool
- Linux
tags: 
- ubuntu
- ipv6
- disable
---
为了禁止掉IPv6，需要在/etc/sysctl.conf做如下修改：
```
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
```

如果IPv6仍没有禁掉，是由于sysctl.conf没有激活造成的。为了解决上述问题，执行下面的命令：
```
sudo sysctl -p
```

之后，运行:
```
$ cat /proc/sys/net/ipv6/conf/all/disable_ipv6
```

它将返回1，这表示IPv6被成功禁止掉。
![在Ubuntu中禁掉IPv6](/images/2015/3/0026uWfMzy77TWiBwcr7b.png)