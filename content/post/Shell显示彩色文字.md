---
title: 'Shell显示彩色文字'
date: 2020-11-26 08:25:00
categories: 
- Tool
- Linux
tags: 
- korn
- shell
- color
---

昨天学习一下如何使用shell在屏幕显示彩色文字。解决方案有两种：1. 转义字符 2. tput设置文本颜色。  
在Linux上这两种方式都正常工作，在FreeBSD上第二种方式不起作用。  
代码如下：  

```
#!/bin/ksh

println() {
  printf "%s\n" $*
}

##########################
# Solution 1
##########################

colorsEnabled() {
  if [ $TERM == 'TERM' ]
  then
    return 0
  fi
  return 1
}

printlnColor() {
  c=$1
  shift
  msg=$*;
  colorsEnabled
  if [ $? == 1 ]
  then
    printf "\033[0;%dm%s\033[0m\n" $c "$msg"
  else
    printf "%s\n" "$msg"
  fi
}

# Success
printlnSuccess() {
  printlnColor 32 $*
}

# Warning
printlnWarning() {
  printlnColor 33 $*
}

# Failure
printlnFailure() {
  printlnColor 31 $*
}

# Verbose
printlnVerbose() {
  printlnColor 35 $*
}

# Emphasis
printlnEmphasis() {
  printlnColor 36 $*
}

# Note
printlnNote() {
  printlnColor 37 $*
}

##########################
# Solution 2
##########################

println_color() {
  c=$1
  shift
  msg=$*;
  tput setaf $c
  printf "%s\n" "$msg"
  tput sgr0
}

# Success
println_success() {
  println_color 2 $*
}

# Warning
println_warning() {
  println_color 3 $*
}

# Failure
println_failure() {
  println_color 1 $*
}

# Verbose
println_verbose() {
  println_color 5 $*
}

# Emphasis
println_emphasis() {
  println_color 6 $*
}

# Note
println_note() {
  println_color 7 $*
}


printlnEmphasis hahaha 123
echo "====================="
println_emphasis hahaha 123
```

### 参考

* [ANSI Escape sequences](http://ascii-table.com/ansi-escape-sequences.php)  
* [Git shell coloring · GitHub](https://gist.github.com/vratiu/9780109)  
* [tput](http://linuxcommand.org/lc3_adv_tput.php)  