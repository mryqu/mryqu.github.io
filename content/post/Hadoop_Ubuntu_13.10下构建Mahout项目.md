---
title: '[Hadoop] Ubuntu 13.10下构建Mahout项目'
date: 2013-10-18 20:58:18
categories: 
- Hadoop+Spark
- Hadoop
tags: 
- jdk
- eclipse
- m2eclipse
- mahout
- ubuntu
---
# JDK

- 在Oracle网站下载[jdk-6u45-linux-i586.bin](http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase6-419409.html#jdk-6u45-oth-JPR)到/opt目录
- 进入/opt目录安装JDK:
  ```
  chmod +x jdk-6u45-linux-i586.bin
  sudo ./jdk-6u45-linux-i586.bin
  ```
- 进入/etc目录配置profile文件:
  `sudo vi profile` 在文件末尾添加：
  ```
  JAVA_HOME=/opt/jdk1.6.0_45
  export JRE_HOME=$JAVA_HOME/jre
  export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
  export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
  ```
  运行`source /etc/profile` 使其生效。
- 运行`java -version` 检验:
  ```
  java version "1.6.0_45"
  ```

# Eclipse

- 在Eclipse网站下载[eclipse-jee-juno-SR2-linux-gtk.tar.gz](http://www.eclipse.org/downloads/index-developer.php)到/opt目录
- 进入/opt目录解压缩Eclipse:
  ```
  $ sudo tar -zxvf eclipse-jee-juno-SR2-linux-gtk.tar.gz$ sudo rm ./eclipse-jee-juno-SR2-linux-gtk.tar.gz
  ```
- 创建Eclipse启动快捷方式：
  $ sudo gedit /usr/share/applications/eclipse.desktop
  ```
  [Desktop Entry]
  Type=Application
  Name=Eclipse
  Comment=Eclipse IDE
  Icon=/opt/eclipse/icon.xpm
  Exec=/opt/eclipse/eclipse
  Terminal=false
  StartupNotify=true
  Type=Application
  Categories=Development;IDE;Java;
  Exec=env UBUNTU_MENUPROXY= /opt/eclipse/eclipse  
  ```

# m2eclipse

- 通过下列update site安装:http://download.eclipse.org/technology/m2e/releases

# Mahout

- 在Mahout网站下载[mahout-distribution-0.8-src.tar.gz](http://archive.apache.org/dist/mahout/0.8/mahout-distribution-0.8-src.tar.gz)到自己的Eclipseworkspace中
- 进入worksapce解压缩mahout:
  ```
  $ tar -zxvf mahout-distribution-0.8-src.tar.gz
  $ rm ./mahout-distribution-0.8-src.tar.gz
  ```
- 导入Mahout: File - Import - Maven - Existing MavenProjects
  ![[Hadoop] Ubuntu 13.10下构建Mahout项目](/images/2013/10/0026uWfMty6FUNRdilyc8.png)