---
title: '[Git] 操作Git仓库已删除文件'
date: 2015-11-11 05:49:56
categories: 
- Tool
- Git
tags: 
- git
- deleted
- file
- find
- restore
---
忙着工作，忽然出了一下神，觉得自己对Git仓库已删除文件的操作还没有练习过，决定找资料学习一下。

### 列举所有Git仓库已删除文件

下列命令可以列举出所有提交信息及被删除的文件：
```
git log --diff-filter=D --summary
```

下列命令可以列举出所有被删除的文件，不显示提交信息：
```
git log --diff-filter=D --summary | grep delete
```

### 列举一个Git仓库已删除文件的提交历史信息

仅使用git log无法查看Git仓库已删除文件的提交历史信息。
```
git log  $deletedFile
fatal: ambiguous argument 'deletedFile': unknown revision or path not in the working tree.
```

下列命令则可以：
```
git log -- $deletedFile
```

### 恢复一个Git仓库已删除文件

找到删除该文件的提交哈希值
```
git rev-list -n 1 HEAD -- $deletedFile
```

通过删除该文件提交（$deletingCommit）的前一个提交($deletingCommit~1)恢复已删除文件:
```
git checkout $deletingCommit~1 -- $deletedFile
```

### 参考

[Is there a way in Git to list all deleted files in the repository](http://stackoverflow.com/questions/6017987/is-there-a-way-in-git-to-list-all-deleted-files-in-the-repository)  
[Git: Getting the history of a deleted file](https://dzone.com/articles/git-getting-history-deleted)  
[Find and restore a deleted file in a Git repository](http://stackoverflow.com/questions/953481/find-and-restore-a-deleted-file-in-a-git-repository)  
[Git：ls-files](https://git-scm.com/docs/git-ls-files/)  