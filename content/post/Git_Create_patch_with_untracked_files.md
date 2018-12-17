---
title: '[Git] Create patch with untracked files'
date: 2015-01-27 20:10:27
categories: 
- Tool
- Git
tags: 
- git
- add
- untracked
- diff
- reset
---
前一博文[Create patch with untracked files using Git format-patch/diff/stash](/post/git_create_patch_with_untracked_files_using_git_format-patchdiffstash)中的方案比较绕，今天有了一个更好一点的法子:

```
git add .
git diff --cached > yqu.patch
git reset origin/master

```

