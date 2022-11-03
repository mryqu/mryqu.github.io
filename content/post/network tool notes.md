---
title: '网络工具笔记'
date: 2013-06-28 10:02:55
categories: 
- Tool
tags: 
- nslookup
- dig
- host
- dns
- wget
- curl
- postman
---

## nslookup

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

## dig  

dig是域信息搜索器（domain informationgroper）。dig和nslookup作用有些类似，都是DNS查询工具。它与nslookup的区别在于：dig使用操作系统的解析库而nslookup使用自己的一套。Bind开发组已经宣布废弃nslookup，但Unix和Linux系统一般都安装了这两个工具。一些专业的DNS管理员在追查DNS问题时，都乐于使用dig命令，是看中了dig设置灵活、输出清晰、功能强大的特点。

如果Ubuntu下没有dig命令，可通过如下命令安装：
```
sudo apt-get install dnsutils
```

### dig使用说明

![dig笔记](/images/2013/10/0026uWfMgy6Vxm8Isbq54.png)

#### dig选项


<table rules="all" width="100%" summary="" border="0" frame="void" style="margin: 10px; font-size: 12px; border: 1px solid rgb(225, 225, 225); color: rgb(51, 51, 51); font-family: 宋体; line-height: 25px; background: rgb(247, 247, 247);"><tbody valign="top"><tr><td width="16%" style="margin: 0px; padding: 10px; border: none;"><span style="font-weight: bold;">-b address</span></td><td width="83%" style="margin: 0px; padding: 10px; border: none;">设置所要询问地址的源 IP 地址。这必须是主机网络接口上的某一合法的地址。</td></tr><tr><td style="margin: 0px; padding: 10px; border: none;"><span style="font-weight: bold;">-c class</span></td><td style="margin: 0px; padding: 10px; border: none;">缺省查询类（IN forinternet）由选项<span style="font-weight: bold;">-c</span>重设。<span>class</span>可以是任何合法类，比如查询Hesiod记录的HS类或查询CHAOSNET记录的CH 类。</td></tr><tr><td style="margin: 0px; padding: 10px; border: none;"><span style="font-weight: bold;">-f filename</span></td><td style="margin: 0px; padding: 10px; border: none;">使<span style="font-weight: bold;">dig</span>在批处理模式下运行，通过从文件<span>filename</span>读取一系列搜索请求加以处理。文件包含许多查询；每行一个。文件中的每一项都应该以和使用命令行接口对<span style="font-weight: bold;">dig</span>的查询相同的方法来组织。</td></tr><tr><td style="margin: 0px; padding: 10px; border: none;"><span style="font-weight: bold;">-h</span></td><td style="margin: 0px; padding: 10px; border: none;">当使用选项<span style="font-weight: bold;">-h</span>时，显示一个简短的命令行参数和选项摘要。</td></tr><tr><td style="margin: 0px; padding: 10px; border: none;"><span style="font-weight: bold;">-k filename</span></td><td style="margin: 0px; padding: 10px; border: none;">要签署由<span style="font-weight: bold;">dig</span>发送的DNS查询以及对它们使用事务签名（TSIG）的响应，用选项<span style="font-weight: bold;">-k</span>指定TSIG密钥文件。</td></tr><tr><td style="margin: 0px; padding: 10px; border: none;"><span style="font-weight: bold;">-n</span></td><td style="margin: 0px; padding: 10px; border: none;">缺省情况下，使用IP6.ARPA域和RFC2874定义的二进制标号搜索IPv6地址。为了使用更早的、使用IP6.INT域和<span style="font-weight: bold;">nibble</span>标签的RFC1886方法，指定选项<span style="font-weight: bold;">-n</span>（nibble）。</td></tr><tr><td style="margin: 0px; padding: 10px; border: none;"><span style="font-weight: bold;">-p port#</span></td><td style="margin: 0px; padding: 10px; border: none;">如果需要查询一个非标准的端口号，则使用选项<span style="font-weight: bold;">-p</span>。port#是dig将发送其查询的端口号，而不是标准的DNS端口号53。该选项可用于测试已在非标准端口号上配置成侦听查询的域名服务器。</td></tr><tr><td style="margin: 0px; padding: 10px; border: none;"><span style="font-weight: bold;">-t type</span></td><td style="margin: 0px; padding: 10px; border: none;">设置查询类型为<span>type</span>。可以是BIND9支持的任意有效查询类型。缺省查询类型是<span style="font-weight: bold;">A</span>，除非提供<span style="font-weight: bold;">-x</span>选项来指示一个逆向查询。通过指定AXFR的<span>type</span>可以请求一个区域传输。当需要增量区域传输（IXFR）时，<span>type</span>设置为<span style="font-weight: bold;">ixfr=N</span>。增量区域传输将包含自从区域的SOA记录中的序列号改为<span style="font-weight: bold;">N</span>之后对区域所做的更改。</td></tr><tr><td style="margin: 0px; padding: 10px; border: none;"><span style="font-weight: bold;">-x addr</span></td><td style="margin: 0px; padding: 10px; border: none;">逆向查询（将地址映射到名称）可以通过<span style="font-weight: bold;">-x</span>选项加以简化。<span>addr</span>是一个以小数点为界的IPv4地址或冒号为界的IPv6地址。当使用这个选项时，无需提供<span>name</span>、<span>class</span>和<span>type</span>参数。<span style="font-weight: bold;">dig</span>自动运行类似<tt>11.12.13.10.in-addr.arpa</tt>的域名查询，并分别设置查询类型和类为PTR和IN。</td></tr><tr><td style="margin: 0px; padding: 10px; border: none;"><span style="font-weight: bold;">-y name:key</span></td><td style="margin: 0px; padding: 10px; border: none;">您可以通过命令行上的<span style="font-weight: bold;">-y</span>选项指定TSIG密钥；<span>name</span>是TSIG密码的名称，<span>key</span>是实际的密码。密码是64位加密字符串，通常由<span style="font-weight: bold;">dnssec-keygen</span>（8）生成。当在多用户系统上使用选项<span style="font-weight: bold;">-y</span>时应该谨慎，因为密码在ps（1）的输出或shell 的历史文件中可能是可见的。当同时使用<span style="font-weight: bold;">dig</span>和TSCG认证时，被查询的名称服务器需要知道密码和解码规则。在BIND中，通过提供正确的密码和<span style="font-weight: bold;">named.conf</span>中的服务器声明实现。</td></tr></tbody></table>
#### dig的查询选项

