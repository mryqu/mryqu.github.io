---
title: 'Vagrant运行Docker的几种方法'
date: 2015-06-15 06:15:31
categories: 
- Tool
- Vagrant
tags: 
- vagrant
- docker
- shell
- compose
- devops
---
### Vagrant的docker provisioner能够自动安装Docker、下载Docker容器、随着`vagrant up`命令自动运行容器。

#### Vagrantfile
```
Vagrant.configure("2") do |config|
 config.vm.provision "docker" do |d|
   d.pull_images "consul"
   d.run "consul"
   d.pull_images "rabbitmq"
   d.run "rabbitmq"
 end
end
```

### 仅使用Vagrant的docker provisioner安装Docker，使用脚本下载并运行Docker容器

#### Vagrantfile
```
# Install Docker
config.vm.provision "docker"

# Download Docker images, create and start containers
config.vm.provision :shell, :path => "runMyDockers.sh"
```
#### runMyDockers.sh
```
#!/bin/bash

docker rm -f consul 2>/dev/null
docker create --hostname consul --name consul -v /data/consul1:/data --dns 127.0.0.1 --restart always -p 8500:8500 --env CONSUL_OPTIONS=-bootstrap consul:dev
docker start consul
docker rm -f rabbitmq 2>/dev/null
docker create --name rabbitmq --hostname rabbitmq -p 5672:5672 -v /data/rabbitmq:/data --dns 127.0.0.1 --restart always --link consul:consul rabbitmq:dev
docker start rabbitmq
```

### 仅使用Vagrant的docker provisioner安装Docker，使用[Docker Compose](https://docs.docker.com/compose/)下载并运行Docker容器。

[Docker Compose](https://docs.docker.com/compose/)是一个定义和运行Docker复杂程序的工具。使用[Compose](https://docs.docker.com/compose/)，可以在一个文件内定义多容器应用程序，并有控制所有/单个容器启动停止的相应命令。
Compose有一整套命令来对应用的整个生命周期进行管理：
- 启动、停止和重构建服务
- 查看运行服务的状态
- 将运行服务的日志输出整理成数据流。
- 对一个服务运行一次性指令

#### Vagrantfile
```
# Install Docker
config.vm.provision "docker"

# Install Docker compose
config.vm.provision "shell", inline: <<-END
  set -x
  sudo curl -L https://github.com/docker/compose/releases/download/1.3.0rc1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  sudo curl -L https://raw.githubusercontent.com/docker/compose/1.3.0rc1/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
END

# Launch docker-compose to pull Docker images, create and start containers
config.vm.provision "shell", inline: <<-END
  set -x
  cd /vagrant
  docker-compose up -d --allow-insecure-ssl
END
```

#### docker-compose.yml
```
consul:
  image: consul:dev
  hostname: consul
  dns: 127.0.0.1
  restart: always
  ports: 
   - "8500:8500"    
  volumes:
   - /data/consul:/data
  environment:
   - CONSUL_OPTIONS=-bootstrap

rabbitmq:
  image: rabbitmq:dev
  hostname: rabbitmq
  dns: 127.0.0.1
  restart: always
  ports:
   - "5672:5672"
  volumes:
   - /data/rabbitmq:/data
  links:
   - consul:consul
```

### 参考

[Vagrant: Docker provisioner](http://docs.vagrantup.com/v2/provisioning/docker.html)  
[Docker Compose](https://docs.docker.com/compose/)  