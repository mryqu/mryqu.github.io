---
title: '安装Gerrit的commit-msg钩子'
date: 2015-08-19 05:34:23
categories: 
- Tool
- Git
tags: 
- gerrit
- git
- commit-msg
- hook
- change-id
---
对Gerrit进行首次提交前需要安装commit-msg钩子，每次总忘，每次都总是搜邮件，还是记博客里方便些。
```
gitdir=$(git rev-parse --git-dir); scp -p -P 29418 [your username]@[your Gerrit review server]:hooks/commit-msg {gitdir}/hooks/
```

参考

[Gerrit：commit-msg Hook](http://gerrit-documentation.googlecode.com/svn/Documentation/2.2.2/cmd-hook-commit-msg.html)  
[Gerrit工作流](http://openwares.net/linux/gerrit_workflow.html)  