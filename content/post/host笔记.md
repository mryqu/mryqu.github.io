---
title: 'host笔记'
date: 2013-10-19 23:45:53
categories: 
- Tool
- NetWork
tags: 
- dns
- host
---
host命令是常用的分析域名查询工具，可以用来测试域名系统工作是否正常。

### host参数
![host笔记](/images/2013/10/0026uWfMgy6VBqssppsee.png)

<table rules="all" width="100%" summary="" border="0" frame="void" style="border: 1px solid rgb(225, 225, 225); color: rgb(51, 51, 51);background: rgb(247, 247, 247);"><tbody valign="top"><tr><td>-a</td><td>等价于使用“-v -t ANY”</td></tr><tr><td>-c Class</td><td>当搜索非网际数据时要指定要查找的类。有效类为:<br><table><tbody><tr><td>IN</td><td>网际类</td></tr><tr><td>CHAOS</td><td>Chaos类</td></tr><tr><td>HESIOD</td><td>MIT AlthenaHesiod类</td></tr><tr><td>ANY</td><td>通配符</td></tr></tbody></table></td></tr><tr><td>-C</td><td>在需要认证的域名服务器上查找SOA记录</td></tr><tr><td>-d</td><td>等价于使用“-v”</td></tr><tr><td>-l</td><td>列出一个域内所有的主机</td></tr><tr><td>-i</td><td>反向查找</td></tr><tr><td>-N</td><td>改变点数</td></tr><tr><td>-r</td><td>禁用递归处理。</td></tr><tr><td>-R</td><td>指定UDP包数</td></tr><tr><td>-t Type</td><td>指定要查询的记录类型。常用类型为:<br><table><tbody><tr><td>A</td><td>主机的网际地址</td></tr><tr><td>CNAME</td><td>别名的规范名称</td></tr><tr><td>HINFO</td><td>主机CPU与操作系统类型</td></tr><tr><td>KEY</td><td>安全密钥记录</td></tr><tr><td>MINFO</td><td>邮箱或邮件列表信息</td></tr><tr><td>MX</td><td>邮件交换器</td></tr><tr><td>NS</td><td>指定范围的名称服务器</td></tr><tr><td>PTR</td><td>如果查询的是一个网际地址则为主机名；否则，为其他信息的指针</td></tr><tr><td>SIG</td><td>签名记录</td></tr><tr><td>SOA</td><td>域的"授权开始"信息</td></tr><tr><td>TXT</td><td>文本信息</td></tr><tr><td>UINFO</td><td>用户信息</td></tr><tr><td>WKS</td><td>所支持的众所周知的服务。</td></tr></tbody></table></td></tr><tr><td>-T</td><td>支持TCP/IP模式</td></tr><tr><td>-v</td><td>运行时显示详细的处理信息</td></tr><tr><td>-w</td><td>永远等待DNS服务器的一个回答。</td></tr><tr><td>-W Waite</td><td>指定等待回复的时间</td></tr><tr><td>-4</td><td>用于IPv4的查询</td></tr><tr><td>-6</td><td>用于IPv6的查询</td></tr><tr><td>-m</td><td>设置内存调试标志</td></tr></tbody></table>

### host使用
![host笔记](/images/2013/10/0026uWfMgy6VBqswP1Q7e.png)