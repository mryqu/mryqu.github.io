---
title: "[Gradle] 遭遇 Unable to process incoming event 'ProgressComplete' (ProgressCompleteEvent)"
date: 2017-11-30 06:08:53  
categories: 
- Tool
- Gradle
tags: 
- gradle
- build
- progresscomplete
- git
---

最近开始玩一个项目，结果gradle build总是报错：
```
FAILURE: Build failed with an exception.

* What went wrong:
Unable to process incoming event 'ProgressComplete ' (ProgressCompleteEvent)
```
参考了帖子[Build fails with “Unable to process incoming event ‘ProgressComplete ’ (ProgressCompleteEvent)”](https://discuss.gradle.org/t/build-fails-with-unable-to-process-incoming-event-progresscomplete-progresscompleteevent/18434)：
```
The Workaround:

use the --console plain gradle command line switch

The Fix:

If you use git + git-bash, upgrade to git 2.x.x (2.9.3 is current and works for me)
If you use DOS, try increasing your screen buffer size.(mine is 1024 x 1024)
```
将Git Window从2.9.0升级到2.15.0，问题不复重现。

