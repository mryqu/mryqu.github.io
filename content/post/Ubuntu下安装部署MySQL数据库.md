---
title: 'Ubuntu下安装部署MySQL数据库'
date: 2013-10-11 21:52:52
categories: 
- DB/NoSQL
tags: 
- ubuntu
- linux
- mysql
- database
- install
---
### 安装MySQL

[mysql-server](http://packages.ubuntu.com/search?keywords=mysql-server)是MySQL数据库服务器，必选安装。[mysql-client](http://packages.ubuntu.com/search?keywords=mysql-client)是MySQL数据库客户端，提供对MySQL服务器的查询工具及备份/恢复数据工具；[libmysqlclient-dev](http://packages.ubuntu.com/search?keywords=libmysqlclient-dev)是MySQL的C语言开发接口，libmysql-java是MySQL的JDBC驱动，按需安装。
```
sudo apt-get update
sudo apt-get install mysql-server
sudo apt-get isntall mysql-client
sudo apt-get install libmysqlclient-dev
sudo apt-get install libmysql-java
```

查看是否安装成功:
```
sudo netstat -tap | grep mysql
```

查看上述软件包所提供的文件:
```
dpkg -L mysql-server
dpkg -L mysql-client
dpkg -L libmysqlclient-dev
```

通过上述命令检查之后，如果看到有MySQL的socket处于LISTEN状态则表示安装成功。

### MySQL服务操作

查看状态
- 使用service查看状态：`sudo service mysql status`
- 使用mysql脚本查看状态：`/etc/inint.d/mysql status`
- 使用mysqladmin查看状态：`mysqladmin -u root -p status`

启动
- 使用service启动：`sudo service mysql start`
- 使用mysql脚本启动：`/etc/inint.d/mysql start`
- 使用mysqld_safe启动：`mysqld_safe&`

停止
- 使用service停止：`sudo service mysql stop`
- 使用mysql脚本停止：`/etc/inint.d/mysql stop`
- 使用mysqladmin停止：`mysqladmin -u root -p shutdown`

重启
- 使用service重启：`sudo service mysql restart`
- 使用mysql脚本重启：`/etc/inint.d/mysql restart`

### 去除禁止远程访问限制

编辑/etc/mysql/my.cnf，注释掉bind-address：
```
#bind-address           = 127.0.0.1
```

在mysql数据库中通过selecthost,user from user;命令进行查询，如出现%则说明允许使用该用户远程访问此MySQL服务器。
![Ubuntu下安装部署MySQL数据库](/images/2013/10/0026uWfMzy77pDqbcVG50.png)
如果对特定用户没有远程访问权限，可以执行`grantall privileges on *.* to 'yourUserName'@'%' identified by'yourUserPwd' with grant option;`。

### 修改MySQL root密码

方法1： 用SET PASSWORD命令
```
mysql -u root
mysql> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpass');
```

方法2：用mysqladmin
```
mysqladmin -u root password "newpass"
mysqladmin -u root -p password "newpass"    #root已有密码
```

方法3： 用UPDATE直接编辑user表
```
mysql -u root
mysql> use mysql;
mysql> UPDATE user SET Password = PASSWORD('newpass') WHERE user = 'root';
mysql> FLUSH PRIVILEGES;
```

忘记已设root密码
```
mysqld_safe --skip-grant-tables&
mysql -u root mysql
mysql> UPDATE user SET password=PASSWORD("new password") WHERE user='root';
mysql> FLUSH PRIVILEGES;
```

### 其他操作

查看数据库:
```
show databases;
```

查看当前字符集:
```
show variables like 'character%';
```