---
title: 'GitHub fork操作'
date: 2014-03-17 22:37:40
categories: 
- Tool
- Git
tags: 
- github
- fork
- push_request
- upstream
- origin
---
[Fork（分支）操作](https://help.github.com/articles/fork-a-repo)不是Git实现的一部分，仅是GitHub独有的一个在服务器端克隆代码库的操作。假定我作为GitHub用户usr2，对用户usr1的github.com/usr1/demo代码库有兴趣。我可以通过clone命令将该代码库克隆到本机，并且可以通过pull命令获得该代码库的更新。但是除非用户usr1将我（用户usr2）设为该代码库的贡献者，否则我无法将我提交的修改通过push命令推送到该代码库。但是通过fork操作，我就可以将github.com/usr1/demo代码库完整复制到我的GitHub帐号下（包括代码库中的文件、提交历史、问题等等），例如下图的github.com/usr2/demo。我可通过clone命令将自己的github.com/usr2/demo代码库克隆到本机，我完全有权限将本机提交的修改通过push命令推送到上述自己的代码库。如果我希望我的修改被usr1采纳，我可以发送一个pullrequest通知usr1。至于usr1是否接收我的修改，决定权在usr1。![GitHub fork操作](/images/2014/3/0026uWfMgy6R0c2nfXU26.jpg)克隆代码库的时候，所使用的远程代码库地址自动被Git命名为origin。其效果类似于：

```
git remote add origin git://github.com/usr2/demo.git
```


github.com/usr2/demo代码库在fork操作之后就不再获得github.com/usr1/demo的后继更新了。可以手工添加github.com/usr1/demo为上游代码库地址：
```
git remote add upstream git://github.com/usr1/demo.git
```

我可通过fetch命令获取上游代码库的更新，在本机合并后，通过push命令推送到自己的远程代码库。

### 参考

[GitHub help: Fork A Repo](https://help.github.com/articles/fork-a-repo)    
[GitHub help: Syncing a fork](https://help.github.com/articles/syncing-a-fork/)    
[ GitHub help: Adding collaborators to a personal repository](https://help.github.com/articles/adding-collaborators-to-a-personal-repository/)    
[ Simple guide to forks in GitHub and Git](http://www.dataschool.io/simple-guide-to-forks-in-github-and-git/)    
[stackOverflow: Git fork is git clone?](http://stackoverflow.com/questions/6286571/git-fork-is-git-clone)    
[ stackOverflow: What is the difference between origin and upstream in github](http://stackoverflow.com/questions/9257533/what-is-the-difference-between-origin-and-upstream-in-github/9257901)    