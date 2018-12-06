---
title: 'vFabric Web Server配置：多tc Server负载均衡'
date: 2013-10-16 22:03:02
categories: 
- Service及JavaEE
- Web Application Server
tags: 
- vfabric
- webserver
- loadbalance
- tcserver
- mod_proxy
---
HTTP请求需要分发到tc Server集群成员。为了实现这一目的，可以采用硬件负载均衡硬件或软件(Apache HTTP Server、vFabric Web Server和Microsoft IIS)。本文介绍用vFabric Web Server的mod_proxy模块实现tcServer负载均衡。

# vFabric Web Server:加载mod_proxy动态共享对象

在httpsd.conf文件对下列行进行添加或去除注释: 
```
LoadModule proxy_module     "VFWS-INSTALL/httpd-2.2/modules/mod_proxy.so"

LoadModule proxy_http_module   "VFWS-INSTALL/httpd-2.2/modules/mod_proxy_http.so"

LoadModule proxy_balancer_module "VFWS-INSTALL/httpd-2.2/modules/mod_proxy_balancer.so"
```

# vFabric Web Server:创建额外的配置文件

在vFabric Web Server实例的conf目录创建mod_proxy.conf: 
```
# Enable capturing of proxy statistics
ProxyStatus on
  SetHandler balancer-manager
  Order Deny,Allow
  Deny from all
  Allow from 127.0.0.1

# These apps aren't clustered -- requests go to dedicated server
ProxyPass /my-app1 balancer://my-standalone/my-app1
ProxyPass /my-app2 balancer://my-standalone/my-app2

# Clustered apps get directed to loadbalanced worker
ProxyPass /my-app3 balancer://my-balancer/my-app3
ProxyPass /my-app4 balancer://my-balancer/my-app4

# Standalone "balancer" for standalone apps that aren't clustered
 BalancerMember http://MYSERVER1:8080

# Load balanced "balancer" for clustered apps
 BalancerMember http://MYSERVER1:8080 route=aGVsbG8gcWUh_MyServer1_1 loadfactor=1
 BalancerMember http://MYSERVER1:8180 route=aGVsbG8gcWUh_MyServer1_2 loadfactor=2
 ProxySet lbmethod=byrequests stickysession=aGVsbG8gcWUh_Cluster1|aGVsbG8gcWUh_cluster1

# Configure cache timeouts for static content
AddType text/javascript .js

# Configure browser cache timeouts for static content
ExpiresActive On
ExpiresByType image/gif "access plus 1 hour" 
ExpiresByType text/javascript "access plus 1 hour"
ExpiresByType image/x-icon "access plus 1 hour" 
ExpiresByType text/css "access plus 1 hour"
```

# tc Server:设置Engine的jvmRoute

对两个tc Server下的两个tc Server实例的Server进行配置，文件为:
```
/MyServer1_1/conf/server.xml
/MyServer1_2/conf/server.xml	
```