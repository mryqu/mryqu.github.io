---
title: '[Git] 分支笔记'
date: 2015-11-08 05:44:25
categories: 
- Tool
- Git
tags: 
- git
- remote
- branch
- checkout
- push
---
最近接触了一些Git远程分支的操作和管理，做个笔记。

- 创建本地分支
   ```
   git branch [branch]
   ```
- 切换本地分支
   ```
   git checkout [branch]
   ```
- 删除本地分支
   ```
   git branch -D [branch]
   ```
- 重命名本地分支
   ```
   git branch -m [oldbranch] [newbranch]
   ```
- 查看分支
   ```
   # 查看本地分支 （-v选项可以显示sha1和提交消息标题）
   git branch
   git branch -v
   
   # 查看远程分支
   git branch -r
   git branch -rv
   
   # 查看本地和远程分支
   git branch -a
   git branch -av
   ```
- 向远程分支推送（远程分支不存在则会创建远程分支）
   ```
   # 期望本地分支与远程分支同名，可以先切换到本地分支进行提交
   git push [remote] [branch]
   
   # 通过-u选项同时使新创建的远程分支成为本地分支的上游分支
   git push -u [remote] [branch]
   
   # 期望本地分支与远程分支使用不同名称
   git push [remote] [localbranch]:[remotebranch]
   # 例子： git push origin v9:v9
   ```
- 使用存在的远程分支创建本地分支，远程分支也成为新创建的本地分支的上游分支
   ```
   # 期望本地分支与远程分支同名 
   git checkout --track [remote]/[remotebranch]
   # 例子： git checkout --track origin/v9
   # 当git checkout [branch]执行时，本地分支不存在且仅与一个远程分支名匹配事，
   # 其效果等同上面--track选项。
   
   # 期望本地分支与远程分支使用不同名称
   git checkout -b [localbranch] [remote]/[remotebranch]
   # 例子： git checkout -b v9test origin/v9
   ```
- 本地分支和远程分支都存在的情况下，使远程分支也成为本地分支的上游分支
   ```
   # 使远程分支成为当前本地分支的上游分支
   git branch -u [remote]/[remotebranch]
   
   # 使远程分支成为某一特定本地分支的上游分支
   git branch --set-upstream-to=[remote]/[remotebranch] [localbranch]
   ```
- 去除本地分支的上游分支
   ```
   git branch --unset-upstream [branch]
   ```
- 删除远程分支
   ```
   git push [remote] :[remotebranch]
   # 或
   git push --delete [remote] [remotebranch]
   ```
- 在本地库删除已废弃的远程分支
   ```
   # 远程分支被别人删除后，自己本地库中该远程分支为废弃状态，可使用下列命令移除该远程分支
   git remote prune [remote]
   ```

### 参考

[Git Branching - Branches in a Nutshell](https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell)  
[Git Branching - Basic Branching and Merging](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)  
[Git Branching - Branch Management](https://git-scm.com/book/en/v2/Git-Branching-Branch-Management)  
[Git Branching - Branching Workflows](https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows)  
[Git Branching - Remote Branches](https://git-scm.com/book/en/v2/Git-Branching-Remote-Branches)  
[Git Branching - Rebasing](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)  
[Git Branching - Summary](https://git-scm.com/book/en/v2/Git-Branching-Summary)  
[Git - Branch](https://git-scm.com/docs/git-branch)  
[Git - Checkout](https://git-scm.com/docs/git-checkout)  