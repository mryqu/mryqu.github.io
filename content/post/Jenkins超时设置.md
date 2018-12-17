---
title: 'Jenkins超时设置'
date: 2015-04-21 05:15:55
categories: 
- Tool
tags: 
- jenkins
- build
- abort
- timeout
- configure
---
Jenkins在构建部署镜像时发生超时：
```
Build timed out (after 10 minutes). Marking the build as aborted.
Build was aborted
Finished: ABORTED

```

解决方法是在Jenkins当前项目下点击Configure菜单后，在BuildEnvironment配置项里修改超时策略。我把超时绝对值改大点就好了。
![Jenkins超时设置](/images/2015/4/0026uWfMgy6XiFwsWjj95.jpg)