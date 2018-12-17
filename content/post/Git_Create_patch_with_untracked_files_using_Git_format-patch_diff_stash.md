---
title: '[Git] Create patch with untracked files using Git format-patch/diff/stash'
date: 2015-01-26 20:03:22
categories: 
- Tool
- Git
tags: 
- git
- patch
- format-patch
- diff
- stash
---
### Setup testing environment

I created 123.txt at branch master, then modified 123.txt and added321.txt at branch yqu
```
C:\test>mkdir GitTest

C:\test>cd GitTest

C:\test\GitTest>git init
Initialized empty Git repository in C:/test/GitTest/.git/

C:\test\GitTest>echo "this is a file at mast branch" > 123.txt

C:\test\GitTest>git add 123.txt

C:\test\GitTest>git commit -m "initial commit"
[master (root-commit) f140825] initial commit
 1 file changed, 1 insertion(+)
 create mode 100644 123.txt

C:\test\GitTest>git push origin HEAD:master

C:\test\GitTest>git checkout -b yqu
Switched to a new branch 'yqu'

C:\test\GitTest>echo "bye" >> 123.txt

C:\test\GitTest>echo "this is new file at branch yqu" > 321.txt
```

### Try patch-format

```
C:\test\GitTest>git format-patch master
```

patch-format command only works for committed files.

### Try diff

![[Git] Create patch with untracked files using Git format-patch/diff/stash](/images/2015/1/0026uWfMgy6PvD6KZIW26.png) "git diff" is used for unstaged changes, "gitdiff --cached" is used for staged changes, neither includeuntracked files.

### Try stash

![[Git] Create patch with untracked files using Git format-patch/diff/stash](/images/2015/1/0026uWfMgy6PvD8qEm90d.png)The above "git stash" and "git show" commands can satisfy the requirement.

### Solution

```
git stash show -p > patch
git show fd056bfee6b7129f916f81247f39a4d39d27b466 >>patch
```

### Reference

[How to create and apply a patch with Git](https://ariejan.net/2009/10/26/how-to-create-and-apply-a-patch-with-git/)  
[Create a git patch from the changes in the current working directory](http://stackoverflow.com/questions/5159185/create-a-git-patch-from-the-changes-in-the-current-working-directory)  
[Can I use git diff on untracked files?](http://stackoverflow.com/questions/855767/can-i-use-git-diff-on-untracked-files)  
[In git, is there a way to show untracked stashed files without applying the stash?](http://stackoverflow.com/questions/12681529/in-git-is-there-a-way-to-show-untracked-stashed-files-without-applying-the-stas)  
[Git stash to patch with untracked files](http://stackoverflow.com/questions/22818155/git-stash-to-patch-with-untracked-files)  
[How to recover from “git stash save --all”?](http://stackoverflow.com/questions/20586009/how-to-recover-from-git-stash-save-all/)  