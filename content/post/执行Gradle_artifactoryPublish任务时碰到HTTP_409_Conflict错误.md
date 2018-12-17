---
title: '执行Gradle artifactoryPublish任务时碰到HTTP 409 Conflict错误'
date: 2015-07-13 06:10:00
categories: 
- Tool
- Gradle
tags: 
- gradle
- artifactorypublish
- 409
- conflict
- snapshot/release
---
这篇博文算是[《尝试Artifactory》](/post/尝试artifactory)的姐妹篇。我打算将[《尝试Artifactory》](/post/尝试artifactory)中的'libs-snapshot-local'和'libs-snapshot'换成'libs-release-local'和'libs-release'，以便将我的构件发布到发布版仓库里。结果遭遇如下错误：
```
C:\test123\HelloArtifactory>gradlew artifactoryPublish
[buildinfo] Not using buildInfo properties file for this build.
:generatePomFileForMavenJavaPublication
:compileJava 
```

查看Artifactory日志，才知道根本原因在于创建的是SNAPSHOT而libs-release-local只处理发布版构建。The repository 'libs-release-local' rejected the artifact'libs-release-local:com/yqu/HelloArtifactory/0.1.0-SNAPSHOT/HelloArtifactory-0.1.0-SNAPSHOT.jar'due to its snapshot/release handling policy。
![执行Gradle artifactoryPublish任务时碰到HTTP 409 Conflict错误](/images/2015/7/0026uWfMzy74kaLfEId8d.jpg)
解决方案有如下两种：
- 修改libs-release-local属性，勾选Handle Snapshots选择框（工作流不正规啦）
  ![执行Gradle artifactoryPublish任务时碰到HTTP 409 Conflict错误](/images/2015/7/0026uWfMzy74kbeZkGv33.jpg)
- 将gradle.properties中的version由0.1.0-SNAPSHOT改成0.1.0即可