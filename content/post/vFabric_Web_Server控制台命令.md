---
title: 'vFabric Web Server控制台命令'
date: 2013-10-16 19:28:36
categories: 
- Service+JavaEE
- Web Application Server
tags: 
- vfabric
- apache
- httpd
- webserver
- httpdctl
---
### 检查并设置PowerShell

在Windows中，vFabric WebServer控制台命令需要在PowerShell下执行。默认状态下，PowerShell的脚本处理是被禁止的。
通过如下命令检查当前的PowerShell设置:
```
PS prompt> Get-ExecutionPolicy
```

如果命令返回Restricted,这意味着PowerShell还没有使能。通过执行如下命令使它允许最低限度执行本地脚本：
```
PS prompt> Set-ExecutionPolicy RemoteSigned
```

按照需要设置不同的执行策略并使用组和用户策略使能PowerShell。通常，仅有管理员使用vFabric WebServer脚本，因此RemoteSigned执行策略在大多情况下是足够的。

通过执行如下命令设置编码为UTF-8，以便更好地显示httpctl输出、更容易检查日志文件。
```
PS prompt> chcp 65001
```


### 使用vFabric Web Server控制台

可以使用`httpdctl` 脚本控制vFabric Web Server实例，其命令如下:

|命令|描述
|-----
|start|启动vFabric Web Server实例。如果实例已启动，该命令返回错误。
|stop|强制停止vFabric Web Server实例。当前所有打开的连接将中断。
|gracefulstop|优雅停止vFabric Web Server实例，脚本会等到所有打开的连接关闭后才停止vFabric Web Server实例。
|restart|重启实例。如果实例之前没有启动，脚本会启动实例，此外也会在启动实例前运行configtest。
|graceful|优雅重启实例。与restart命令的区别在于当前打开的连接不会中断，副作用就是老的日志文件不会立即关闭。
|status|显示实例状态信息，例如是否运行中、运行中的进程标识符 (PID)。
|install|安装实例成Windows或UNIX服务。服务可以用Windows服务控制台、sc命令手动启动或停止，或随Windows自动启动或停止。<br>install命令可用参数：<br><ul><li>服务名: vFabrichttpd_实例名_ <br>例子: vFabrichttpdmyserver</li><li>显示名: vFabric httpd _实例名_<br>例子: vFabric httpd myserver</li></ul>Unix下，实例安装成`/etc/init.d`目录下名为`vFabric-httpd-<实例名>`的脚本文件。服务随Unix自动启动或停止。
|uninstall|卸载作为Windows或UNIX服务的实例。Windows下，实例会从服务注册表中删除。Unix下，命令会删除/etc/init.d/vFabric-httpd-_instance-name_脚本文件。
|configtest|对例如conf/httpd.conf之类的配置文件运行语法检查。脚本解析配置文件，如果语法正确返回OK，否则返回特定语法错误的详细信息。

示例如下：
```
PS C:\sas\Config\Lev1\Web\WebServer\bin> .\httpdctl.ps1 status

httpdctl.ps1 - manage the SAS [Config-Lev1] httpd - WebServer  server instance
Copyright c 2012 VMware, Inc. All rights reserved.

SAS [Config-Lev1] httpd - WebServer  (pid 19924) RUNNING
```