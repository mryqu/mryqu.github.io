---
title: "遭遇\"HTTPS endpoint unresponsive and insecure mode isn't enabled.\""
date: 2015-09-29 05:38:23
categories: 
- Tool
- Docker
tags: 
- docker-compose
- pull
- dockerexception
- https
- unresponsive
---
今天使用docker-compose去获取最新的镜像，遭遇"HTTPS endpoint unresponsive andinsecure mode isn't enabled."错误。
```
mryqu$ docker-compose pull
Pulling cadvisor (docker.mryqu.com/google/cadvisor:latest)...
Traceback (most recent call last):
  File "<string>", line 3, in <module>
  File "/code/build/docker-compose/out00-PYZ.pyz/compose.cli.main", line 32, in main
  File "/code/build/docker-compose/out00-PYZ.pyz/compose.cli.docopt_command", line 21, in sys_dispatch
  File "/code/build/docker-compose/out00-PYZ.pyz/compose.cli.command", line 34, in dispatch
  File "/code/build/docker-compose/out00-PYZ.pyz/compose.cli.docopt_command", line 24, in dispatch
  File "/code/build/docker-compose/out00-PYZ.pyz/compose.cli.command", line 66, in perform_command
  File "/code/build/docker-compose/out00-PYZ.pyz/compose.cli.main", line 235, in pull
  File "/code/build/docker-compose/out00-PYZ.pyz/compose.project", line 285, in pull
  File "/code/build/docker-compose/out00-PYZ.pyz/compose.service", line 713, in pull
  File "/code/build/docker-compose/out00-PYZ.pyz/docker.client", line 590, in pull
  File "/code/build/docker-compose/out00-PYZ.pyz/docker.auth.auth", line 60, in resolve_repository_name
  File "/code/build/docker-compose/out00-PYZ.pyz/docker.auth.auth", line 39, in expand_registry_url
docker.errors.DockerException: HTTPS endpoint unresponsive and insecure mode isn't enabled.
```

解决方法：
```
docker-compose pull --allow-insecure-ssl
```