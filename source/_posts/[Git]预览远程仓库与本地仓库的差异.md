---
title: '[Git] 预览远程仓库与本地仓库的差异'
date: 2013-09-23 20:19:12
categories: 
- Tool
- Git
tags: 
- git
- preview
- diff
- remote
- local
---
首先使用`git fetch`更新远程分支的本地副本，这不会对任何本地分支造成影响。

使用`git log HEAD..origin`可以显示本地分支与origin远程分支之间的提交日志。

使用`git log -p HEAD..origin`除了显示上述提交日志外，还会显示每个提交的补丁。

使用`git diff HEAD...origin`显示整个补丁。此外如果有本地未提交的修改，可以使用`git diff origin/master`显示整个补丁。

如果不想使用`git pull`来合并所有远程提交，可以使用`git cherry-pick`接受所需要的指定远程提交。最后当准备好接受所有远程提交再使用`git pull`合并剩余远程提交。
