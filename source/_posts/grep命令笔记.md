---
title: 'grep命令笔记'
date: 2013-10-22 22:52:04
categories: 
- Tool
tags: 
- grep
- linux
- unix
---
使用grep时一直没有使用什么命令选项，这里过一遍grep帮助，试一遍不明白的选项。

### grep简介

grep是一种强大的文本搜索工具，它能使用正则表达式搜索文本，并把匹配的行打印出来。

### grep命令帮助
```
示例: grep -i 'hello world' menu.h main.c

正则选择和解释:
  -E, --extended-regexp     PATTERN为扩展正则表达式（ERE）
  -F, --fixed-strings       PATTERN是一套新行分割字符串
  -G, --basic-regexp        PATTERN为基本正则表达式（BRE）
  -P, --perl-regexp         PATTERN为Perl正则表达式
  -e, --regexp=PATTERN      使用PATTERN作为正则表达式
  -f, --file=FILE           从文件中获得PATTERN
  -i, --ignore-case         忽略大小写
  -w, --word-regexp         强制PATTERN仅匹配整个单词
  -x, --line-regexp         强制PATTERN仅匹配整行
  -z, --null-data           数据行以0字节而不是新行截至（打印整个文件了）

杂项:
  -s, --no-messages         抑制错误消息
  -v, --invert-match        选择非匹配行
  -V, --version             显示版本信息并退出
      --help                显示该帮助并退出
  -J, --bz2decompress       在进行搜索前解压缩bzip压缩输入
  -Z, --decompress          在进行搜索前解压缩输入(HAVE_LIBZ=1)
      --mmap                如可能使用内存映射输入

输出控制:
  -m, --max-count=NUM       在NUM个匹配后停止工作
  -b, --byte-offset         在输出行显示字节偏移
  -n, --line-number         显示行号
      --line-buffered       对每行都清除缓存强制输出
  -H, --with-filename       对每个匹配结果显示文件名
  -h, --no-filename         抑制输出中前缀的文件名
      --label=LABEL         将LABEL作为标准输入的文件名显示（输入为管道有用）
  -o, --only-matching       仅显示行匹配PATTERN部分
  -q, --quiet, --silent     抑制所有正常输出。通常用于脚本条件语句中，判断匹配结果是1还是0
      --binary-files=TYPE   将二进制文件假定为类型，分别为'binary'、'text'或
                            'without-match'。默认为'binary'，对二进制文件进行搜索
                            而不显示；'text'，一概视为文本文件，搜索并显示；
                            'without-match'，对二进制文件直接忽略，不搜索不显示。                            
  -a, --text                等同于--binary-files=text
  -I                        等同于--binary-files=without-match
  -d, --directories=ACTION  如何处理目录的操作项，分别为'read'、'recurse'或'skip'。
  -D, --devices=ACTION      如何处理设备、FIFO和socket的操作项，分别为'read'或'skip'。
  -R, -r, --recursive       等同于--directories=recurse
      --include=PATTERN     匹配PATTERN的文件将被检查
      --exclude=PATTERN     匹配PATTERN的文件将被忽略
      --exclude-from=FILE   匹配模式文件中PATTERN的文件将被忽略
  -L, --files-without-match 仅显示不包含匹配的文件名
  -l, --files-with-matches  仅显示包含匹配的文件名
  -c, --count               仅显示每个文件匹配行数
      --null                在文件名后显示0字节（跟不带这个选项就少一个冒号？）

上下文控制:
  -B, --before-context=NUM  输出匹配结果及其前NUM行
  -A, --after-context=NUM   输出匹配结果及其后NUM行
  -C, --context=NUM         输出匹配结果及其前后各NUM行
  -NUM                      等同--context=NUM
      --color[=WHEN],
      --colour[=WHEN]       使用标记突显匹配字符串，WHEN可为'always'、'never'或'auto'
                            默认项为'never'，'always'总是使用标记，而'auto'仅输出
                            在没有被管道到其他命令或重定向到文件时才使用标记。
  -U, --binary              在行结尾EOL不除去回车换行CR字符(MSDOS)
  -u, --unix-byte-offsets   如果没有回车换行则报告字节偏移(MSDOS)
```
