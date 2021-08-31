---
title: 'MIUI12.5关闭充电提示音'
date: 2021-08-31 12:31:23
categories: 
- Tool
tags: 
- miui
- 充电
- 提示音
- 关闭

---

自从手机升级到MIUI12.5，原来关闭提示音就又出现了。  
在“设置-声音与振动-更多声音设置”里面关闭了所有提示音，可是充电提示音依旧存在。上网一查，原来充电提示音变成不可配置的了。  
下载[Android SDK Platform-Tools](https://developer.android.com/studio/releases/platform-tools) ，执行adb程序无法找到任何设备。  
```
C:\temp\platform-tools_r31.0.3-windows\platform-tools>adb devices
List of devices attached
```
  
在手机上执行如下操作：  
1. 设置—我的设备—全部参数—连续点击MIUI版本直至提示开发者模式已打开  
2. 设置-更多设置-开发者选项-激活USB调试、USB调试（安全设置）  
  
重新执行adb程序：  
```
C:\temp\platform-tools_r31.0.3-windows\platform-tools>adb devices
List of devices attached
********        device

C:\temp\platform-tools_r31.0.3-windows\platform-tools>adb shell settings put global power_sounds_enabled 0

```
  
成功！  