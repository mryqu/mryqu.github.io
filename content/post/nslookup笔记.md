---
title: 'nslookup笔记'
date: 2013-06-28 10:02:55
categories: 
- Tool
- NetWork
tags: 
- nslookup
- dns
---
nslookup命令是用来查询因特网域名服务器的。该命令在Unix、Linux和Windows平台都有提供。如果在Linux平台上找不到nslookup命令，检查是否安装bind-utils。

### nslookup的使用模式

nslookup有两种模式：交互式和非交互式。
- 交互式模式允许向域名服务器查询各种主机、域名或打印域内主机列表。
- 非交互式模式用于查询一个主机或域的信息。

```
C:\>nslookup /?
Usage:
   nslookup [-opt ...]             # interactive mode using default server
   nslookup [-opt ...] - server    # interactive mode using 'server'
   nslookup [-opt ...] host        # just look up 'host' using default server
   nslookup [-opt ...] host server # just look up 'host' using 'server'
```

制定了查询对象就进入非交互式模式，否则进入交互模式。示例如下：![nslookup笔记](/images/2013/6/0026uWfMgy6VwLbBzkLbb.png) 这两次查询百度的命令区别在于：第一次使用了默认DNS，第二次指定了Google的DNS。返回结果是非权威答案，即从上连DNS服务器的本地缓存中读取出的值，而非实际去查询到的值。

### nslookup选项

![nslookup笔记](/images/2013/6/0026uWfMgy6VwMiZ5cdc1.jpg)
- **set all**：列出nslookup工具的常用选项的当前设置值。
- **set class=[value]**：可以更改查询类
   ```
   IN：Internet类（默认）
   CH：Chaos类
   HS：Hesiod类
   ANY：通配
   ```
   Chaos和Hesiod现在几乎无人使用。
- **set [no]debug**：可以用来设置是否进入调试模式。如果setdebug，则会进入到调试模式，查询过程中会显示完整的响应包以及其中的交互包。
- **set[no]d2**：开启了高级调试模式，会输出很多nslookup内部工作的信息，包括了许多函数调用信息。
- **set domain=[name]**：用于设置默认的域。
- **set [no]search**：使用域搜索列表。
- **setport=[value]**：众所周知，DNS默认的服务端口是53。当某些特殊情况，此端口改变时，可以通过本命令来设置。
- **set type=[value]**：也可以写成setquerytype=[value]，用于更改信息查询类型。默认情况下，nslookup是查询域名所对应的A记录，而如果你想查询其对应的MX记录等信息时，就需要专门设置type值了。目前常用的type值如下：
   ```
   A：查看主机的IPv4地址
   AAAA：查看主机的IPv6地址
   ANY：查看关于主机域的所有信息
   CNAME：查找与别名对应的正式名字
   ISDN：域名对应的ISDN号码
    
   HINFO：查找主机的CPU与操作系统类型
   MB：存放指定邮箱的服务器
    
   MG：邮件组记录 
   MINFO：查找邮箱信息
   MR：改名的邮箱记录
   MX：查找邮件交换信息
   NS：查找主机域的域名服务器
   PTR：查找与给定IP地址匹配的主机名
   RP：查找域负责人记录
   RT：路由穿透记录
    
   SOA：查找域内的SOA地址
   SRV：TCP服务器信息记录
    
   TXT：域名对应的文本信息
    
   UINFO：查找用户信息
    
   X25：域名对应的X.25地址记录
   ```
- **retry=[number]**：可以用来设置查询重试的次数。
- **timeout=[number]**：可以用来设置每次查询的超时时限。示例如下：
   ```
   nslookup -type=MX -debug www.baidu.com 8.8.8.8
   ```

### DNS知识

#### 什么叫DNS？

域名管理系统DNS（Domain Name System）是域名解析服务器的意思.它在互联网的作用是：把域名转换成网络可以识别的ip地址，在通过IP地址访问主机。比如：我们上网时输入的www.baidu.com会自动转换成为220.181.112.244。

#### 什么是A记录？

A记录是用来指定主机名（或域名）对应的IP地址记录。用户可以将该域名下的网站服务器指向到自己的web server上。同时也可以设置您域名的二级域名。

#### 什么是NS记录？

NS（Name Server）记录是域名服务器记录，用来指定该域名由哪个DNS服务器来进行解析。

#### 什么是别名记录(CNAME)？

也被称为规范名字。这种记录允许您将多个名字映射到同一台计算机。通常用于同时提供WWW和MAIL服务的计算机。例如，有一台计算机名为“host.domain.com”（A记录）。它同时提供WWW和MAIL服务，为了便于用户访问服务。可以为该计算机设置两个别名（CNAME）：WWW和MAIL。这两个别名的全称就是“www.domain.com”和“mail.domain.com”。实际上他们都指向“host.domain.com”。

#### 什么是泛域名解析？

泛域名解析定义为：用户的域名aaa.com，之下所设的*.aaa.com全部解析到同一个IP地址上去。比如客户设mail.aaa.com就会自已自动解析到与aaa.com同一个IP地址上去。

#### DNS查询的大致步骤

- 首先，客户端提出域名解析请求（无论以何种形式或方法），并将该请求发或转发给本地的DNS服务器。
- 接着，本地DNS服务器收到请求后就去查询自己的缓存，如果有该条记录，则会将查询的结果返回给客户端。（也就是我们看到的““非权威性”的应答”）。请注意，下面就开始递归查询了：反之，如果DNS服务器本地没有搜索到相应的记录，则会把请求转发到根DNS（13台根DNS服务器的IP信息默认均存储在DNS服务器中，当需要时就会去有选择性的连接）。
- 然后，根DNS服务器收到请求后会判断这个域名是谁来授权管理，并会返回一个负责该域名子域的DNS服务器地址。比如，查询news.baidu.com的IP，根DNS服务器就会在负责.com顶级域名的DNS服务器中选一个（并非随机，而是根据空间、地址、管辖区域等条件进行筛选），返回给本地DNS服务器。可以说根域对顶级域名有绝对管理权，自然也知道他们的全部信息，因为在DNS系统中，上一级对下一级有管理权限，毫无疑问，根DNS是最高一级了。
- 本地DNS服务器收到这个地址后，就开始联系对方并将此请求发给他。负责.com域名的某台服务器收到此请求后，如果自己无法解析，就会返回一个管理.com的下一级的DNS服务器地址给本地DNS服务器，也就是负责管理baidu.com的DNS。
- 当本地DNS服务器收到这个地址后，就会重复上面的动作，继续往下联系。
- 不断重复这样的轮回过程，直到有一台DNS服务器可以顺利解析出这个地址为止。在这个过程中，客户端一直处理等待状态，他不需要做任何事，也做不了什么。
- 直到本地DNS服务器获得IP时，才会把这个IP返回给客户端，到此在本地的DNS服务器取得IP地址后，递归查询就算完成了。本地DNS服务器同时会将这条记录写入自己的缓存，以备后用。到此，整个解析过程完成。客户端拿到这个地址后，就可以顺利往下进行了。但假设客户端请求的域名根本不存在，解析自然不成功，DNS服务器会返回此域名不可达，在客户端的体现就是网页无法浏览或网络程序无法连接等等。