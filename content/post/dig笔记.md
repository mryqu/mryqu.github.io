---
title: 'dig笔记'
date: 2013-10-12 19:51:58
categories: 
- Tool
- NetWork
tags: 
- dig
- dns
---
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