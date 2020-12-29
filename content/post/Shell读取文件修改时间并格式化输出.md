---
title: 'Shell读取文件修改时间并格式化输出'
date: 2020-12-23 12:31:23
categories: 
- Tool
- Linux
tags: 
- shell
- mtime
- format

---

最近有一些golang代码实现的功能需要移植到用于低版本AIX的korn shell上去。其中碰到了文件修改时间格式化问题。  
通过下面的golang示例代码可知最后需要的是本地时间而不是UTC时间。  
```
package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"time"
)

// Infrastructrue
var basedir string

func init() {
	exe, err := os.Executable()
	if err != nil {
		os.Exit(1)
	}
	basedir = filepath.Dir(exe)
}

func main() {
	fmt.Printf("now=%s\n", time.Now().Format("02Jan06:15:04:05"))
	fmt.Printf("now.UTC()=%s\n", time.Now().UTC().Format("02Jan06:15:04:05"))
	fmt.Printf("now.Local()=%s\n", time.Now().Local().Format("02Jan06:15:04:05"))

	f, ferr := os.Lstat(basedir)
	if ferr != nil {
		fmt.Printf("Unable to access %s. Skipping...\n", basedir)
		os.Exit(1)
	}

	mode := f.Mode()
	if mode&os.ModeSymlink != 0 {
		fmt.Printf("%s is a symbolic link; attempting to resolve...\n", basedir)
		// Try and resolve it
		resolved, err := os.Readlink(basedir)
		if err != nil {
			fmt.Printf("Unable to access %s. Skipping...\n", basedir)
			os.Exit(1)
		}
		log.Printf("Resolved %s to %s.\n", basedir, resolved)
		basedir = resolved
	}

	filepath.Walk(basedir, func(path string, info os.FileInfo, err error) error {
		// Any errors?
		if err != nil {
			// There were errors so let the user know we'll be skipping this path
			fmt.Printf("  Unable to access %s. Skipping...\n", path)
			return filepath.SkipDir
		}
		fmt.Printf("path=%s, mtime=%s\n", path, info.ModTime().Format("02Jan06:15:04:05"))
		fmt.Printf("path=%s, mtime.UTC()=%s\n", path, info.ModTime().UTC().Format("02Jan06:15:04:05"))
		fmt.Printf("path=%s, mtime.Local()=%s\n", path, info.ModTime().Local().Format("02Jan06:15:04:05"))

		return nil
	})
}
```

### AIX与Linux的区别
通过研究发现，AIX与Linux下通过`ls -l`均可获得不带秒数的修改时间，除此之外的实现还是有很大的不同的。  

Linux下通过stat获取文件信息，可以指定参数单独读取mtime。此外通过GNU date可以一步到位获得想要的格式化后修改时间。  
```
mryqulax> uname
Linux
mryqulax> ls -l metaparms.sas
-rw-r--r-- 1 scnydq r&d 914 Dec 16 22:08 metaparms.sas
mryqulax> stat metaparms.sas
  File: `metaparms.sas'
  Size: 914             Blocks: 8          IO Block: 32768  regular file
Device: d3h/211d        Inode: 2952318982  Links: 1
Access: (0644/-rw-r--r--)  Uid: (46654/  scnydq)   Gid: (  100/     r&d)
Access: 2020-12-19 20:26:12.453734000 -0500
Modify: 2020-12-16 22:08:49.237152000 -0500
Change: 2020-12-16 22:08:49.237152000 -0500
mryqulax> stat -c %y metaparms.sas
2020-12-16 22:08:49.237152000 -0500
mryqulax> stat -c %Y metaparms.sas
1608174529
mryqulax> date -r metaparms.sas "+%d%b%y:%H:%M:%S"
16Dec20:22:08:49
```

AIX下通过istat获取文件信息，无法单独读取mtime。AIX默认也没有安装GNU date。只能通过拼接字符串来获得最终的格式化后修改时间。  
```
$ uname
AIX
$ ls -l metaparms.sas
-rwxr-xr-x    1 scnydq   usr             910 Dec 21 20:38 metaparms.sas
$ istat metaparms.sas
Inode 4251 on device 10/8       File
Protection: rwxr-xr-x
Owner: 46654(scnydq)            Group: 100(usr)
Link count:   1         Length 910 bytes

Last updated:   Mon Dec 21 20:38:36 2020
Last modified:  Mon Dec 21 20:38:36 2020
Last accessed:  Wed Dec 23 01:07:29 2020

$ mtimeStr=$(istat metaparms.sas | grep "Last modified:" | sed -e 's/Last modified:[ 	]*//' -e 's/[ 	]*$//')
$ mtimeDate=$(echo $mtimeStr | cut -d' ' -f3)
$ mtimeMonth=$(echo $mtimeStr | cut -d' ' -f2)
$ mtimeYear=$(echo $mtimeStr | cut -d' ' -f5 | awk '{print substr($1,3,2)}')
$ echo "$mtimeDate$mtimeMonth$mtimeYear:$(echo $mtimeStr | cut -d' ' -f4)"
21Dec20:20:38:36
```

### AIX与Linux的通用解决方案

强制用户安装GNU date貌似不可取，而我又想尽可能在AIX与Linux通用。最后找到了一个解决方案就是用perl：）  
使用perl标准库的实现如下：  
```
# Linux
mryqulax> perl -le "use Time::Piece;print(localtime((stat shift)[9])->strftime('%d%b%y:%H:%M:%S'))" metaparms.sas
16Dec20:22:08:49

# AIX
$ perl -le "use Time::Piece;print(localtime((stat shift)[9])->strftime('%d%b%y:%H:%M:%S'))" metaparms.sas
21Dec20:20:38:36
```
