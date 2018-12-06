---
title: '[Git] 获取两个版本间所有变更的文件列表'
date: 2013-09-22 07:25:11
categories: 
- Tool
- Git
tags: 
- git
- diff
- --stat
- --name-status
---
git diff commit-SHA1 commit-SHA2 --name-status返回变更的文件列表，每个文件前带有变更状态：
- ' ' = unmodified
- M = modified
- A = added
- D = deleted
- R = renamed
- C = copied
- U = updated but unmergedgit diff commit-SHA1 commit-SHA2 --stat返回变更的文件列表，每个文件后面带有变更统计信息。