dig提供查询选项，它影响搜索方式和结果显示。一些在查询请求报头设置或复位标志位，一部分决定显示哪些回复信息，其它的确定超时和重试战略。每个查询选项被带前缀（+）的关键字标识。一些关键字设置或复位一个选项。通常前缀是求反关键字含义的字符串no。其他关键字分配各选项的值，比如超时时间间隔。它们的格式形如<tt>+keyword=value</tt>。查询选项是：
<dl><dt style="font-weight: bold;">+[no]tcp</dt><dd>查询域名服务器时使用[不使用]TCP。缺省行为是使用 UDP，除非是 AXFR 或 IXFR 请求，才使用 TCP连接。</dd><dt style="font-weight: bold;">+[no]vc</dt><dd>查询名称服务器时使用[不使用]TCP。<tt>+[no]tcp</tt>的备用语法提供了向下兼容。vc代表虚电路。</dd><dt style="font-weight: bold;">+[no]ignore</dt><dd>忽略 UDP 响应的中断，而不是用 TCP 重试。缺省情况运行 TCP 重试。</dd><dt style="font-weight: bold;">+domain=somename</dt><dd>设定包含单个域somename的搜索列表，好像被/etc/resolv.conf中的域伪指令指定，并且启用搜索列表处理，好像给定了<tt>+search</tt>选项。</dd><dt style="font-weight: bold;">+[no]search</dt><dd>使用[不使用]搜索列表或resolv.conf中的域伪指令（如果有的话）定义的搜索列表。缺省情况不使用搜索列表。</dd><dt style="font-weight: bold;">+[no]defname</dt><dd>不建议看作<tt>+[no]search</tt>的同义词。</dd><dt style="font-weight: bold;">+[no]aaonly</dt><dd>该选项不做任何事。它用来提供对设置成未实现解析器标志的dig的旧版本的兼容性。</dd><dt style="font-weight: bold;">+[no]adflag</dt><dd>在查询中设置 [不设置]AD（真实数据）位。目前AD位只在响应中有标准含义，而查询中没有，但是出于完整性考虑在查询中这种性能可以设置。</dd><dt style="font-weight: bold;">+[no]cdflag</dt><dd>在查询中设置 [不设置] CD（检查禁用）位。它请求服务器不运行响应信息的DNSSEC合法性。</dd><dt style="font-weight: bold;">+[no]recursive</dt><dd>切换查询中的 RD（要求递归）位设置。在缺省情况下设置该位，也就是说 dig正常情形下发送递归查询。当使用查询选项<tt>+nssearch</tt>或<tt>+trace</tt>时，递归自动禁用。</dd><dt style="font-weight: bold;">+[no]nssearch</dt><dd>这个选项被设置时，dig试图寻找包含待搜名称的网段的权威域名服务器，并显示网段中每台域名服务器的SOA记录。</dd><dt style="font-weight: bold;">+[no]trace</dt><dd>切换为待查询名称从根名称服务器开始的代理路径跟踪。缺省情况不使用跟踪。一旦启用跟踪，dig使用迭代查询解析待查询名称。它将按照从根服务器的参照，显示来自每台使用解析查询的服务器的应答。</dd><dt style="font-weight: bold;">+[no]cmd</dt><dd>设定在输出中显示指出dig版本及其所用的查询选项的初始注释。缺省情况下显示注释。</dd><dt style="font-weight: bold;">+[no]short</dt><dd>提供简要答复。缺省值是以冗长格式显示答复信息。</dd><dt style="font-weight: bold;">+[no]identify</dt><dd>当启用<tt>+short</tt>选项时，显示[或不显示]提供应答的IP地址和端口号。如果请求简短格式应答，缺省情况不显示提供应答的服务器的源地址和端口号。</dd><dt style="font-weight: bold;">+[no]comments</dt><dd>切换输出中的注释行显示。缺省值是显示注释。</dd><dt style="font-weight: bold;">+[no]stats</dt><dd>该查询选项设定显示统计信息：查询进行时，应答的大小等等。缺省显示查询统计信息。</dd><dt style="font-weight: bold;">+[no]qr</dt><dd>显示 [不显示] 发送的查询请求。缺省不显示。</dd><dt style="font-weight: bold;">+[no]question</dt><dd>当返回应答时，显示 [不显示] 查询请求的问题部分。缺省作为注释显示问题部分。</dd><dt style="font-weight: bold;">+[no]answer</dt><dd>显示 [不显示] 应答的回答部分。缺省显示。</dd><dt style="font-weight: bold;">+[no]authority</dt><dd>显示 [不显示] 应答的权限部分。缺省显示。</dd><dt style="font-weight: bold;">+[no]additional</dt><dd>显示 [不显示] 应答的附加部分。缺省显示。</dd><dt style="font-weight: bold;">+[no]all</dt><dd>设置或清除所有显示标志。</dd><dt style="font-weight: bold;">+time=T</dt><dd>为查询设置超时时间为T秒。缺省是5秒。如果将T设置为小于1的数，则以1秒作为查询超时时间。</dd><dt style="font-weight: bold;">+tries=A</dt><dd>设置向服务器发送 UDP 查询请求的重试次数为A，代替缺省的 3次。如果把A小于或等于 0，则采用 1 为重试次数。</dd><dt style="font-weight: bold;">+ndots=D</dt><dd>出于完全考虑，设置必须出现在名称D的点数。缺省值是使用在/etc/resolv.conf中的ndots语句定义的，或者是 1，如果没有ndots语句的话。带更少点数的名称被解释为相对名称，并通过搜索列表中的域或文件/etc/resolv.conf 中的域伪指令进行搜索。</dd><dt style="font-weight: bold;">+bufsize=B</dt><dd>设置使用 EDNS0 的 UDP消息缓冲区大小为B字节。缓冲区的最大值和最小值分别为65535和0。超出这个范围的值自动舍入到最近的有效值。</dd><dt style="font-weight: bold;">+[no]multiline</dt><dd>以详细的多行格式显示类似SOA的记录，并附带可读注释。缺省值是每单个行上显示一条记录，以便于计算机解析dig的输出。</dd></dl>

