---
title: 'Shell之rev与tac'
date: 2020-12-29 12:31:23
categories: 
- Tool
- Linux
tags: 
- shell
- rev
- tac

---

今天想把一个文件内容反序输出，就找到了rev与tac这两个命令。  

* rev是对每一行内容进行反序，行序不变  
* tac是对行序反序, 每一行内容不变  

```
mryqulax> cat test.log
whoami
123
mryqulax> rev test.log
imaohw
321
mryqulax> tac test.log
123
whoami
```
