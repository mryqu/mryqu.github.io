---
title: 'kitematic代理设置'
date: 2015-09-16 06:09:37
categories: 
- Tool
- Docker
tags: 
- ketematic
- proxy
- vpn
- docker
- devops
---
在DockerToolbox目录下创建一个批处理脚本文件kitematic_proxy.cmd，插入下面代码，将"YOUR_PROXY"替换为所用的代理（http://host:port）。
```
set proxy=YOUR_PROXY
SET HTTP_PROXY=%proxy%
SET HTTPS_PROXY=%proxy%
for /f %%i in ('docker-machine.exe ip default') do set DOCKER_HOST=%%i
SET NO_PROXY=%DOCKER_HOST%
set DOCKER_HOST=tcp://%DOCKER_HOST%:2376
cd Kitematic
Kitematic.exe
```

### 参考

[kitematic Proxy/VPN error reports #1031](https://github.com/docker/kitematic/issues/1031)  