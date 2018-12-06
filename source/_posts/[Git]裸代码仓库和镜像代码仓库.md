---
title: '[Git] 裸代码仓库和镜像代码仓库'
date: 2014-02-15 00:38:47
categories: 
- Tool
- Git
tags: 
- git
- clone
- init
- bare
- mirror
---
<font color="#787878">注：本文中操作都没有设置$GIT_DIR环境变量。</font>

### Git init和clone命令对bare和mirror参数的支持

||--bare参数|--mirror参数
|-----
|**git init命令**|支持|/
|**git clone命令**|支持|支持

### 裸代码仓库与普通代码仓库的区别

<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><th></th><th>普通代码仓库</th><th>裸代码仓库</th></tr><tr><td><b>git init命令</b></td><td>git init命令会创建一个空的Git代码仓库，一个在当前目录下包含hooks、info、objects和refs子目录和config、description和HEAD文件的.git目录。当前目录下可以创建工作树（工作文件和目录）。<br>config文件内容如下：<br><code>
[core]
  repositoryformatversion = 0
  filemode = false
  <font color="#FF0000">bare = false
  logallrefupdates = true</font>
  symlinks = false
  ignorecase = true
  hideDotFiles = dotGitOnly</code></td><td>git init --bare命令会创建一个空的裸Git代码仓库，当前目录下直接创建hooks、info、objects和refs子目录和config、description和HEAD文件。裸Git代码仓库只包含版本控制信息而不包含工作树。<br>config文件内容如下：<br><code>
[core]
  repositoryformatversion = 0
  filemode = false
 <font color="#FF0000"> bare = true</font>
  symlinks = false
  ignorecase = true
  hideDotFiles = dotGitOnly
</code></td></tr><tr><td><b>git clone命令</b></td><td>git clone命令会创建的一个包含.git子目录的目录，其中.git目录包含branches、hooks、info、logs、objects和refs子目录和config、description、HEAD、index和packed-refs文件。git clone命令所创建的目录中包含克隆的工作树（工作文件和目录）。<br>config文件内容如下：<br><code>
[core]
  repositoryformatversion = 0
  filemode = false
  <font color="#FF0000">bare = false
  logallrefupdates = true</font>
  symlinks = false
  ignorecase = true
  hideDotFiles = dotGitOnly
[remote "origin"]
  url = https://github.com/usr1/demo.git
  <font color="#FF0000">fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
  remote = origin
  merge = refs/heads/master
</font></code></td><td>git clone --bare命令会创建一个后缀为".git"的目录，直接包含hooks、info、objects和refs子目录和config、description和HEAD文件，不包含远程Git代码仓库的工作树。<br>config文件内容如下：<br><code>
[core]
  repositoryformatversion = 0
  filemode = false
  <font color="#FF0000">bare = true</font>
  symlinks = false
  ignorecase = true
  hideDotFiles = dotGitOnly
[remote "origin"]
  url = https://github.com/usr1/demo.git
</code></td></tr></tbody></table>

从技术的角度上讲，理论上无论Git代码仓库是否为裸代码仓库都可以接受push。可Git的策略是仅向裸代码仓库发送push。在Mercurial中，任何普通代码仓库都可以用于远程代码仓库，接受push。这是因为push所含的变化仅影响Mercurial代码仓库的版本控制，而不会影响其工作树。在Git中，如果向普通代码仓库push的话，Git会将推送的内容与工作文件进行比较，它会认为工作文件发生改变，从而影响工作树。而裸代码仓库由于没有工作树，所以push所含的变化仅影响裸代码仓库的版本控制。[Git FAQ](https://git.wiki.kernel.org/index.php/Git_FAQ)提到：**A quick rule ofthumb is to never push into a repository that has a work treeattached to it, until you know what you are doing.**

### 镜像代码仓库
git clone--mirror命令会创建一个后缀为".git"的目录，直接包含hooks、info、objects和refs子目录和config、description和HEAD文件，不包含远程Git代码仓库的工作树。config文件内容如下：
```
[core]
  repositoryformatversion = 0
  filemode = false
  bare = true
  symlinks = false
  ignorecase = true
  hideDotFiles = dotGitOnly
[remote "origin"]
  url = https://github.com/usr1/demo.git
  fetch = +refs/*:refs/*
  mirror = true
```

镜像代码仓库也是裸代码仓库，它与裸代码仓库的区别在于：它不仅将源代码仓库的本地分支映射到目标代码仓库的本地分支，而且将所有引用（包括远程跟踪分支、备注等）都进行映射并建立refspec配置以使目标代码仓库的所有引用可被gitremote update命令覆盖。裸代码仓库在克隆命令结束后，所有源代码仓库的本地分支映射到目标代码仓库的本地分支，但是不包含远程分支。它就被完全独立地建立，不再期望后继fetch操作，所有远程分支及其他引用会被忽略掉。镜像代码仓库类似源代码仓库被完整复制，当执行git remote update命令时类似源代码仓库再次被完整复制。

### 参考

[Git docs: init](http://git-scm.com/docs/git-init)    
[Git docs: clone](http://git-scm.com/docs/git-clone)    
[Git docs: Git Internals - The Refspec](http://git-scm.com/book/en/v2/Git-Internals-The-Refspec)    
[ Git docs: Git on the Server - Getting Git on a Server](http://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server)    
[ Git bare vs. non-bare repositories](http://bitflop.com/tutorials/git-bare-vs-non-bare-repositories.html)    
[ What's the difference between git clone --mirror and git clone --bare](http://stackoverflow.com/questions/3959924/whats-the-difference-between-git-clone-mirror-and-git-clone-bare)    
[ How do I view a git repo's receive history?](http://stackoverflow.com/questions/3876206/how-do-i-view-a-git-repos-receive-history)    