全局查询参数（global-d-opt）和（在主机名之前的）服务器影响所有查询。局部查询参数和（在主机名之后的）服务器仅影响当前查询。

### dig使用

```
mryqu> dig

; <<>> DiG 9.6.-ESV-R3 <<>>
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 13319
;; flags: qr rd ra; QUERY: 1, ANSWER: 13, AUTHORITY: 0, ADDITIONAL: 13

;; QUESTION SECTION:
;.                              IN      NS

;; ANSWER SECTION:
.                       391557  IN      NS      l.root-servers.net.
.                       391557  IN      NS      i.root-servers.net.
.                       391557  IN      NS      f.root-servers.net.
.                       391557  IN      NS      m.root-servers.net.
.                       391557  IN      NS      j.root-servers.net.
.                       391557  IN      NS      b.root-servers.net.
.                       391557  IN      NS      e.root-servers.net.
.                       391557  IN      NS      h.root-servers.net.
.                       391557  IN      NS      d.root-servers.net.
.                       391557  IN      NS      g.root-servers.net.
.                       391557  IN      NS      a.root-servers.net.
.                       391557  IN      NS      c.root-servers.net.
.                       391557  IN      NS      k.root-servers.net.

;; ADDITIONAL SECTION:
a.root-servers.net.     477957  IN      A       198.41.0.4
a.root-servers.net.     477957  IN      AAAA    2001:503:ba3e::2:30
b.root-servers.net.     477957  IN      A       192.228.79.201
b.root-servers.net.     477957  IN      AAAA    2001:500:84::b
c.root-servers.net.     477957  IN      A       192.33.4.12
c.root-servers.net.     477957  IN      AAAA    2001:500:2::c
d.root-servers.net.     477957  IN      A       199.7.91.13
d.root-servers.net.     477957  IN      AAAA    2001:500:2d::d
e.root-servers.net.     477957  IN      A       192.203.230.10
f.root-servers.net.     477957  IN      A       192.5.5.241
f.root-servers.net.     477957  IN      AAAA    2001:500:2f::f
g.root-servers.net.     477957  IN      A       192.112.36.4
h.root-servers.net.     477957  IN      A       128.63.2.53

;; Query time: 60 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Sat Oct 12 05:02:23 2013
;; MSG SIZE  rcvd: 496
```

当未指定任何命令行参数或选项时，dig 将对“.”（根）执行 NS 查询。输出为：
- dig程序版本信息
- Got answer显示运行结果信息汇总，包括操作类型、查询及回复统计等等。
- QUESTION SECTION：显示查询请求的内容。
- ANSWER ECTION：查询目标信息。这里是13台根名称服务器的NS记录，对应Gotanswer中的ANSWER:13。后面的数值是相应的TTL值（秒）。
- ADDITIONAL SECTION：附加信息，这里是13台根名称服务器的NS记录对应的A和AAAA记录。
- 最后显示此次查询的操作信息，比如本次查询所用时间、查询服务器地址、当前系统时间、所接收消息的大小。

