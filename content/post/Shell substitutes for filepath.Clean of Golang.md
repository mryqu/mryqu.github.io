---
title: 'GoLang语言filepath.Clean功能在AIX脚本中的实现'
date: 2021-02-23 12:31:23
categories: 
- Tool
- Linux
tags: 
- GoLang
- ksh
- perl
- filepath.Clean

---

GoLang语言filepath包Clean函数功能如下：  
1. Replace multiple Separator elements with a single one.
2. Eliminate each . path name element (the current directory).
3. Eliminate each inner .. path name element (the parent directory) along with the non-.. element that precedes it.
4. Eliminate .. elements that begin a rooted path: that is, replace "/.." by "/" at the beginning of a path, assuming Separator is '/'.

### perl等价功能

[File::Spec](https://metacpan.org/pod/File::Spec) 模块的canonpath函数与GoLang语言filepath包Clean函数功能基本类似，都不进行文件系统物理检查仅完成路径逻辑清理。  
No physical check on the filesystem, but a logical cleanup of a path.
```
$cpath = File::Spec->canonpath( $path ) ;
```
Note that this does *not* collapse x/../y sections into y. This is by design. 
If /foo on your system is a symlink to /bar/baz, then /foo/../quux is actually /bar/quux, not /quux as a naive ../-removal would give you. 
If you want to do this kind of processing, you probably want Cwd's realpath() function to actually traverse the filesystem cleaning up paths like this.

[Cwd](https://perldoc.perl.org/Cwd) 模块的realpath函数跟GNU realpath命令相同，会处理符号链接和相对路径。

### ksh等价实现

GNU realpath和readlink命令可以完成类似功能，但是AIX默认情况下是不会有GNU 命令的。


### 参考

* [How do you normalize a file path in Bash?](https://stackoverflow.com/questions/284662/how-do-you-normalize-a-file-path-in-bash)  