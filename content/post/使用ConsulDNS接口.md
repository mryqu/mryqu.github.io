---
title: '使用Consul DNS接口'
date: 2018-06-21 06:08:53
categories: 
- Tool
- Consul
tags: 
- consul
- dns
---

[Consul](https://www.consul.io/)提供了两个查询接口：[HTTP](https://www.consul.io/api/index.html)和[DNS](https://www.consul.io/docs/agent/dns.html)。DNS接口允许应用程序在没有与consul高度集成的情况下使用服务发现。
以下面这个小Consul集群为例：
```
root@consul:/# /usr/bin/consul members
Node           Address          Status  Type    Build  Protocol  DC
configuration  172.17.0.7:8301  alive   client  X.Y.Z  2         dc1
consul         172.17.0.2:8301  alive   server  X.Y.Z  2         dc1
httpd          172.17.0.4:8301  alive   client  X.Y.Z  2         dc1
logon          172.17.0.8:8301  alive   client  X.Y.Z  2         dc1
postgres       172.17.0.3:8301  alive   client  X.Y.Z  2         dc1
rabbitmq       172.17.0.6:8301  alive   client  X.Y.Z  2         dc1
```
![Consul Web UI](/images/2018/06/consul_ui_forDNS.jpg)

可以通过DNS接口以`<dnode>.node[.datacenter].<domain>`的形式查询节点地址，也可以`[tag.]<dservice>.service[.datacenter].<domain>`的形式查询服务地址。
```
root@httpd:/# dig @127.0.0.1 -p53 postgres.node.consul ANY

; <<>> DiG 9.9.5-9-Debian <<>> @127.0.0.1 -p53 postgres.node.consul ANY
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 57064
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;postgres.node.consul.          IN      ANY

;; ANSWER SECTION:
postgres.node.consul.   0       IN      A       172.17.0.3

;; Query time: 0 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Wed Jun 20 03:00:29 UTC 2018
;; MSG SIZE  rcvd: 65

root@httpd:/# dig @127.0.0.1 -p53 rabbitmq.service.consul SRV

; <<>> DiG 9.9.5-9-Debian <<>> @127.0.0.1 rabbitmq.service.consul SRV
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 45919
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 2

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;rabbitmq.service.consul.       IN      SRV

;; ANSWER SECTION:
rabbitmq.service.consul. 0      IN      SRV     1 1 5672 rabbitmq.node.dc1.consul.

;; ADDITIONAL SECTION:
rabbitmq.node.dc1.consul. 0     IN      A       172.17.0.6

;; Query time: 0 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Wed Jun 20 05:03:19 UTC 2018
;; MSG SIZE  rcvd: 112
root@httpd:/# exit
exit
vagrant$ dig @172.17.0.2 -p53 httpd.node.consul ANY

; <<>> DiG 9.9.5-3ubuntu0.8-Ubuntu <<>> @172.17.0.2 -p53 httpd.node.consul ANY
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 48389
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;httpd.node.consul.             IN      ANY

;; ANSWER SECTION:
httpd.node.consul.      0       IN      A       172.17.0.4

;; Query time: 0 msec
;; SERVER: 172.17.0.2#53(172.17.0.2)
;; WHEN: Wed Jun 20 03:04:15 UTC 2018
;; MSG SIZE  rcvd: 68
```
Consul的DNS接口默认端口为8600，这里已通过Consul配置改为53。
```
{
  "data_dir": "/opt/XXX/config/srv/consul",
  "ports": {
    "dns": 53
  },
  "leave_on_terminate": true
}
```
默认情况下，Consul仅对.consul域提供DNS查询服务，不支持进一步的DNS递归。可以增加上游DNS服务器已进行非Consul查询：
```
{
  "data_dir": "/opt/XXX/config/srv/consul",
  "ports": {
    "dns": 53
  },
  "recursors": ["AAA.BBB.CCC.DDD"],
  "leave_on_terminate": true
}
```
测试结果：
```
vagrant$ dig @172.17.0.2 -p53 www.sina.com.cn ANY

; <<>> DiG 9.9.5-3ubuntu0.8-Ubuntu <<>> @172.17.0.2 -p53 www.sina.com.cn ANY
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 25127
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 13, ADDITIONAL: 27

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.sina.com.cn.               IN      ANY

;; ANSWER SECTION:
www.sina.com.cn.        2270    IN      CNAME   spool.grid.sinaedge.com.

;; AUTHORITY SECTION:
.                       109385  IN      NS      i.root-servers.net.
.                       109385  IN      NS      k.root-servers.net.
.                       109385  IN      NS      c.root-servers.net.
.                       109385  IN      NS      m.root-servers.net.
.                       109385  IN      NS      l.root-servers.net.
.                       109385  IN      NS      d.root-servers.net.
.                       109385  IN      NS      g.root-servers.net.
.                       109385  IN      NS      a.root-servers.net.
.                       109385  IN      NS      b.root-servers.net.
.                       109385  IN      NS      j.root-servers.net.
.                       109385  IN      NS      h.root-servers.net.
.                       109385  IN      NS      e.root-servers.net.
.                       109385  IN      NS      f.root-servers.net.

;; ADDITIONAL SECTION:
a.root-servers.net.     395644  IN      A       198.41.0.4
b.root-servers.net.     395644  IN      A       199.9.14.201
c.root-servers.net.     395644  IN      A       192.33.4.12
d.root-servers.net.     395644  IN      A       199.7.91.13
e.root-servers.net.     395644  IN      A       192.203.230.10
f.root-servers.net.     395644  IN      A       192.5.5.241
g.root-servers.net.     395644  IN      A       192.112.36.4
h.root-servers.net.     395644  IN      A       198.97.190.53
i.root-servers.net.     395644  IN      A       192.36.148.17
j.root-servers.net.     395644  IN      A       192.58.128.30
k.root-servers.net.     395644  IN      A       193.0.14.129
l.root-servers.net.     395644  IN      A       199.7.83.42
m.root-servers.net.     395644  IN      A       202.12.27.33
a.root-servers.net.     395644  IN      AAAA    2001:503:ba3e::2:30
b.root-servers.net.     395644  IN      AAAA    2001:500:200::b
c.root-servers.net.     395644  IN      AAAA    2001:500:2::c
d.root-servers.net.     395644  IN      AAAA    2001:500:2d::d
e.root-servers.net.     395644  IN      AAAA    2001:500:a8::e
f.root-servers.net.     395644  IN      AAAA    2001:500:2f::f
g.root-servers.net.     395644  IN      AAAA    2001:500:12::d0d
h.root-servers.net.     395644  IN      AAAA    2001:500:1::53
i.root-servers.net.     395644  IN      AAAA    2001:7fe::53
j.root-servers.net.     395644  IN      AAAA    2001:503:c27::2:30
k.root-servers.net.     395644  IN      AAAA    2001:7fd::1
l.root-servers.net.     395644  IN      AAAA    2001:500:9f::42
m.root-servers.net.     395644  IN      AAAA    2001:dc3::35

;; Query time: 259 msec
;; SERVER: 172.17.0.2#53(172.17.0.2)
;; WHEN: Wed Jun 20 04:58:55 UTC 2018
;; MSG SIZE  rcvd: 1539
```

### 参考

[Consul DNS Interface](https://www.consul.io/docs/agent/dns.html)  
[Consul Configuration](https://www.consul.io/docs/agent/options.html)  
[【Consul】Consul实践指导-DNS接口](https://blog.csdn.net/younger_china/article/details/52264525)  