```
mryqu> dig www.baidu.com

; <<>> DiG 9.6.-ESV-R3 <<>> www.baidu.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 15452
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 5, ADDITIONAL: 0

;; QUESTION SECTION:
;www.baidu.com.                 IN      A

;; ANSWER SECTION:
www.baidu.com.          1200    IN      CNAME   www.a.shifen.com.
www.a.shifen.com.       300     IN      A       103.235.46.39

;; AUTHORITY SECTION:
a.shifen.com.           1200    IN      NS      ns4.a.shifen.com.
a.shifen.com.           1200    IN      NS      ns3.a.shifen.com.
a.shifen.com.           1200    IN      NS      ns1.a.shifen.com.
a.shifen.com.           1200    IN      NS      ns5.a.shifen.com.
a.shifen.com.           1200    IN      NS      ns2.a.shifen.com.

;; Query time: 777 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Sat Oct 12 05:50:10 2013
;; MSG SIZE  rcvd: 164
```

查询百度
```
mryqu> dig @8.8.8.8 www.baidu.com

; <<>> DiG 9.6.-ESV-R3 <<>> @8.8.8.8 www.baidu.com
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 31371
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;www.baidu.com.                 IN      A

;; ANSWER SECTION:
www.baidu.com.          886     IN      CNAME   www.a.shifen.com.
www.a.shifen.com.       264     IN      A       103.235.46.39

;; Query time: 18 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
;; WHEN: Sat Oct 12 05:52:38 2013
;; MSG SIZE  rcvd: 74
```

通过Google的DNS查询百度
```
mryqu> dig www.baidu.com +trace

; <<>> DiG 9.6.-ESV-R3 <<>> www.baidu.com +trace
;; global options: +cmd
.                       44153   IN      NS      c.root-servers.net.
.                       44153   IN      NS      e.root-servers.net.
.                       44153   IN      NS      a.root-servers.net.
.                       44153   IN      NS      l.root-servers.net.
.                       44153   IN      NS      k.root-servers.net.
.                       44153   IN      NS      b.root-servers.net.
.                       44153   IN      NS      d.root-servers.net.
.                       44153   IN      NS      i.root-servers.net.
.                       44153   IN      NS      f.root-servers.net.
.                       44153   IN      NS      m.root-servers.net.
.                       44153   IN      NS      h.root-servers.net.
.                       44153   IN      NS      g.root-servers.net.
.                       44153   IN      NS      j.root-servers.net.
;; Received 496 bytes from 127.0.0.1#53(127.0.0.1) in 20 ms

com.                    172800  IN      NS      l.gtld-servers.net.
com.                    172800  IN      NS      m.gtld-servers.net.
com.                    172800  IN      NS      b.gtld-servers.net.
com.                    172800  IN      NS      c.gtld-servers.net.
com.                    172800  IN      NS      f.gtld-servers.net.
com.                    172800  IN      NS      i.gtld-servers.net.
com.                    172800  IN      NS      k.gtld-servers.net.
com.                    172800  IN      NS      d.gtld-servers.net.
com.                    172800  IN      NS      j.gtld-servers.net.
com.                    172800  IN      NS      e.gtld-servers.net.
com.                    172800  IN      NS      a.gtld-servers.net.
com.                    172800  IN      NS      g.gtld-servers.net.
com.                    172800  IN      NS      h.gtld-servers.net.
;; Received 503 bytes from 192.5.5.241#53(f.root-servers.net) in 76 ms

baidu.com.              172800  IN      NS      dns.baidu.com.
baidu.com.              172800  IN      NS      ns2.baidu.com.
baidu.com.              172800  IN      NS      ns3.baidu.com.
baidu.com.              172800  IN      NS      ns4.baidu.com.
baidu.com.              172800  IN      NS      ns7.baidu.com.
;; Received 201 bytes from 192.33.14.30#53(b.gtld-servers.net) in 106 ms

www.baidu.com.          1200    IN      CNAME   www.a.shifen.com.
a.shifen.com.           1200    IN      NS      ns3.a.shifen.com.
a.shifen.com.           1200    IN      NS      ns2.a.shifen.com.
a.shifen.com.           1200    IN      NS      ns5.a.shifen.com.
a.shifen.com.           1200    IN      NS      ns4.a.shifen.com.
a.shifen.com.           1200    IN      NS      ns1.a.shifen.com.
;; Received 228 bytes from 220.181.38.10#53(ns4.baidu.com) in 327 ms
```

从根名称服务器开始的代理路径跟踪百度域名。

### 参考

