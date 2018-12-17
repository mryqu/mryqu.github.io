---
title: '[Gradle] 执行Java类'
date: 2015-04-15 18:32:08
categories: 
- Tool
- Gradle
tags: 
- gradle
- java
- class
- execute
- run
---
### 需求

我想用Gradle脚本执行下列Java类Hello123.java：

```
import java.util.Arrays;

public class Hello123 {
  public static void main(String[] args) {
    System.out.println("args:"+ Arrays.toString(args));
  }
}
```

### 测试一：创建execute任务

#### build.gralde
```
apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'

task execute(type: {
   main = System.getProperty("exec.mainClass")
   classpath = sourceSets.main.runtimeClasspath
   
   systemProperties System.getProperties()

   if(System.getProperty("exec.args"))
     args System.getProperty("exec.args").split()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8
```

#### 测试结果

![[Gradle] 执行Java类](/images/2015/4/0026uWfMzy74N43HzcT43.jpg)

### 测试二：重写run任务

#### build.gralde
```
apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'
apply plugin: "application"

mainClassName = "NonExistentClass"

task run (type: {
   main = System.getProperty("exec.mainClass")
   classpath = sourceSets.main.runtimeClasspath
   
   systemProperties System.getProperties()

   if(System.getProperty("exec.args"))
     args System.getProperty("exec.args").split()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8
```

#### 测试结果

![[Gradle] 执行Java类](/images/2015/4/0026uWfMzy74N4CaesJfd.jpg)

### 参考

[Gradle to execute Java class (without modifying build.gradle)](http://stackoverflow.com/questions/21358466/gradle-to-execute-java-class-without-modifying-build-gradle)    
[What is the gradle equivalent of maven's exec plugin for running Java apps?](http://stackoverflow.com/questions/16350757/what-is-the-gradle-equivalent-of-mavens-exec-plugin-for-running-java-apps)    
[gradle task pass arguments to java application](http://stackoverflow.com/questions/27604283/gradle-task-pass-arguments-to-java-application)    
[Problems passing system properties and parameters when running Java class via Gradle](http://stackoverflow.com/questions/23689054/problems-passing-system-properties-and-parameters-when-running-java-class-via-gr)    
[](https://docs.gradle.org/current/userguide/application_plugin.html)    