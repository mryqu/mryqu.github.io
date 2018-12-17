---
title: 'DockerUI实践'
date: 2015-06-10 06:08:47
categories: 
- Tool
- Docker
tags: 
- dockerui
- docker
- boot2docker
- 远程api
- devops
---
DockerUI是Docker远程API的Web接口,它是由下列技术栈构成的纯客户端，因此很容易连接和管理Docker。
- [Angular.js](https://github.com/angular/angular.js)
- [Bootstrap](http://getbootstrap.com/)
- [Gritter](https://github.com/jboesch/Gritter)
- [Spin.js](https://github.com/fgnass/spin.js/)
- [Golang](https://golang.org/)
- [Vis.js](http://visjs.org/)

### 运行DockerUI容器

![DockerUI实践](/images/2015/6/0026uWfMgy6TauTfkKlc1.jpg)

### 配置boot2docker与宿主机之间的端口转移

![DockerUI实践](/images/2015/6/0026uWfMgy6TbhZG2xXe1.png)
![DockerUI实践](/images/2015/6/0026uWfMgy6TauTMujd4f.jpg)
另一种方式是在启动容器之前执行：
```
boot2docker ssh -L 9000:localhost:9000
```

### 查看DockerUI

![DockerUI实践](/images/2015/6/0026uWfMgy6TauUhq8Jbd.jpg)![DockerUI实践](/images/2015/6/0026uWfMgy6TauUxjcG16.jpg)![DockerUI实践](/images/2015/6/0026uWfMgy6TauUSLkuc2.jpg)![DockerUI实践](/images/2015/6/0026uWfMgy6TauVfYPAc6.jpg)

### 直接使用Docker远程API

![DockerUI实践](/images/2015/6/0026uWfMgy6TauVrAuT03.jpg)

### 参考

[GitHub：crosbymichael/dockerui](https://github.com/crosbymichael/dockerui)  
[Docker Remote API](https://docs.docker.com/reference/api/docker_remote_api/)  