[dig.c](http://www.opensource.apple.com/source/bind9/bind9-31/bind9/bin/dig/dig.c)    

## host

host命令是常用的分析域名查询工具，可以用来测试域名系统工作是否正常。

### host参数
![host笔记](/images/2013/10/0026uWfMgy6VBqssppsee.png)

<table rules="all" width="100%" summary="" border="0" frame="void" style="border: 1px solid rgb(225, 225, 225); color: rgb(51, 51, 51);background: rgb(247, 247, 247);"><tbody valign="top"><tr><td>-a</td><td>等价于使用“-v -t ANY”</td></tr><tr><td>-c Class</td><td>当搜索非网际数据时要指定要查找的类。有效类为:<br><table><tbody><tr><td>IN</td><td>网际类</td></tr><tr><td>CHAOS</td><td>Chaos类</td></tr><tr><td>HESIOD</td><td>MIT AlthenaHesiod类</td></tr><tr><td>ANY</td><td>通配符</td></tr></tbody></table></td></tr><tr><td>-C</td><td>在需要认证的域名服务器上查找SOA记录</td></tr><tr><td>-d</td><td>等价于使用“-v”</td></tr><tr><td>-l</td><td>列出一个域内所有的主机</td></tr><tr><td>-i</td><td>反向查找</td></tr><tr><td>-N</td><td>改变点数</td></tr><tr><td>-r</td><td>禁用递归处理。</td></tr><tr><td>-R</td><td>指定UDP包数</td></tr><tr><td>-t Type</td><td>指定要查询的记录类型。常用类型为:<br><table><tbody><tr><td>A</td><td>主机的网际地址</td></tr><tr><td>CNAME</td><td>别名的规范名称</td></tr><tr><td>HINFO</td><td>主机CPU与操作系统类型</td></tr><tr><td>KEY</td><td>安全密钥记录</td></tr><tr><td>MINFO</td><td>邮箱或邮件列表信息</td></tr><tr><td>MX</td><td>邮件交换器</td></tr><tr><td>NS</td><td>指定范围的名称服务器</td></tr><tr><td>PTR</td><td>如果查询的是一个网际地址则为主机名；否则，为其他信息的指针</td></tr><tr><td>SIG</td><td>签名记录</td></tr><tr><td>SOA</td><td>域的"授权开始"信息</td></tr><tr><td>TXT</td><td>文本信息</td></tr><tr><td>UINFO</td><td>用户信息</td></tr><tr><td>WKS</td><td>所支持的众所周知的服务。</td></tr></tbody></table></td></tr><tr><td>-T</td><td>支持TCP/IP模式</td></tr><tr><td>-v</td><td>运行时显示详细的处理信息</td></tr><tr><td>-w</td><td>永远等待DNS服务器的一个回答。</td></tr><tr><td>-W Waite</td><td>指定等待回复的时间</td></tr><tr><td>-4</td><td>用于IPv4的查询</td></tr><tr><td>-6</td><td>用于IPv6的查询</td></tr><tr><td>-m</td><td>设置内存调试标志</td></tr></tbody></table>

### host使用
![host笔记](/images/2013/10/0026uWfMgy6VBqswP1Q7e.png)  

## Wget

GNU Wget是一个命令行的下载工具，支持HTTP、HTTPS、FTP协议，支持断点续传。在宽带状态不佳的情况下，Wget能表现出很强的稳定性。

### 常用命令速查表

|操作|命令|
|-----|-----|
|下载文件|wget URL|
|恢复下载|wget -c URL|
|递归下载|以最大深度10级递归下载某链接：wget -r -l 10 URL|
|下载整个网站|wget -m URL-m等同于-r -N -l inf --no-remove-listing|
|下载某个页面特定类型文件|仅下载pdf和mp3文件：wget -A "*.pdf,*.mp3" -r -l 1 -nd –np URL|
|下载某个页面特定类型之外的其他文件|下载pdf以外的文件：wget -R.pdf -r -l 1 -nd –np URL|
|忽略 robots.txt|wget -e robots=off URL|
|限制下载速率|wget –-limit-rate=20 URL|
|模拟firefox下载|wget -U Mozilla URL|
|不下载仅检查链接是否存在|wget --spider --force-html -i bookmarks.html|
|将输出写入文件|wget -O filepath URL|
|下载FTP文件|wget --ftp-­use­r=yqu--ftp-­pas­swo­rd=yqu URL|
|下载多个连接|wget URL1 URL2 URL3|
|配置接收数据的限额大小|对单文件下载无效，对递归下载或从输入文件获取连接下载有效wget -Q2m -i URL当下载量超过限额后下载中断|

### 启动选项：

`-V, --version` 显示 Wget 的版本并且退出。  
`-h, --help` 打印此帮助。  
`-b, -background` 启动后进入后台操作。  
`-e, -execute=COMMAND` 运行‘.wgetrc’形式的命令。  

### 日志记录及输入文件选项：

`-o, --output-file=文件` 将日志消息写入到指定文件中。  
`-a, --append-output=文件` 将日志消息追加到指定文件的末端。  
`-d, --debug` 打印调试输出。  
`-q, --quiet` 安静模式(不输出信息)。  
`-v, --verbose` 详细输出模式(默认)。  
`-nv, --non-verbose` 关闭详细输出模式，但不进入安静模式。  
`-i, --input-file=文件` 下载从指定文件中找到的 URL。  
`-F, --force-html` 以HTML方式处理输入文件。  
`-B, --base=URL` 使用 -F -i 文件选项时，在相对链接前添加指定的 URL 。  

### 下载选项：

`-t, --tries=次数` 配置重试次数（0 表示无限）。  
`--retry-connrefused` 即使拒绝连接也重试。  
`-O --output-document=文件` 将数据写入此文件中。  
`-nc, --no-clobber` 不更改已经存在的文件，也不使用在文件名后添加 .#（# 为数字）的方法写入新的文件。  
`-c, --continue` 继续接收已下载了一部分的文件。  
`--progress=方式` 选择下载进度的表示方式。  
`-N, --timestamping` 除非远程文件较新，否则不再取回。  
`-S, --server-response` 显示服务器回应消息。  
`--spider` 不下载任何数据。  
`-T, --timeout=秒数` 配置读取数据的超时时间 (秒数)。  
`-w, --wait=秒数` 接收不同文件之间等待的秒数。  
`--waitretry=秒数` 在每次重试之间稍等一段时间 (由 1 秒至指定的 秒数 不等)。  
`--random-wait` 接收不同文件之间稍等一段时间(由 0 秒至 2*WAIT 秒不等)。  
`-Y, --proxy=on/off` 打开或关闭代理服务器。  
`-Q, --quota=大小` 配置接收数据的限额大小。  
`--bind-address=地址` 使用本机的指定地址 (主机名称或 IP) 进行连接。  
`--limit-rate=速率` 限制下载的速率。  
`--dns-cache=off` 禁止查找存于高速缓存中的 DNS。  
`--restrict-file-names=OS` 限制文件名中的字符为指定的 OS (操作系统) 所允许 的字符。  

### 目录选项：

`-nd --no-directories` 不创建目录。  
`-x, --force-directories` 强制创建目录。  
`-nH, --no-host-directories` 不创建含有远程主机名称的目录。  
`-P, --directory-prefix=名称` 保存文件前先创建指定名称的目录。  
`--cut-dirs=数目` 忽略远程目录中指定数目的目录层。  

### HTTP 选项：

`--http-user=用户` 配置 http 用户名。  
`--http-passwd=密码` 配置 http 用户密码。  
`-C, --cache=on/off` (不)使用服务器中的高速缓存中的数据 (默认是使用的)。  
`-E, --html-extension` 将所有 MIME 类型为 text/html 的文件都加上 .html 扩 展文件名。  
`--ignore-length` 忽略“Content-Length”文件头字段。  
`--header=字符串` 在文件头中添加指定字符串。  
`--proxy-user=用户` 配置代理服务器用户名。  
`--proxy-passwd=密码` 配置代理服务器用户密码。  
`--referer=URL` 在 HTTP 请求中包含“Referer：URL”头。  
`-s, --save-headers` 将 HTTP 头存入文件。  
`-U, --user-agent=AGENT` 标志为 AGENT 而不是 Wget/VERSION。  
`--no-http-keep-alive` 禁用 HTTP keep-alive（持久性连接）。  
`--cookies=off` 禁用 cookie。  
`--load-cookies=文件` 会话开始前由指定文件载入 cookie。  
`--save-cookies=文件` 会话结束后将 cookie 保存至指定文件。  
`--post-data=字符串` 使用 POST 方法，发送指定字符串。  
`--post-file=文件` 使用 POST 方法，发送指定文件中的内容。  

### HTTPS (SSL) 选项：

`--sslcertfile=文件` 可选的客户段端证书。  
`--sslcertkey=密钥文件` 对此证书可选的“密钥文件”。  
`--egd-file=文件` EGD socket 文件名。  
`--sslcadir=目录` CA 散列表所在的目录。  
`--sslcafile=文件` 包含 CA 的文件。  
`--sslcerttype=0/1` Client-Cert 类型 0=PEM (默认) / 1=ASN1 (DER)  
`--sslcheckcert=0/1` 根据提供的 CA 检查服务器的证书  
`--sslprotocol=0-3` 选择 SSL 协议；0=自动选择，1=SSLv2， 2=SSLv3， 3=TLSv1  

### FTP 选项：

`-nr, --dont-remove-listing` 不删除“.listing”文件。  
`-g, --glob=on/off` 设置是否展开有通配符的文件名。  
`--passive-ftp` 使用“被动”传输模式。  
`--retr-symlinks` 在递归模式中，下载链接所指示的文件(连至目录则例外）。  

### 递归下载选项：

`-r, --recursive` 递归下载。  
`-l, --level=数字` 最大递归深度(inf 或 0 表示无限)。  
`--delete-after` 删除下载后的文件。  
`-k, --convert-links` 将绝对链接转换为相对链接。  
`-K, --backup-converted` 转换文件 X 前先将其备份为 X.orig。  
`-m, --mirror` 等效于 -r -N -l inf -nr 的选项。  
`-p, --page-requisites` 下载所有显示完整网页所需的文件，例如图像。  
`--strict-comments` 打开对 HTML 备注的严格(SGML)处理选项。  

### 递归下载时有关接受/拒绝的选项：

`-A, --accept=列表` 接受的文件样式列表，以逗号分隔。  
`-R, --reject=列表` 排除的文件样式列表，以逗号分隔。  
`-D, --domains=列表` 接受的域列表，以逗号分隔。  
`--exclude-domains=列表` 排除的域列表，以逗号分隔。  
`--follow-ftp` 跟随 HTML 文件中的 FTP 链接。  
`--follow-tags=列表` 要跟随的 HTML 标记，以逗号分隔。  
`-G, --ignore-tags=列表` 要忽略的 HTML 标记，以逗号分隔。  
`-H, --span-hosts` 递归时可进入其它主机。  
`-L, --relative` 只跟随相对链接。  
`-I, --include-directories=列表` 要下载的目录列表。  
`-X, --exclude-directories=列表` 要排除的目录列表。  
`-np, --no-parent` 不搜索上层目录。  

### 参考

[Wget Manual](http://www.gnu.org/software/wget/manual/wget.html)  

## cURL

**cURL**是一个利用URL语法在命令行下工作的文件传输工具，1997年首次发行。它支持文件上传和下载，所以是综合传输工具，但按传统，习惯称cURL为下载工具。cURL还包含了用于程序开发的libcurl。  
cURL支持的通訊协议有FTP、FTPS、HTTP、HTTPS、TFTP、SFTP、Gopher、SCP、Telnet、DICT、FILE、LDAP、LDAPS、IMAP、POP3、SMTP和RTSP。  

<div width="100%" border="0" cellspacing="0" cellpadding="0" valign="top" style="margin: 0px; line-height: 21.7600002288818px; width: 650px;"><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">请求多个资源</h3><div style="border-top-color: rgb(25, 25, 25); margin: 0px; border-top-width: 3px; border-top-style: solid; border-right-color: rgb(25, 25, 25); border-bottom-color: rgb(25, 25, 25); border-left-color: rgb(25, 25, 25); background-color: rgb(215, 215, 215);">curl http://api.test.com/pp/[123-321]<br>curl http://api.test.com/pp/{abc,def,ghi}/status</div><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">允许重定向</h3><div style="border-top-color: rgb(25, 25, 25); margin: 0px; border-top-width: 3px; border-top-style: solid; border-right-color: rgb(25, 25, 25); border-bottom-color: rgb(25, 25, 25); border-left-color: rgb(25, 25, 25); background-color: rgb(215, 215, 215);">-L</div><div style="border-top-color: rgb(25, 25, 25); margin: 0px; border-top-width: 3px; border-top-style: solid; border-right-color: rgb(25, 25, 25); border-bottom-color: rgb(25, 25, 25); border-left-color: rgb(25, 25, 25); background-color: rgb(215, 215, 215);">如果服务器返回3XX响应，使用-L选项可以让curl向新新地址发送请求。</div><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">Cookies</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-b --cookie {name=data}</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">发送原始Cookies或文件中的Cookies<br>范例：-b 'n1=v1; n2=v2'</div></td></tr><tr><td><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-c / --cookie-jar {file name}</div></td><td colspan="2"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">将Cookies存入文件</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">发送数据</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-d / --data {data}</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-d {data} 发送原始数据<br>-d {@<em>filename</em>} 发送文件中的数据。<br>如果不想对@进行解析，可以使用--data-raw。<br><br>JSON范例：<br>-d '{"firstName":"yd", "lastName":"q"}'<br>原始数据范例：<br>-d 'name=yqu' -d 'sex=male'</div></td></tr><tr><td><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">--data-ascii {data}</div></td><td><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">等同于--data</div><br></td></tr><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">--data-raw {data}</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">几乎等同于--data，除了不对@进行解析。</div></td></tr><tr><td><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">--data-binary {data}</div></td><td><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">--data-binary {data} 发送原始二进制数据<br>--data-binary {@<em>filename</em>} 发送文件中的二进制数据。<br>在发送前对数据不做任何处理。</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">发送表单</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-F / --form {name=content}</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">以Content-Type: multipart/form-data方式发送数据<br>范例：<br>curl -F password=@/etc/passwd www.mypasswords.com</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">允许"不安全"SSL</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215); width:160px"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-k / --insecure</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">所有的SSL连接使用默认安装的CA证书捆绑试图保障其安全。除非使用-k/--insecure，否则所有被认为是“不安全”的连接将会失败。</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">认证</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-u / --user {user:password}</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">服务器认证</div><br></td></tr><tr><td><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-U / --proxy-user {user:password}</div></td><td><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">代理认证</div><br></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">代理</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td colspan="1" style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-x / --proxy</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">HTTP方法</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-X / --request {request}</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">可以指定的方法为：POST、HEAD、PUT、GET、DELETE</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">输出至文件</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td colspan="1" style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-o / --output {file}</div></td><td colspan="1" style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">输出到文件而不是标准输出</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">输出至与远端文件同名的本地文件</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-O / --remote-name</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">上传文件</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215); width: 220px"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-T / --upload-file {file}</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">curl -T "{file1,file2}" http://www.test.com<br>curl -T "img[1-10].png" ftp://ftp.test.com/img/</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">最大操作时间</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td colspan="1" style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-m / --max-time {seconds}</div></td><td colspan="1" style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">该选项可以防止批量操作由于网络太慢或链路中断而被挂起几个小时。</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">连接超时值</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">--connect-timeout {seconds}</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">连接允许的最长时间</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">定制输出格式</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-w / --write-out {format}</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">范例：<br>curl -w "%{remote_ip} %{time_total} %{http_code}\n" \<br>-s -L -o /dev/null www.test.com</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">定制请求头部</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-H / --header {header}</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">范例：<br>curl -X PUT \<br>-H 'Content-Type: application/json' \<br>-H 'Authorization: OAuth 2c3455d1aeffc' \<br>-d @example.json</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">用户代理</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td colspan="1" style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-A / --user-agent {agent string}</div></td><td colspan="1" style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-A "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36"</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">显示响应头部</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-i / --include</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">使用此选项可以使输出除了内容之外还包含头部</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">HEAD请求</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-I / --head</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">发送HEAD请求，响应将不包含内容而仅有头部</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">详细输出模式</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-v / --verbose</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">用于检查头部元素<br>以&gt;开头表示curl发送的头部和数据<br>以&lt;开头表示curl接受的头部和数据<br>以*开头表示curl提供的额外信息</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">安静模式</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td colspan="1" style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-s / --silent</div></td><td colspan="1" style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">仅显示所要数据，不显示进步条或错误消息。</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">显示错误</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">-S / --show-error</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">当使用-s时，该选项使curl显示错误消息。<br>不使-s时，该选项无意义。</div></td></tr></tbody></table><h3 style="padding: 6px 8px; margin: 0px; color: rgb(215, 215, 215); background-color: rgb(25,25,25);">退出代码</h3><table style="page-break-inside: avoid; border-collapse: collapse; margin: 0px; padding: 0px;" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">6</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">无法解析主机</div></td></tr><tr><td><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">7</div></td><td><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">连接主机失败</div></td></tr><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">28</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">操作超时</div></td></tr><tr><td><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">55</div></td><td><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">发送数据失败</div></td></tr><tr style="background-color: rgb(240, 242, 230);"><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">56</div></td><td style="background-color: rgb(215, 215, 215);"><div style="padding: 3px 8px; border-color: rgb(25, 25, 25);">接收数据失败</div></td></tr></tbody></table></div>

### 参考

[cURL Man Page](http://curl.haxx.se/docs/manpage.html)    
[curl cheat-sheet](http://www.cheatography.com/ankushagarwal11/cheat-sheets/curl-cheat-sheet/)    
[](https://github.com/tedyoung/curl-api-cheat-sheet/blob/master/cheat-sheet.md)    
[](http://www.lornajane.net/posts/2008/curl-cheat-sheet)    
[](http://blog.engelke.com/2009/10/20/curl-cheat-sheet/)    
[](http://www.niclas-meier.de/2011/12/the-curl-cheat-sheet-to-myself/)    
[](http://www.cantoni.org/2012/01/10/curl-cheat-sheet)    
[](http://g33kinfo.com/info/archives/4872)    
[](http://wenku.baidu.com/view/e02c69f4f61fb7360b4c65e9.html)    

## Postman

以前用过cURL和rest-shell进行RESTAPI测试，最近偶然看到了Postman。Postman是一款Chrome插件，强大、便利，可以在浏览器里直接测试RESTAPI。

### 安装

在Chrome浏览器里进入[Postman插件安装地址](https://chrome.google.com/webstore/detail/postman-rest-client/fdmmgilgnpjigdojojpjoooidkmcomcm) 即可安装Postman。
![Postman使用笔记](/images/2015/9/0026uWfMgy6Vs7MGFN1d3.jpg)

### 使用

Postman可以模拟各种Http请求，并且可以额外设置特殊的URL参数、Http头以及Basic Auth、DigestAuth、OAuth 1.0等认证信息。在展现Http响应上，Postman支持完美打印，JSON、XML或是HTML都会整理成人类阅读的格式，有助于我们更清楚地查看响应内容。![Postman使用笔记](/images/2015/9/0026uWfMgy6VtgqXkfXb5.jpg)![Postman使用笔记](/images/2015/9/0026uWfMgy6Vti0NGNTb5.jpg)

### 特色功能

- **更多的Http方法**：Postman除了支持GET、POST、PUT、PATCH、DELETE、HEAD、OPTIONS这些常用Http方法，还支持COPY、LINK、UNLINK、PURGE。
- **集合（Collection）功能**：Postman可以管理Http请求的集合，在做完单个测试时，可以将该请求存入特定集合内。这样在后继的重复测试，无需重新输入Http请求，就可以快速测试并获得结果。集合支持输入或导出，便于团队共享。
- **设置环境变量（Environment）**：Postman可以管理环境变量。一般我们有可能有多种环境：development、staging或local，每种环境下的请求URL有可能各不相同。通过环境变量，在切换环境测试时无需重写Http请求。

### 参考

[Postman插件安装地址](https://chrome.google.com/webstore/detail/postman-rest-client/fdmmgilgnpjigdojojpjoooidkmcomcm)  
[Github：postmanlabs](https://github.com/postmanlabs/)  
[Postman官方博客](http://blog.getpostman.com/)  
[HTTP Link and Unlink Methods](http://tools.ietf.org/id/draft-snell-link-method-01.html)  