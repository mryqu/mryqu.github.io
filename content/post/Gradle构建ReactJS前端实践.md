---
title: 'Gradle构建ReactJS前端实践'
date: 2020-04-25 12:01:23
categories: 
- 前端
tags: 
- gradle
- npm
- webpack

---

### [frontend-maven-plugin](https://github.com/eirslett/frontend-maven-plugin)使用介绍

Spring指南里面有个示例[React.js and Spring Data REST](https://spring.io/guides/tutorials/react-and-spring-data-rest/)，技术架构为：  
* 后端采用Spring Data Rest  
* 前端采用React.js  
* 构建工具为Maven  

下面看一下其pom.xml构建前端的片段:  
```
<plugin>
	<groupId>com.github.eirslett</groupId>
	<artifactId>frontend-maven-plugin</artifactId>
	<version>1.6</version>
	<configuration>
		<installDirectory>target</installDirectory>
	</configuration>
	<executions>
		<execution>
			<id>install node and npm</id>
			<goals>
				<goal>install-node-and-npm</goal>
			</goals>
			<configuration>
				<nodeVersion>v10.11.0</nodeVersion>
				<npmVersion>6.4.1</npmVersion>
			</configuration>
		</execution>
		<execution>
			<id>npm install</id>
			<goals>
				<goal>npm</goal>
			</goals>
			<configuration>
				<arguments>install</arguments>
			</configuration>
		</execution>
		<execution>
			<id>webpack build</id>
			<goals>
				<goal>webpack</goal>
			</goals>
		</execution>
	</executions>
</plugin>
```

[frontend-maven-plugin](https://github.com/eirslett/frontend-maven-plugin)用于构建JavaScript部分：  
* install-node-and-npm命令将安装node.js及其包管理工具npm到target目录。 （这确保这些二进制文件不在源代码控制范围内并且能被clean命令清除）。   
* npm命令将执行使用参数install的npm二进制文件，它会安装定义在package.json内的模块。  
* webpack命令将执行webpack二进制文件，它会基于webpack.config.js编译所有JavaScript代码。  

这些步骤依次运行，完成安装node.js、下载JavaScript模块、构建JS部分。  

### 备选Gradle前端构建插件

[frontend-maven-plugin](https://github.com/eirslett/frontend-maven-plugin)是专用于Maven的插件，在Gradle上并没有直接对应的插件。  
我查找后，重点考察了下面两个插件：  
* [Frontend Gradle plugin](https://github.com/Siouan/frontend-gradle-plugin)  
* [Gradle Plugin for Node](https://github.com/srs/gradle-node-plugin)  


### [Frontend Gradle plugin](https://github.com/Siouan/frontend-gradle-plugin)实践

#### 代码修改

package.json稍作修改，在scripts里面添加build命令：  
```
  "scripts": {
    "build": "webpack --config webpack.config.js -d",
    "watch": "webpack --watch -d"
  }
```

build.gradle:  
```
plugins {
    id 'application'
    id 'org.siouan.frontend' version '2.0.0'
}

apply plugin: 'org.siouan.frontend'

frontend {
    // [OPTIONAL] Node version, used to build the URL to download the corresponding distribution, if the
    // 'nodeDistributionUrl' property is not set. By default, this property is 'null'
    nodeVersion = '10.15.3'

    // [OPTIONAL] Install directory where the distribution archive shall be exploded.
    nodeInstallDirectory = file("${project.buildDir}/nodejs")

    ////// SCRIPT SETTINGS //////
    // Name of NPM/Yarn scripts (see 'package.json' file) that shall be executed depending on this
    // plugin task. The values below are passed as arguments of the 'npm' or 'yarn' executables.
    // Under Linux-like O/S, white space characters ' ' in an argument value must be escaped with a
    // backslash character '\'. Under Windows O/S, the whole argument must be enclosed between
    // double-quotes. Example: assembleScript = 'run assemble single\ argument'

    assembleScript = 'run build'

    ////// GENERAL SETTINGS //////
    // [OPTIONAL] Location of the directory containing the 'package.json' file. By default, this
    // file is considered to be located in the project's directory, at the same level than this
    // 'build.gradle[.kts]' file. If the 'package.json' file is located in another directory, it is
    // recommended either to set up a Gradle multi-project build, or to set this property with the
    // appropriate directory. This directory being used as the working directory when running JS
    // scripts, consequently, the 'node_modules' directory would be created at this location after
    // the 'installFrontend' task is executed.

    // [OPTIONAL] Whether messages logged by the plugin in Gradle with INFO level shall be visible
    // whatever the active Gradle logging level is. This property allows to track the plugin
    // execution without activating Gradle INFO or DEBUG levels that may be too much verbose on a
    // global point of view. The plugin also logs some messages at lower levels, (e.g. debugging
    // data). The visibility of these messages does not depend on this property.
    verboseModeEnabled = true
}

clean.delete << file('node_modules')
clean.delete << file('src/main/resources/static/built')
```

#### 操作

查看构建需要执行的任务：  
```
C:\ws\HelloSpringDataRestReactjs>gradle -m build
:HelloSpringDataRestReactjs:installNode SKIPPED
:HelloSpringDataRestReactjs:installYarn SKIPPED
:HelloSpringDataRestReactjs:installFrontend SKIPPED
:HelloSpringDataRestReactjs:assembleFrontend SKIPPED
:HelloSpringDataRestReactjs:compileJava SKIPPED
:HelloSpringDataRestReactjs:processResources SKIPPED
:HelloSpringDataRestReactjs:classes SKIPPED
:HelloSpringDataRestReactjs:bootJar SKIPPED
:HelloSpringDataRestReactjs:bootStartScripts SKIPPED
:HelloSpringDataRestReactjs:bootDistTar SKIPPED
:HelloSpringDataRestReactjs:bootDistZip SKIPPED
:HelloSpringDataRestReactjs:jar SKIPPED
:HelloSpringDataRestReactjs:startScripts SKIPPED
:HelloSpringDataRestReactjs:distTar SKIPPED
:HelloSpringDataRestReactjs:distZip SKIPPED
:HelloSpringDataRestReactjs:assemble SKIPPED
:HelloSpringDataRestReactjs:checkFrontend SKIPPED
:HelloSpringDataRestReactjs:compileTestJava SKIPPED
:HelloSpringDataRestReactjs:processTestResources SKIPPED
:HelloSpringDataRestReactjs:testClasses SKIPPED
:HelloSpringDataRestReactjs:test SKIPPED
:HelloSpringDataRestReactjs:check SKIPPED
:HelloSpringDataRestReactjs:build SKIPPED

BUILD SUCCESSFUL in 1s
```

构建：  
```
C:\ws\HelloSpringDataRestReactjs>gradle build --info
Selected primary task 'build' from project :HelloSpringDataRestReactjs
Tasks to be executed: [task ':HelloSpringDataRestReactjs:installNode', task ':HelloSpringDataRestReactjs:installYarn', task ':HelloSpringDataRestReactjs:installFrontend', task ':HelloSpringDataRestReactjs:assembleFrontend', task ':HelloSpringDataRestReactjs:compileJava', task ':HelloSpringDataRestReactjs:processResources', task ':HelloSpringDataRestReactjs:classes', task ':HelloSpringDataRestReactjs:bootJar', task ':HelloSpringDataRestReactjs:bootStartScripts', task ':HelloSpringDataRestReactjs:bootDistTar', task ':HelloSpringDataRestReactjs:bootDistZip', task ':HelloSpringDataRestReactjs:jar', task ':HelloSpringDataRestReactjs:startScripts', task ':HelloSpringDataRestReactjs:distTar', task ':HelloSpringDataRestReactjs:distZip', task ':HelloSpringDataRestReactjs:assemble', task ':HelloSpringDataRestReactjs:checkFrontend', task ':HelloSpringDataRestReactjs:compileTestJava', task ':HelloSpringDataRestReactjs:processTestResources', task ':HelloSpringDataRestReactjs:testClasses', task ':HelloSpringDataRestReactjs:test', task ':HelloSpringDataRestReactjs:check', task ':HelloSpringDataRestReactjs:build']
:HelloSpringDataRestReactjs:installNode (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:installNode
Caching disabled for task ':HelloSpringDataRestReactjs:installNode' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:installNode' is not up-to-date because:
  Output property 'nodeInstallDirectory' file  C:\ws\HelloSpringDataRestReactjs\build\nodejs has been removed.
  Output property 'nodeInstallDirectory' file  C:\ws\HelloSpringDataRestReactjs\build\nodejs\CHANGELOG.md has been removed.
  Output property 'nodeInstallDirectory' file  C:\ws\HelloSpringDataRestReactjs\build\nodejs\LICENSE has been removed.
[installNode] Removing install directory ' C:\ws\HelloSpringDataRestReactjs\build\nodejs'
[installNode] Downloading distribution at 'https://nodejs.org/dist/v10.15.3/node-v10.15.3-win-x64.zip'
[installNode] Downloading shasums at 'https://nodejs.org/dist/v10.15.3/SHASUMS256.txt'
[installNode] Verifying distribution integrity
[installNode] Exploding distribution into ' C:\ws\HelloSpringDataRestReactjs\build\tmp\installNode\extract'
[installNode] Moving distribution into ' C:\ws\HelloSpringDataRestReactjs\build\nodejs'
[installNode] Removing explode directory ' C:\ws\HelloSpringDataRestReactjs\build\tmp\installNode\extract'
[installNode] Removing distribution file ' C:\ws\HelloSpringDataRestReactjs\build\tmp\installNode\node-v10.15.3-win-x64.zip'
[installNode] Distribution installed in ' C:\ws\HelloSpringDataRestReactjs\build\nodejs'
:HelloSpringDataRestReactjs:installNode (Thread[Execution worker for ':',5,main]) completed. Took 1 mins 0.902 secs.
:HelloSpringDataRestReactjs:installYarn (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:installYarn SKIPPED
Skipping task ':HelloSpringDataRestReactjs:installYarn' as task onlyIf is false.
:HelloSpringDataRestReactjs:installYarn (Thread[Execution worker for ':',5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:installFrontend (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:installFrontend
Caching disabled for task ':HelloSpringDataRestReactjs:installFrontend' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:installFrontend' is not up-to-date because:
  Task has not declared any outputs despite executing actions.
[installFrontend] Running 'cmd' with arguments: [/c], [" C:\ws\HelloSpringDataRestReactjs\build\nodejs\npm.cmd" install]
Starting process 'command 'cmd''. Working directory:  C:\ws\HelloSpringDataRestReactjs Command: cmd /c " C:\ws\HelloSpringDataRestReactjs\build\nodejs\npm.cmd" install
Successfully started process 'command 'cmd''
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.12 (node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.12: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})

added 543 packages from 245 contributors in 15.172s
:HelloSpringDataRestReactjs:installFrontend (Thread[Execution worker for ':',5,main]) completed. Took 16.825 secs.
:HelloSpringDataRestReactjs:assembleFrontend (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:assembleFrontend
Caching disabled for task ':HelloSpringDataRestReactjs:assembleFrontend' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:assembleFrontend' is not up-to-date because:
  Task has not declared any outputs despite executing actions.
[assembleFrontend] Running 'cmd' with arguments: [/c], [" C:\ws\HelloSpringDataRestReactjs\build\nodejs\npm.cmd" run build]
Starting process 'command 'cmd''. Working directory:  C:\ws\HelloSpringDataRestReactjs Command: cmd /c " C:\ws\HelloSpringDataRestReactjs\build\nodejs\npm.cmd" run build
Successfully started process 'command 'cmd''

> spring-data-rest-and-reactjs@0.1.0 build  C:\ws\HelloSpringDataRestReactjs
> webpack --config webpack.config.js -d

Hash: a2e26d521660d96c361d
Version: webpack 4.43.0
Time: 1501ms
Built at: 2020-04-25 09:50:55
                                      Asset      Size  Chunks             Chunk Names
./src/main/resources/static/built/bundle.js  2.58 MiB    main  [emitted]  main
Entrypoint main = ./src/main/resources/static/built/bundle.js
[./src/main/js/api/uriListConverter.js] 614 bytes {main} [built]
[./src/main/js/api/uriTemplateInterceptor.js] 497 bytes {main} [built]
[./src/main/js/app.js] 5.7 KiB {main} [built]
[./src/main/js/client.js] 712 bytes {main} [built]
    + 37 hidden modules
:HelloSpringDataRestReactjs:assembleFrontend (Thread[Execution worker for ':',5,main]) completed. Took 3.545 secs.
:HelloSpringDataRestReactjs:compileJava (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:compileJava
Resolving global dependency management for project 'HelloSpringDataRestReactjs'
Excluding [org.apache.tomcat:tomcat-annotations-api, ognl:ognl]
Excluding []
Caching disabled for task ':HelloSpringDataRestReactjs:compileJava' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:compileJava' is not up-to-date because:
  Output property 'destinationDir' file  C:\ws\HelloSpringDataRestReactjs\build\classes\java\main has been removed.
  Output property 'destinationDir' file  C:\ws\HelloSpringDataRestReactjs\build\classes\java\main\com has been removed.
  Output property 'destinationDir' file  C:\ws\HelloSpringDataRestReactjs\build\classes\java\main\com\yqu has been removed.
All input files are considered out-of-date for incremental task ':HelloSpringDataRestReactjs:compileJava'.
Full recompilation is required because no incremental change information is available. This is usually caused by clean builds or changing compiler arguments.
Compiling with JDK Java compiler API.
Created classpath snapshot for incremental compilation in 0.073 secs. 1 duplicate classes found in classpath (see all with --debug).
:HelloSpringDataRestReactjs:compileJava (Thread[Execution worker for ':',5,main]) completed. Took 1.305 secs.
:HelloSpringDataRestReactjs:processResources (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:processResources
Caching disabled for task ':HelloSpringDataRestReactjs:processResources' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:processResources' is not up-to-date because:
  Output property 'destinationDir' file  C:\ws\HelloSpringDataRestReactjs\build\resources\main has been removed.
  Output property 'destinationDir' file  C:\ws\HelloSpringDataRestReactjs\build\resources\main\application.properties has been removed.
  Output property 'destinationDir' file  C:\ws\HelloSpringDataRestReactjs\build\resources\main\static has been removed.
:HelloSpringDataRestReactjs:processResources (Thread[Execution worker for ':',5,main]) completed. Took 0.061 secs.
:HelloSpringDataRestReactjs:classes (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:classes
Skipping task ':HelloSpringDataRestReactjs:classes' as it has no actions.
:HelloSpringDataRestReactjs:classes (Thread[Execution worker for ':',5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:bootJar (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:bootJar
Excluding []
Caching disabled for task ':HelloSpringDataRestReactjs:bootJar' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:bootJar' is not up-to-date because:
  Output property 'archiveFile' file  C:\ws\HelloSpringDataRestReactjs\build\libs\HelloSpringDataRestReactjs.jar has been removed.
:HelloSpringDataRestReactjs:bootJar (Thread[Execution worker for ':',5,main]) completed. Took 0.686 secs.
:HelloSpringDataRestReactjs:bootStartScripts (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:bootStartScripts
Caching disabled for task ':HelloSpringDataRestReactjs:bootStartScripts' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:bootStartScripts' is not up-to-date because:
  Output property 'outputDir' file  C:\ws\HelloSpringDataRestReactjs\build\bootScripts has been removed.
  Output property 'outputDir' file  C:\ws\HelloSpringDataRestReactjs\build\bootScripts\HelloSpringDataRestReactjs has been removed.
  Output property 'outputDir' file  C:\ws\HelloSpringDataRestReactjs\build\bootScripts\HelloSpringDataRestReactjs.bat has been removed.
:HelloSpringDataRestReactjs:bootStartScripts (Thread[Execution worker for ':',5,main]) completed. Took 0.183 secs.
:HelloSpringDataRestReactjs:bootDistTar (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:bootDistTar
Caching disabled for task ':HelloSpringDataRestReactjs:bootDistTar' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:bootDistTar' is not up-to-date because:
  Output property 'archiveFile' file  C:\ws\HelloSpringDataRestReactjs\build\distributions\HelloSpringDataRestReactjs-boot.tar has been removed.
:HelloSpringDataRestReactjs:bootDistTar (Thread[Execution worker for ':',5,main]) completed. Took 0.209 secs.
:HelloSpringDataRestReactjs:bootDistZip (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:bootDistZip
Caching disabled for task ':HelloSpringDataRestReactjs:bootDistZip' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:bootDistZip' is not up-to-date because:
  Output property 'archiveFile' file  C:\ws\HelloSpringDataRestReactjs\build\distributions\HelloSpringDataRestReactjs-boot.zip has been removed.
:HelloSpringDataRestReactjs:bootDistZip (Thread[Execution worker for ':',5,main]) completed. Took 1.351 secs.
:HelloSpringDataRestReactjs:jar (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:jar SKIPPED
Skipping task ':HelloSpringDataRestReactjs:jar' as task onlyIf is false.
:HelloSpringDataRestReactjs:jar (Thread[Execution worker for ':',5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:startScripts (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:startScripts
Caching disabled for task ':HelloSpringDataRestReactjs:startScripts' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:startScripts' is not up-to-date because:
  Output property 'outputDir' file  C:\ws\HelloSpringDataRestReactjs\build\scripts has been removed.
  Output property 'outputDir' file  C:\ws\HelloSpringDataRestReactjs\build\scripts\HelloSpringDataRestReactjs has been removed.
  Output property 'outputDir' file  C:\ws\HelloSpringDataRestReactjs\build\scripts\HelloSpringDataRestReactjs.bat has been removed.
:HelloSpringDataRestReactjs:startScripts (Thread[Execution worker for ':',5,main]) completed. Took 0.055 secs.
:HelloSpringDataRestReactjs:distTar (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:distTar
Caching disabled for task ':HelloSpringDataRestReactjs:distTar' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:distTar' is not up-to-date because:
  Output property 'archiveFile' file  C:\ws\HelloSpringDataRestReactjs\build\distributions\HelloSpringDataRestReactjs.tar has been removed.
:HelloSpringDataRestReactjs:distTar (Thread[Execution worker for ':',5,main]) completed. Took 0.235 secs.
:HelloSpringDataRestReactjs:distZip (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:distZip
Caching disabled for task ':HelloSpringDataRestReactjs:distZip' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:distZip' is not up-to-date because:
  Output property 'archiveFile' file  C:\ws\HelloSpringDataRestReactjs\build\distributions\HelloSpringDataRestReactjs.zip has been removed.
:HelloSpringDataRestReactjs:distZip (Thread[Execution worker for ':',5,main]) completed. Took 1.462 secs.
:HelloSpringDataRestReactjs:assemble (Thread[Execution worker for ':' Thread 3,5,main]) started.

> Task :HelloSpringDataRestReactjs:assemble
Skipping task ':HelloSpringDataRestReactjs:assemble' as it has no actions.
:HelloSpringDataRestReactjs:assemble (Thread[Execution worker for ':' Thread 3,5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:checkFrontend (Thread[Execution worker for ':' Thread 3,5,main]) started.

> Task :HelloSpringDataRestReactjs:checkFrontend SKIPPED
Skipping task ':HelloSpringDataRestReactjs:checkFrontend' as task onlyIf is false.
:HelloSpringDataRestReactjs:checkFrontend (Thread[Execution worker for ':' Thread 3,5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:compileTestJava (Thread[Execution worker for ':' Thread 3,5,main]) started.

> Task :HelloSpringDataRestReactjs:compileTestJava NO-SOURCE
file or directory ' C:\ws\HelloSpringDataRestReactjs\src\test\java', not found
Skipping task ':HelloSpringDataRestReactjs:compileTestJava' as it has no source files and no previous output files.
:HelloSpringDataRestReactjs:compileTestJava (Thread[Execution worker for ':' Thread 3,5,main]) completed. Took 0.002 secs.
:HelloSpringDataRestReactjs:processTestResources (Thread[Execution worker for ':' Thread 3,5,main]) started.

> Task :HelloSpringDataRestReactjs:processTestResources NO-SOURCE
file or directory ' C:\ws\HelloSpringDataRestReactjs\src\test\resources', not found
Skipping task ':HelloSpringDataRestReactjs:processTestResources' as it has no source files and no previous output files.
:HelloSpringDataRestReactjs:processTestResources (Thread[Execution worker for ':' Thread 3,5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:testClasses (Thread[Execution worker for ':' Thread 3,5,main]) started.

> Task :HelloSpringDataRestReactjs:testClasses UP-TO-DATE
Skipping task ':HelloSpringDataRestReactjs:testClasses' as it has no actions.
:HelloSpringDataRestReactjs:testClasses (Thread[Execution worker for ':' Thread 3,5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:test (Thread[Execution worker for ':' Thread 3,5,main]) started.

> Task :HelloSpringDataRestReactjs:test NO-SOURCE
Skipping task ':HelloSpringDataRestReactjs:test' as it has no source files and no previous output files.
:HelloSpringDataRestReactjs:test (Thread[Execution worker for ':' Thread 3,5,main]) completed. Took 0.001 secs.
:HelloSpringDataRestReactjs:check (Thread[Execution worker for ':' Thread 3,5,main]) started.

> Task :HelloSpringDataRestReactjs:check UP-TO-DATE
Skipping task ':HelloSpringDataRestReactjs:check' as it has no actions.
:HelloSpringDataRestReactjs:check (Thread[Execution worker for ':' Thread 3,5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:build (Thread[Execution worker for ':' Thread 3,5,main]) started.

> Task :HelloSpringDataRestReactjs:build
Skipping task ':HelloSpringDataRestReactjs:build' as it has no actions.
:HelloSpringDataRestReactjs:build (Thread[Execution worker for ':' Thread 3,5,main]) completed. Took 0.0 secs.

BUILD SUCCESSFUL in 1m 28s
12 actionable tasks: 12 executed
```

清除：  
```
C:\ws\HelloSpringDataRestReactjs>gradle clean --info
Selected primary task 'clean' from project :HelloSpringDataRestReactjs
Tasks to be executed: [task ':HelloSpringDataRestReactjs:cleanFrontend', task ':HelloSpringDataRestReactjs:clean']
:HelloSpringDataRestReactjs:cleanFrontend (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:cleanFrontend SKIPPED
Skipping task ':HelloSpringDataRestReactjs:cleanFrontend' as task onlyIf is false.
:HelloSpringDataRestReactjs:cleanFrontend (Thread[Execution worker for ':',5,main]) completed. Took 0.005 secs.
:HelloSpringDataRestReactjs:clean (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:clean
Caching disabled for task ':HelloSpringDataRestReactjs:clean' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:clean' is not up-to-date because:
  Task has not declared any outputs despite executing actions.
:HelloSpringDataRestReactjs:clean (Thread[Execution worker for ':',5,main]) completed. Took 5.01 secs.

BUILD SUCCESSFUL in 6s
1 actionable task: 1 executed
```

### [Gradle Plugin for Node](https://github.com/srs/gradle-node-plugin)实践  

#### 代码修改

build.gradle:  
```
plugins {
    id 'com.moowork.node' version '1.3.1'
}

apply plugin: 'com.moowork.node'


node {
    // Version of node to use.
    version = '10.15.3'

    // Version of npm to use.
    npmVersion = '6.4.1'

    // Base URL for fetching node distributions (change if you have a mirror).
    distBaseUrl = 'https://nodejs.org/dist'

    // If true, it will download node using above parameters.
    // If false, it will try to use globally installed node.
    download = true

    // Set the work directory for unpacking node
    workDir = file("${project.buildDir}/nodejs")

    // Set the work directory for NPM
    npmWorkDir = file("${project.buildDir}/npm")

    // Set the work directory where node_modules should be located
    nodeModulesDir = file("${project.projectDir}")
}


task buildReactApp(type: NodeTask, dependsOn: 'npmInstall') {
    script = project.file('node_modules/webpack/bin/webpack.js')
}

processResources.dependsOn 'buildReactApp'

clean.delete << file('node_modules')
clean.delete << file('src/main/resources/static/built')
```

#### 操作

查看构建需要执行的任务：  
```
C:\ws\HelloSpringDataRestReactjs>gradle -m build
:HelloSpringDataRestReactjs:compileJava SKIPPED
:HelloSpringDataRestReactjs:nodeSetup SKIPPED
:HelloSpringDataRestReactjs:npmSetup SKIPPED
:HelloSpringDataRestReactjs:npmInstall SKIPPED
:HelloSpringDataRestReactjs:buildReactApp SKIPPED
:HelloSpringDataRestReactjs:processResources SKIPPED
:HelloSpringDataRestReactjs:classes SKIPPED
:HelloSpringDataRestReactjs:bootJar SKIPPED
:HelloSpringDataRestReactjs:bootStartScripts SKIPPED
:HelloSpringDataRestReactjs:bootDistTar SKIPPED
:HelloSpringDataRestReactjs:bootDistZip SKIPPED
:HelloSpringDataRestReactjs:jar SKIPPED
:HelloSpringDataRestReactjs:startScripts SKIPPED
:HelloSpringDataRestReactjs:distTar SKIPPED
:HelloSpringDataRestReactjs:distZip SKIPPED
:HelloSpringDataRestReactjs:assemble SKIPPED
:HelloSpringDataRestReactjs:compileTestJava SKIPPED
:HelloSpringDataRestReactjs:processTestResources SKIPPED
:HelloSpringDataRestReactjs:testClasses SKIPPED
:HelloSpringDataRestReactjs:test SKIPPED
:HelloSpringDataRestReactjs:check SKIPPED
:HelloSpringDataRestReactjs:build SKIPPED

BUILD SUCCESSFUL in 985ms
```

构建：  
```
Selected primary task 'build' from project :HelloSpringDataRestReactjs
Tasks to be executed: [task ':HelloSpringDataRestReactjs:compileJava', task ':HelloSpringDataRestReactjs:nodeSetup', task ':HelloSpringDataRestReactjs:npmSetup', task ':HelloSpringDataRestReactjs:npmInstall', task ':HelloSpringDataRestReactjs:buildReactApp', task ':HelloSpringDataRestReactjs:processResources', task ':HelloSpringDataRestReactjs:classes', task ':HelloSpringDataRestReactjs:bootJar', task ':HelloSpringDataRestReactjs:bootStartScripts', task ':HelloSpringDataRestReactjs:bootDistTar', task ':HelloSpringDataRestReactjs:bootDistZip', task ':HelloSpringDataRestReactjs:jar', task ':HelloSpringDataRestReactjs:startScripts', task ':HelloSpringDataRestReactjs:distTar', task ':HelloSpringDataRestReactjs:distZip', task ':HelloSpringDataRestReactjs:assemble', task ':HelloSpringDataRestReactjs:compileTestJava', task ':HelloSpringDataRestReactjs:processTestResources', task ':HelloSpringDataRestReactjs:testClasses', task ':HelloSpringDataRestReactjs:test', task ':HelloSpringDataRestReactjs:check', task ':HelloSpringDataRestReactjs:build']
:HelloSpringDataRestReactjs:compileJava (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:compileJava
Resolving global dependency management for project 'HelloSpringDataRestReactjs'
Excluding [org.apache.tomcat:tomcat-annotations-api, ognl:ognl]
Excluding []
Caching disabled for task ':HelloSpringDataRestReactjs:compileJava' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:compileJava' is not up-to-date because:
  Output property 'destinationDir' file  C:\ws\HelloSpringDataRestReactjs\build\classes\java\main has been removed.
  Output property 'destinationDir' file  C:\ws\HelloSpringDataRestReactjs\build\classes\java\main\com has been removed.
  Output property 'destinationDir' file  C:\ws\HelloSpringDataRestReactjs\build\classes\java\main\com\yqu has been removed.
All input files are considered out-of-date for incremental task ':HelloSpringDataRestReactjs:compileJava'.
Full recompilation is required because no incremental change information is available. This is usually caused by clean builds or changing compiler arguments.
Compiling with JDK Java compiler API.
Created classpath snapshot for incremental compilation in 0.002 secs. 1 duplicate classes found in classpath (see all with --debug).
:HelloSpringDataRestReactjs:compileJava (Thread[Execution worker for ':',5,main]) completed. Took 0.57 secs.
:HelloSpringDataRestReactjs:nodeSetup (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:nodeSetup
Caching disabled for task ':HelloSpringDataRestReactjs:nodeSetup' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:nodeSetup' is not up-to-date because:
  Output property 'nodeDir' file  C:\ws\HelloSpringDataRestReactjs\build\nodejs\node-v10.15.3-win-x64 has been removed.
  Output property 'nodeDir' file  C:\ws\HelloSpringDataRestReactjs\build\nodejs\node-v10.15.3-win-x64\CHANGELOG.md has been removed.
  Output property 'nodeDir' file  C:\ws\HelloSpringDataRestReactjs\build\nodejs\node-v10.15.3-win-x64\LICENSE has been removed.
:HelloSpringDataRestReactjs:nodeSetup (Thread[Execution worker for ':',5,main]) completed. Took 26.34 secs.
:HelloSpringDataRestReactjs:npmSetup (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:npmSetup
Caching disabled for task ':HelloSpringDataRestReactjs:npmSetup' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:npmSetup' is not up-to-date because:
  Output property 'npmDir' file  C:\ws\HelloSpringDataRestReactjs\build\npm\npm-v6.4.1 has been removed.
  Output property 'npmDir' file  C:\ws\HelloSpringDataRestReactjs\build\npm\npm-v6.4.1\node_modules has been removed.
  Output property 'npmDir' file  C:\ws\HelloSpringDataRestReactjs\build\npm\npm-v6.4.1\node_modules\npm has been removed.
Starting process 'command ' C:\ws\HelloSpringDataRestReactjs\build\nodejs\node-v10.15.3-win-x64\node.exe''. Working directory:  C:\ws\HelloSpringDataRestReactjs Command:  C:\ws\HelloSpringDataRestReactjs\build\nodejs\node-v10.15.3-win-x64\node.exe  C:\ws\HelloSpringDataRestReactjs\build\nodejs\node-v10.15.3-win-x64\node_modules\npm\bin\npm-cli.js install --global --no-save --prefix  C:\ws\HelloSpringDataRestReactjs\build\npm\npm-v6.4.1 npm@6.4.1
Successfully started process 'command ' C:\ws\HelloSpringDataRestReactjs\build\nodejs\node-v10.15.3-win-x64\node.exe''
 C:\ws\HelloSpringDataRestReactjs\build\npm\npm-v6.4.1\npx ->  C:\ws\HelloSpringDataRestReactjs\build\npm\npm-v6.4.1\node_modules\npm\bin\npx-cli.js
 C:\ws\HelloSpringDataRestReactjs\build\npm\npm-v6.4.1\npm ->  C:\ws\HelloSpringDataRestReactjs\build\npm\npm-v6.4.1\node_modules\npm\bin\npm-cli.js
+ npm@6.4.1
added 387 packages from 770 contributors in 16.644s
:HelloSpringDataRestReactjs:npmSetup (Thread[Execution worker for ':',5,main]) completed. Took 18.55 secs.
:HelloSpringDataRestReactjs:npmInstall (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:npmInstall
Caching disabled for task ':HelloSpringDataRestReactjs:npmInstall' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:npmInstall' is not up-to-date because:
  Output property '$1' file  C:\ws\HelloSpringDataRestReactjs\node_modules has been removed.
  Output property '$1' file  C:\ws\HelloSpringDataRestReactjs\node_modules\.bin has been removed.
  Output property '$1' file  C:\ws\HelloSpringDataRestReactjs\node_modules\.bin\acorn has been removed.
Starting process 'command ' C:\ws\HelloSpringDataRestReactjs\build\npm\npm-v6.4.1\npm.cmd''. Working directory:  C:\ws\HelloSpringDataRestReactjs Command:  C:\ws\HelloSpringDataRestReactjs\build\npm\npm-v6.4.1\npm.cmd install
Successfully started process 'command ' C:\ws\HelloSpringDataRestReactjs\build\npm\npm-v6.4.1\npm.cmd''
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.12 (node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.12: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})

added 543 packages from 245 contributors in 15.314s
:HelloSpringDataRestReactjs:npmInstall (Thread[Execution worker for ':',5,main]) completed. Took 16.978 secs.
:HelloSpringDataRestReactjs:buildReactApp (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:buildReactApp
Caching disabled for task ':HelloSpringDataRestReactjs:buildReactApp' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:buildReactApp' is not up-to-date because:
  Task has not declared any outputs despite executing actions.
Starting process 'command ' C:\ws\HelloSpringDataRestReactjs\build\nodejs\node-v10.15.3-win-x64\node.exe''. Working directory:  C:\ws\HelloSpringDataRestReactjs Command:  C:\ws\HelloSpringDataRestReactjs\build\nodejs\node-v10.15.3-win-x64\node.exe  C:\ws\HelloSpringDataRestReactjs\node_modules\webpack\bin\webpack.js
Successfully started process 'command ' C:\ws\HelloSpringDataRestReactjs\build\nodejs\node-v10.15.3-win-x64\node.exe''
Hash: f1e3a07435d35106a59b
Version: webpack 4.43.0
Time: 1764ms
Built at: 2020-04-25 10:31:04
                                          Asset      Size  Chunks                   Chunk Names
./src/main/resources/static/built/bundle.js  1020 KiB    main  [emitted]        main
./src/main/resources/static/built/bundle.js.map  1.16 MiB    main  [emitted] [dev]  main
Entrypoint main = ./src/main/resources/static/built/bundle.js ./src/main/resources/static/built/bundle.js.map
[./src/main/js/api/uriListConverter.js] 614 bytes {main} [built]
[./src/main/js/api/uriTemplateInterceptor.js] 497 bytes {main} [built]
[./src/main/js/app.js] 5.7 KiB {main} [built]
[./src/main/js/client.js] 712 bytes {main} [built]
    + 37 hidden modules
:HelloSpringDataRestReactjs:buildReactApp (Thread[Execution worker for ':',5,main]) completed. Took 2.958 secs.
:HelloSpringDataRestReactjs:processResources (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:processResources
Caching disabled for task ':HelloSpringDataRestReactjs:processResources' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:processResources' is not up-to-date because:
  Output property 'destinationDir' file  C:\ws\HelloSpringDataRestReactjs\build\resources\main has been removed.
  Output property 'destinationDir' file  C:\ws\HelloSpringDataRestReactjs\build\resources\main\application.properties has been removed.
  Output property 'destinationDir' file  C:\ws\HelloSpringDataRestReactjs\build\resources\main\static has been removed.
:HelloSpringDataRestReactjs:processResources (Thread[Execution worker for ':',5,main]) completed. Took 0.155 secs.
:HelloSpringDataRestReactjs:classes (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:classes
Skipping task ':HelloSpringDataRestReactjs:classes' as it has no actions.
:HelloSpringDataRestReactjs:classes (Thread[Execution worker for ':',5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:bootJar (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:bootJar
Excluding []
Caching disabled for task ':HelloSpringDataRestReactjs:bootJar' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:bootJar' is not up-to-date because:
  Output property 'archiveFile' file  C:\ws\HelloSpringDataRestReactjs\build\libs\HelloSpringDataRestReactjs.jar has been removed.
:HelloSpringDataRestReactjs:bootJar (Thread[Execution worker for ':',5,main]) completed. Took 0.405 secs.
:HelloSpringDataRestReactjs:bootStartScripts (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:bootStartScripts
Caching disabled for task ':HelloSpringDataRestReactjs:bootStartScripts' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:bootStartScripts' is not up-to-date because:
  Output property 'outputDir' file  C:\ws\HelloSpringDataRestReactjs\build\bootScripts has been removed.
  Output property 'outputDir' file  C:\ws\HelloSpringDataRestReactjs\build\bootScripts\HelloSpringDataRestReactjs has been removed.
  Output property 'outputDir' file  C:\ws\HelloSpringDataRestReactjs\build\bootScripts\HelloSpringDataRestReactjs.bat has been removed.
:HelloSpringDataRestReactjs:bootStartScripts (Thread[Execution worker for ':',5,main]) completed. Took 0.031 secs.
:HelloSpringDataRestReactjs:bootDistTar (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:bootDistTar
Caching disabled for task ':HelloSpringDataRestReactjs:bootDistTar' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:bootDistTar' is not up-to-date because:
  Output property 'archiveFile' file  C:\ws\HelloSpringDataRestReactjs\build\distributions\HelloSpringDataRestReactjs-boot.tar has been removed.
:HelloSpringDataRestReactjs:bootDistTar (Thread[Execution worker for ':',5,main]) completed. Took 0.204 secs.
:HelloSpringDataRestReactjs:bootDistZip (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:bootDistZip
Caching disabled for task ':HelloSpringDataRestReactjs:bootDistZip' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:bootDistZip' is not up-to-date because:
  Output property 'archiveFile' file  C:\ws\HelloSpringDataRestReactjs\build\distributions\HelloSpringDataRestReactjs-boot.zip has been removed.
:HelloSpringDataRestReactjs:bootDistZip (Thread[Execution worker for ':',5,main]) completed. Took 1.345 secs.
:HelloSpringDataRestReactjs:jar (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:jar SKIPPED
Skipping task ':HelloSpringDataRestReactjs:jar' as task onlyIf is false.
:HelloSpringDataRestReactjs:jar (Thread[Execution worker for ':',5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:startScripts (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:startScripts
Caching disabled for task ':HelloSpringDataRestReactjs:startScripts' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:startScripts' is not up-to-date because:
  Output property 'outputDir' file  C:\ws\HelloSpringDataRestReactjs\build\scripts has been removed.
  Output property 'outputDir' file  C:\ws\HelloSpringDataRestReactjs\build\scripts\HelloSpringDataRestReactjs has been removed.
  Output property 'outputDir' file  C:\ws\HelloSpringDataRestReactjs\build\scripts\HelloSpringDataRestReactjs.bat has been removed.
:HelloSpringDataRestReactjs:startScripts (Thread[Execution worker for ':',5,main]) completed. Took 0.047 secs.
:HelloSpringDataRestReactjs:distTar (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:distTar
Caching disabled for task ':HelloSpringDataRestReactjs:distTar' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:distTar' is not up-to-date because:
  Output property 'archiveFile' file  C:\ws\HelloSpringDataRestReactjs\build\distributions\HelloSpringDataRestReactjs.tar has been removed.
:HelloSpringDataRestReactjs:distTar (Thread[Execution worker for ':',5,main]) completed. Took 0.23 secs.
:HelloSpringDataRestReactjs:distZip (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:distZip
Caching disabled for task ':HelloSpringDataRestReactjs:distZip' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:distZip' is not up-to-date because:
  Output property 'archiveFile' file  C:\ws\HelloSpringDataRestReactjs\build\distributions\HelloSpringDataRestReactjs.zip has been removed.
:HelloSpringDataRestReactjs:distZip (Thread[Execution worker for ':',5,main]) completed. Took 1.439 secs.
:HelloSpringDataRestReactjs:assemble (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:assemble
Skipping task ':HelloSpringDataRestReactjs:assemble' as it has no actions.
:HelloSpringDataRestReactjs:assemble (Thread[Execution worker for ':',5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:compileTestJava (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:compileTestJava NO-SOURCE
file or directory ' C:\ws\HelloSpringDataRestReactjs\src\test\java', not found
Skipping task ':HelloSpringDataRestReactjs:compileTestJava' as it has no source files and no previous output files.
:HelloSpringDataRestReactjs:compileTestJava (Thread[Execution worker for ':',5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:processTestResources (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:processTestResources NO-SOURCE
file or directory ' C:\ws\HelloSpringDataRestReactjs\src\test\resources', not found
Skipping task ':HelloSpringDataRestReactjs:processTestResources' as it has no source files and no previous output files.
:HelloSpringDataRestReactjs:processTestResources (Thread[Execution worker for ':',5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:testClasses (Thread[Execution worker for ':',5,main]) started.

> Task :HelloSpringDataRestReactjs:testClasses UP-TO-DATE
Skipping task ':HelloSpringDataRestReactjs:testClasses' as it has no actions.
:HelloSpringDataRestReactjs:testClasses (Thread[Execution worker for ':',5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:test (Thread[Execution worker for ':' Thread 9,5,main]) started.

> Task :HelloSpringDataRestReactjs:test NO-SOURCE
Skipping task ':HelloSpringDataRestReactjs:test' as it has no source files and no previous output files.
:HelloSpringDataRestReactjs:test (Thread[Execution worker for ':' Thread 9,5,main]) completed. Took 0.002 secs.
:HelloSpringDataRestReactjs:check (Thread[Execution worker for ':' Thread 9,5,main]) started.

> Task :HelloSpringDataRestReactjs:check UP-TO-DATE
Skipping task ':HelloSpringDataRestReactjs:check' as it has no actions.
:HelloSpringDataRestReactjs:check (Thread[Execution worker for ':' Thread 9,5,main]) completed. Took 0.0 secs.
:HelloSpringDataRestReactjs:build (Thread[Execution worker for ':' Thread 9,5,main]) started.

> Task :HelloSpringDataRestReactjs:build
Skipping task ':HelloSpringDataRestReactjs:build' as it has no actions.
:HelloSpringDataRestReactjs:build (Thread[Execution worker for ':' Thread 9,5,main]) completed. Took 0.0 secs.

Deprecated Gradle features were used in this build, making it incompatible with Gradle 6.0.
Use '--warning-mode all' to show the individual deprecation warnings.
See https://docs.gradle.org/5.6/userguide/command_line_interface.html#sec:command_line_warnings

BUILD SUCCESSFUL in 1m 10s
```

清除：  
```
C:\ws\HelloSpringDataRestReactjs>gradle clean --info
> Task :HelloSpringDataRestReactjs:clean
Caching disabled for task ':HelloSpringDataRestReactjs:clean' because:
  Build cache is disabled
Task ':HelloSpringDataRestReactjs:clean' is not up-to-date because:
  Task has not declared any outputs despite executing actions.
:HelloSpringDataRestReactjs:clean (Thread[Execution worker for ':',5,main]) completed. Took 6.71 secs.

BUILD SUCCESSFUL in 9s
```

### 备选Gradle前端构建插件对比分析

#### 星数对比
[Frontend Gradle plugin](https://github.com/Siouan/frontend-gradle-plugin) 项目星数 3.2k；  
[Gradle Plugin for Node](https://github.com/srs/gradle-node-plugin) 项目星数 824；    
[Frontend Gradle plugin](https://github.com/Siouan/frontend-gradle-plugin) 胜出

#### 支持系统
[Frontend Gradle plugin](https://github.com/Siouan/frontend-gradle-plugin) 支持[NodeJS](https://nodejs.org/)、[Npm](https://www.npmjs.com/)、[Yarn](https://yarnpkg.com/)；  
[Gradle Plugin for Node](https://github.com/srs/gradle-node-plugin) 支持[NodeJS](https://nodejs.org/)、[Npm](https://www.npmjs.com/)、[Yarn](https://yarnpkg.com/)、[Grunt](https://gruntjs.com/)、[Gulp](https://gulpjs.com/)；    
[Gradle Plugin for Node](https://github.com/srs/gradle-node-plugin) 胜出

#### Node/Npm配置
[Frontend Gradle plugin](https://github.com/Siouan/frontend-gradle-plugin) 支持NodeJS版本，支持NodeJS安装路径；  
[Gradle Plugin for Node](https://github.com/srs/gradle-node-plugin) 支持NodeJS版本，支持NodeJS安装路径，支持Npm版本，支持Npm安装路径，支持node_modules安装路径；    
[Gradle Plugin for Node](https://github.com/srs/gradle-node-plugin) 胜出  

#### 总结
[Frontend Gradle plugin](https://github.com/Siouan/frontend-gradle-plugin)项目星数远远高于[Gradle Plugin for Node](https://github.com/srs/gradle-node-plugin)，不过当前支持的特性却不如后者多。  
这两款插件都能胜任我当前的游戏要求。 所以我选择现阶段使用[Gradle Plugin for Node](https://github.com/srs/gradle-node-plugin)，对[Frontend Gradle plugin](https://github.com/Siouan/frontend-gradle-plugin)保持关注。   

### 执行Webpack的其他方式

[Running Webpack with Gradle](https://guides.gradle.org/running-webpack-with-gradle/)是Gradle的官方指南，它是用commandLine执行的。  
但是我发现这种方式有个缺陷，在Windows平台执行webpack shell命令就报错了，需要判断平台来决定使用webpack shell命令还是webpack.cmd命令。所以需要做如下修改：  
```
task webpack(type: Exec) { 
  if (System.getProperty("os.name").toUpperCase().contains("WINDOWS")) {
    commandLine "$projectDir/node_modules/.bin/webpack.cmd", "app/index.js", "$buildDir/js/bundle.js"
  } else {
    commandLine "$projectDir/node_modules/.bin/webpack", "app/index.js", "$buildDir/js/bundle.js"
  }    
}
```

### 参考

* [frontend-maven-plugin](https://github.com/eirslett/frontend-maven-plugin)  
* [React.js and Spring Data REST](https://spring.io/guides/tutorials/react-and-spring-data-rest/)  
* [Frontend Gradle plugin](https://github.com/Siouan/frontend-gradle-plugin)  
* [Gradle Plugin for Node](https://github.com/srs/gradle-node-plugin)  
* [Running Webpack with Gradle](https://guides.gradle.org/running-webpack-with-gradle/)  
* [Angular + Spring Boot integration using Gradle](https://blog.marcnuri.com/angular-spring-boot-integration-gradle/)  
