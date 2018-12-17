---
title: 'Eclipse中解决远程调试超时的设置'
date: 2012-09-07 20:55:16
categories: 
- Tool
- Eclipse
tags: 
- eclipse
- remote
- debug
- timeout
- tomcat
---
主要是加大调试器超时和启动超时设置
![eclipse中解决远程调试超时的设置](/images/2012/9/72ef7beatc91c21c7aa72.jpg)


#### Tomcat设置
catalina.bat中添加如下：
```
:doStart
shift
if "%TITLE%" == "" set TITLE=Tomcat
set _EXECJAVA=start "%TITLE%" %_RUNJAVA%
set CATALINA_OPTS=-Xdebug -Xrunjdwp:transport=dt_socket,address=5558,server=y,suspend=n
if not ""%1"" == ""-security"" goto execCmd
shift
echo Using Security Manager
set "SECURITY_POLICY_FILE=%CTALINA_BASE%\conf\catalina.policy"
goto execCmd
```
#### Eclipse设置
![eclipse中解决远程调试超时的设置](/images/2012/9/0026uWfMgy6OL4XLAk4e4.png)