---
title: 'Debian软件包管理速查表：dpkg、apt-get、apt-cache'
date: 2013-10-18 19:54:39
categories: 
- Tool
- Linux
tags: 
- dpkg
- apt-get
- apt-cache
- aptitude
- synaptic
---
dpkg是Debian系统底层包管理器，apt-get是高层包管理工具，apt-cache是高层包查询工具。

### dpkg速查表

dpkg是Debian Linux用于安装/管理单个软件包的命令行工具：

<table border="1" cellpadding="0" cellspacing="0" bordercolor="#60834A" width="100%" style="font-family: arial, helvetica, sans-serif; border-collapse: collapse; background-color: rgb(255, 255, 255);"><tbody><tr align="center"><th width="33%"><b>语法</b></th><th width="33%"><b>描述</b></th><th width="34%"><b>示例</b></th></tr><tr><td>dpkg -i {.deb package}</td><td>安装软件包</td><td>dpkg -i zip_2.31-3_i386.deb</td></tr><tr><td>dpkg -i {.deb package}</td><td>安装新的软件包。如果软件包已安装则尝试更新到最新版本</td><td>dpkg -i zip_2.31-3_i386.deb</td></tr><tr><td>dpkg -R {Directory-name}</td><td>递归地安装目录下所有软件包</td><td>dpkg -R /tmp/downloads</td></tr><tr><td>dpkg -r {package}</td><td>移除一个已安装的软件包，保留配置文件</td><td>dpkg -r zip</td></tr><tr><td>dpkg -P {package}</td><td>移除一个已安装的软件包及配置</td><td>dpkg -P apache-perl</td></tr>
<tr><td>dpkg -l</td><td>列举所有安装的软件包、及包版本和简短描述</td><td><pre style="margin:0; padding:0; white-space: pre-wrap; word-wrap: break-word;">dpkg -l
dokg -l | less
dpkg -l '*apache*'
dpkg -l | grep -i 'sudo'</pre></td></tr><tr><td>dpkg -l {package}</td><td>列举单个安装的软件包、及包版本和简短描述</td><td>dpkg -l apache-perl</td></tr><tr><td>dpkg -L {package}</td><td>找出安装的软件包所提供的文件，例如列出安装的文件</td><td><pre style="margin:0; padding:0; white-space: pre-wrap; word-wrap: break-word;">dpkg -L apache-perl
dpkg -L perl</pre></td></tr><tr><td>dpkg -c {.Deb package}</td><td>列出软件包所提供的文件，例如deb包文件内的所有文件，这对找出将要安装什么文件非常有帮助</td><td>dpkg -c dc_1.06-19_i386.deb</td></tr><tr><td>dpkg -S {/path/to/file}</td><td>找出拥有该文件的包，例如找出该文件归属的包</td><td>dpkg -S /bin/netstat<br>dpkg -S /sbin/ippool</td></tr><tr><td>dpkg -p {package}</td><td>显示包的详细信息，包组、版本、维护者、架构、依赖包、描述等</td><td>dpkg -p lsof</td></tr><tr><td>dpkg -s {package} | grep Status</td><td>找出Debian包是否安装(状态)</td><td>dpkg -s lsof | grep Status</td></tr></tbody></table>

### apt-get速查表

apt-get是Debian Linux用于管理软件包的命令行工具：

- 安装/管理单个软件包
- 升级软件包
- 打安全补丁
- 使Debian系统更新到最新状态
- 下载源.deb文件
- 前端有很多GUI和应用

|语法|描述|示例
|---
|apt-get install {package}|安装新的软件包。如果软件包已安装则尝试更新到最新版本|apt-get install zipapt-get install lsof samba mysql-client
|apt-get remove {package}|移除一个已安装的软件包，保留配置文件|apt-get remove zip
|apt-get --purge remove {package}|移除一个已安装的软件包及配置|apt-get --purge remove mysql-server
|apt-get updateapt-get upgrade|重新同步包索引文件并升级Debian Linux系统及安全更新 (需要访问因特网)|apt-get updateapt-get upgrade
|apt-get updateapt-get dist-upgrade|经常用于升级Debian分发。例如Woody升级到Sarge，'dist-upgrade'除了执行升级功能，也只能处理包新版本改变了的依赖关系；apt-get具有"智能"冲突解决系统，在必要时会试图以重要性较小的包为代价升级最重要的包。|apt-get updateapt-get dist-upgrade

### apt-cache速查表

|语法|描述|示例
|---
|apt-cache pkgnames|列举所有有效包|
|apt-cache depends {package}|检查包的依赖|apt-cache depends lsofapt-cache depends mysql-server
|apt-cache search {progname}|通过关键字搜索包列表|apt-cache search mysqlapt-cache search "Network Security"
|apt-cache show {package}|显示包的信息|apt-cache show screen

此外，也可以使用下列GUI工具：
- aptitude：Debian GNU/Linux包系统基于文本的界面接口。![Debian软件包管理速查表：dpkg、apt-get、apt-cache](/images/2013/10/0026uWfMgy6VWKqNWlv75.jpg)
- synaptic：APT的前端基于图形的界面接口。![Debian软件包管理速查表：dpkg、apt-get、apt-cache](/images/2013/10/0026uWfMgy6VWKs2ggh21.jpg)

### 参考

[dpkg Man Page](http://manpages.debian.org/cgi-bin/man.cgi?query=dpkg)  
[apt-get Man Page](http://manpages.debian.org/cgi-bin/man.cgi?query=apt-get)  
[apt-cache Man Page](http://manpages.debian.org/cgi-bin/man.cgi?query=apt-cache)  
[aptitude Man Page](http://manpages.debian.org/cgi-bin/man.cgi?query=aptitude)  
[synaptic Man Page](http://manpages.debian.org/cgi-bin/man.cgi?query=synaptic)  
[dpkg command cheat sheet for Debian Linux](http://www.cyberciti.biz/howto/question/linux/dpkg-cheat-sheet.php)  
[apt-get command cheat sheet for Debian Linux](http://www.cyberciti.biz/howto/question/linux/apt-get-cheat-sheet.php)  
[Jon's Apt-Get Cheat Sheet](http://www.oxer.com.au/cheatsheet/apt)  
[Ubuntu Cheat Sheet - Package Management](https://mhvlug.org/sites/default/files/Advanced_ubuntu_sheet.pdf)  
[](http://blog.packagecloud.io/eng/2015/03/30/apt-cheat-sheet/)  