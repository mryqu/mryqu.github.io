---
title: 'Remote debugging on microservice at docker container inside vagrant box'
date: 2015-10-05 05:59:07
categories: 
- Tool
- Docker
tags: 
- remote
- debug
- microservice
- docker
- vagrant
---
### Docker compose configuration
```
foo-service:
    image: foo-service:latest
    hostname: foo-service
    dns: 127.0.0.1
    restart: always
    
```

### Vagrant configuration
```
config.vm.network "forwarded_port", guest: 8787, host: 8787, auto_correct: true
```

### Consul configuration
```
curl -X PUT -H 'application/json' -d 'java_option_server_port:java_option_xms:java_option_xmx:java_option_debug' http://localhost:8500/v1/kv/config/foo-service/jvm/java_options

curl -X PUT -H 'application/json' -d '-Xdebug -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=n' http://localhost:8500/v1/kv/config/foo-service/jvm/java_option_debug
```

### IntelliJ IDEA configuration
![Remote debugging on microservice at docker container inside vagrant box](/images/2015/10/0026uWfMgy6X9oeyhgQe8.jpg)![Remote debugging on microservice at docker container inside vagrant box](/images/2015/10/0026uWfMgy6X9oeLAD42e.jpg)![Remote debugging on microservice at docker container inside vagrant box](/images/2015/10/0026uWfMgy6X9of7fa323.jpg)