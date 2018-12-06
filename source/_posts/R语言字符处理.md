---
title: 'R语言字符处理'
date: 2013-07-13 22:36:49
categories: 
- DataScience
tags: 
- R语言
- 字符
- 处理
- 函数
---
<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;min-width:400px"><tbody><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">字符处理</td></tr><tr><td style="vertical-align: top;">Encoding(x)<br>Encoding(x) <- value<br><br>enc2native(x)<br>enc2utf8(x)<br>读取或设置字符向量的编码</td><td style="vertical-align: top;"><pre style="margin: 0;">> ## x is intended to be in latin1
> x <- "fa\xE7ile"
> Encoding(x)
[1] "latin1"
> Encoding(x) <- "latin1"
> xx <- iconv(x, "latin1", "UTF-8")
> Encoding(c(x, xx))
[1] "latin1" "UTF-8"
> Encoding(xx) <- "bytes" # will be encoded in hex
> cat("xx = ", xx, "\n", sep = "")
xx = fa\xc3\xa7ile</pre></td></tr><tr><td style="vertical-align: top;">nchar(x, type = "chars", allowNA = FALSE)<br>返回字符长度，在我的测试中allowNA参数没有作用？<br>nzchar(x) 判断是否空字符<br><br>对于缺失值NA，nchar和nzchar函数认为是字符数为2的字符串。<br>所以在对字符串进行测量之前，最好先使用is.na()函数判断一下是否是NA。<br>对于NULL，nchar和nzchar函数会忽略掉。</td><td style="vertical-align: top;"><pre style="margin: 0;">> nchar(c("em","yqu","",NA))
[1] 2 3 0 2
> nzchar(c("em","yqu","",NA))
[1] TRUE TRUE FALSE TRUE > nzchar(c("em","yqu",NULL,"",NA))
[1] TRUE TRUE FALSE TRUE
> nchar(c("em","yqu",NULL,"",NA))
[1] 2 3 0 2
> nchar(NULL)
integer(0)
> nzchar(NULL)
logical(0)</pre></td></tr><tr><td style="vertical-align: top;">substr(x, start, stop)<br>substring(text, first, last = 1000000L)<br>substr(x, start, stop) <- value<br>substring(text, first, last = 1000000L) <- value<br>提取或替换字符向量的子字段，substring同substr功能一样，兼容S语言。<br>参数start大于stop时，抽取时返回""，替换时无操作。<br>如果x包含NA，对应结果为NA。</td><td style="vertical-align: top;"><pre style="margin: 0;">> substr("abcdef", 2, 4)
[1] "bcd"
> substr("abcdef", -3, 9)
[1] "abcdef"
> substring("abcdef", 1:6, 1:6)
[1] "a" "b" "c" "d" "e" "f"
> x <-c("asfef", "qwerty", "yuiop[", "b", "stuff.blah.yech")
> substring(x, 2, 4:5)
[1] "sfe" "wert" "uio" "" "tuf"</pre></td></tr><tr><td style="vertical-align: top;">strtrim(x, width)<br>按显示宽度截断字符串</td><td style="vertical-align: top;"><pre style="margin: 0;">> x<-c("abcdef",NA,"66")
> strtrim(x,c(2,1,3))
[1] "ab" NA "66"</pre></td></tr><tr><td style="vertical-align: top;">paste (..., sep = " ", collapse = NULL)<br>paste0(..., collapse = NULL)<br>通过sep连接间隔连接对象,返回字符串向量<br>设定collapse的话，会通过collapse连接间隔<br>将上一步的字符串向量连接成一个字符串<br>paste0(..., collapse)等同于paste(..., sep = "", collapse)</td><td style="vertical-align: top;"><pre style="margin: 0;">> paste(1:6) # same as as.character(1:6)
[1] "1" "2" "3" "4" "5" "6"
> paste("A", 1:6, sep = "=")
[1] "A=1" "A=2" "A=3" "A=4" "A=5" "A=6"
> paste("A", 1:6, sep = "=", collapse=";")
[1] "A=1;A=2;A=3;A=4;A=5;A=6"</pre></td></tr><tr><td style="vertical-align: top;">strsplit(x, split, fixed = FALSE, perl = FALSE, useBytes = FALSE)<br>基于split子句分割字符向量x<br>fixed为TRUE的话，完全匹配split；<br>否则，基于正则表达式<br>可以使用split=NULL来分割每个字符。</td><td style="vertical-align: top;"><pre style="margin: 0;">> x <- c(as = "mfe", qu = "qwerty", "70", "yes")
> strsplit(x, "e")
$as
[1] "mf"

$qu
[1] "qw" "rty"

[[3]]
[1] "70"

[[4]]
[1] "y" "s"

> strsplit("Hello world!", NULL)
[[1]]
[1] "H" "e" "l" "l" "o" " " "w" "o" "r" "l" "d" "!"
> ## Note that 'split' is a regexp!
> unlist(strsplit("a.b.c", "."))
[1] "" "" "" "" ""
> ## If you really want to split on '.', use
> unlist(strsplit("a.b.c", "[.]"))
[1] "a" "b" "c"
> unlist(strsplit("a.b.c", ".", TRUE))
[1] "a" "b" "c"</pre></td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">字符转换和大小写转换</td></tr><tr><td style="vertical-align: top;">chartr(old, new, x)<br>将x中的字符old变换为字符new<br></td><td style="vertical-align: top;"><pre style="margin: 0;">> x <- "MiXeD cAsE 123"
> chartr("iXs", "why", x)
[1] "MwheD cAyE 123"
> chartr("a-cX", "D-Fw", x)
[1] "MiweD FAsE 123"</pre></td></tr><tr><td style="vertical-align: top;">tolower(x)<br>toupper(x)<br>casefold(x, upper = FALSE)<br>casefold是为了兼容S-PLUS而实现的tolower和toupper函数封装器。</td><td style="vertical-align: top;"><pre style="margin: 0;">> x <- "MiXeD cAsE 123"
> tolower(x)
[1] "mixed case 123"
> toupper(x)
[1] "MIXED CASE 123"</pre></td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">格式化输出</td></tr><tr><td style="vertical-align: top;">sprintf(fmt, ...) 系统C库函数sprintf封装器</td><td style="vertical-align: top;"><pre style="margin: 0;">> sprintf("%s is %f feet tall\n", "Sven", 7.1)
[1] "Sven is 7.100000 feet tall\n"</pre></td></tr><tr><td style="vertical-align: top;">format 格式化输出<br>formatC 格式化（C语言风格）输出</td><td style="vertical-align: top;"></td></tr><tr><td style="vertical-align: top;">strwrap(x, width = 0.9 * getOption("width"),<br>indent = 0, exdent = 0, prefix = "",<br>simplify = TRUE, initial = prefix)<br>将字符串封装成格式化段落</td><td style="vertical-align: top;"><pre style="margin: 0;">> str <- "Now is the time "
> strwrap(str, width=60,indent=1)
[1] " Now is the time"
> strwrap(str, width=60,indent=2)
[1] " Now is the time"
> strwrap(str, width=60,indent=3)
[1] " Now is the time"
> strwrap(str, prefix="kx>")
[1] "kx>Now is the time"</pre></td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">字符串匹配</td></tr><tr><td style="vertical-align: top;">pmatch(x, table, nomatch = NA_integer_, duplicates.ok = FALSE)<br>局部字符串匹配，返回匹配的下标。<br><br>pmatch的行为因duplicates.ok参数而异。<br>当duplicates.ok为TRUE，有完全匹配的情况返回第一个完全匹配的下标，否则有唯一一个局部匹配的情况返回该唯一一个局部匹配的下标，没有匹配则返回nomatch参数值。<br>空字符串与任何字符串都不匹配，甚至是空字符串。<br>当duplicates.ok为FALSE，table中的值一旦匹配都被排除用于后继匹配，空字符串例外。<br>NA被视为字符常量"NA"。</td><td style="vertical-align: top;"><pre style="margin: 0;">> pmatch(c("", "ab", "ab"), c("abc", "ab"), dup = FALSE)
[1] NA 2 1
> pmatch(c("", "ab", "ab"), c("abc", "ab"), dup = TRUE)
[1] NA 2 2
> pmatch("m", c("mean", "median", "mode")) # returns NA
[1] NA</pre></td></tr>
<tr><td style="vertical-align: top;">charmatch(x, table, nomatch = NA_integer_)<br>局部字符串匹配，返回匹配的下标。<br><br>charmatch与uplicates.ok为TRUE的pmatch近似，当有单个完全匹配的情况返回该完全匹配的下标，否则有唯一一个局部匹配的情况返回该唯一一个局部匹配的下标，有多个完全匹配或局部匹配返回0，没有匹配则返回nomatch参数值。<br>charmatch允许匹配空字符串。<br>NA被视为字符常量"NA"。</td>
<td style="vertical-align: top;"><pre style="margin: 0;">> charmatch(c("", "ab", "ab"), c("abc","ab"))
[1] 0 2 2
> charmatch("m", c("mean", "median", "mode")) # returns 0
[1] 0</pre></td></tr><tr><td style="vertical-align: top;">match(x, table, nomatch = NA_integer_, incomparables = NULL)<br>x %in% table<br>值匹配，不限于字符串</td><td style="vertical-align: top;"><pre style="margin: 0;">> sstr <-c("e","ab","M",NA,"@","bla","P","%")
> sstr[sstr %in% c(letters, LETTERS)]
[1] "e" "M" "P"</pre></td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">模式匹配和替换</td></tr><tr><td style="vertical-align: top;">grep(pattern,x,ignore.case=FALSE,<br>perl=FALSE,value=FALSE,fixed=FALSE,<br>useBytes=FALSE,invert=FALSE)<br>返回匹配下标<br>grepl(pattern,x,ignore.case=FALSE,<br>perl=FALSE,fixed=FALSE,useBytes=FALSE)<br>返回匹配逻辑结果<br>sub(pattern,replacement,x,ignore.case=FALSE,<br>perl=FALSE,fixed=FALSE,useBytes=FALSE)<br>替换第一个匹配的字符串<br>gsub(pattern,replacement,x,ignore.case=FALSE,<br>perl=FALSE,fixed=FALSE,useBytes=FALSE)<br>替换全部匹配的字符串<br>regexpr(pattern,text,ignore.case=FALSE,<br>perl=FALSE,fixed=FALSE,useBytes=FALSE)<br>返回第一个匹配的下标和匹配长度<br>gregexpr(pattern,text,ignore.case=FALSE,<br>perl=FALSE,fixed=FALSE,useBytes=FALSE)<br>返回全部匹配的下标和匹配长度<br>regexec(pattern,text,ignore.case=FALSE,<br>fixed=FALSE,useBytes=FALSE)<br>返回第一个匹配的下标和匹配长度<br><br>这些函数(除了不支持Perl风格正则表达式的regexec函数)可以工作在三种模式下:<ol><li>fixed = TRUE: 使用精确匹配</li><li>perl = TRUE: 使用Perl风格正则表达式</li><li>fixed = FALSE且perl = FALSE: 使用POSIX 1003.2扩展正则表达式</li></ol>useBytes = TRUE时逐字节匹配，否则逐字符匹配。<br>其主要作用是避免对多字节字符码中无效输入和虚假匹配的错误/告警,但是对于regexpr，它改变了输出的解释。<br>它会阻止标记编码的输入进行转换，尤其任一输入被标记为“字节”时强制禁止转换。</td><td style="vertical-align: top;"><pre style="margin: 0;">> str<-c("Now is ","the"," time ")
> grep(" +", str)
[1] 1 3
> grepl(" +", str)
[1] TRUE FALSE TRUE
> sub(" +", "", str)
[1] "Nowis " "the" "time "
> sub("[[:space:]]+", "", str) ## white space, POSIX-style
[1] "Nowis " "the" "time "
> sub("\\s+", "", str, perl = TRUE) ## Perl-style white space
[1] "Nowis " "the" "time "
> gsub(" +", "", str)
[1] "Nowis" "the" "time"
> regexpr(" +", str)
[1] 4 -1 1
attr(,"match.length")
[1] 1 -1 1
attr(,"useBytes")
[1] TRUE
> gregexpr(" +", str)
[[1]]
[1] 4 7
attr(,"match.length")
[1] 1 1
attr(,"useBytes")
[1] TRUE

[[2]]
[1] -1
attr(,"match.length")
[1] -1
attr(,"useBytes")
[1] TRUE

[[3]]
[1] 1 6
attr(,"match.length")
[1] 1 2
attr(,"useBytes")
[1] TRUE

> regexec(" +", str)
[[1]]
[1] 4
attr(,"match.length")
[1] 1

[[2]]
[1] -1
attr(,"match.length")
[1] -1

[[3]]
[1] 1
attr(,"match.length")
[1] 1</pre></td></tr><tr><td style="vertical-align: top;">regmatches(x, m, invert = FALSE)<br>regmatches(x, m, invert = FALSE) <- value<br>抽取或替换正则表达式匹配子串<br>invert = TRUE则抽取或替换不匹配子串</td><td style="vertical-align: top;"><pre style="margin: 0;">> str<-c("Now is ","the"," time ")
> m<-regexpr(" +",str)
> regmatches(str,m)<- "kx"
> str
[1] "Nowkxis " "the" "kxtime "
>
> str<-c("Now is ","the"," time ")
> m<-gregexpr(" +",str)
> regmatches(str,m, invert=TRUE)<- "kx"
> str
[1] "kx kx kx" "kx" "kx kx kx"</pre></td></tr><tr><td style="vertical-align: top;">agrep(pattern, x, max.distance = 0.1,<br>costs = NULL, ignore.case = FALSE,<br>value = FALSE, fixed = TRUE,<br>useBytes = FALSE)<br><br>agrepl(pattern, x, max.distance = 0.1,<br>costs = NULL, ignore.case = FALSE,<br>fixed = TRUE, useBytes = FALSE)<br><br>使用广义Levenshtein编辑距离进行字符串近似匹配待进一步研究</td><td style="vertical-align: top;"><pre style="margin: 0;">> str <- c("1 lazy", "1", "1 LAZY")
> agrep("laysy", str, max = 2)
[1] 1</pre></td></tr><tr><td style="vertical-align: top;">grepRaw(pattern, x, offset = 1L,<br>ignore.case = FALSE, value = FALSE,<br>fixed = FALSE, all = FALSE,<br>invert = FALSE)<br>对原始数据向量进行模式匹配</td><td style="vertical-align: top;"><pre style="margin: 0;">> raws <- charToRaw("Now is the time ")
> raws
[1] 4e 6f 77 20 69 73 20 74 68 65 20 74 69 6d 65 20
> grepRaw(charToRaw(" +"),raws)
[1] 4</pre></td></tr><tr><td style="vertical-align: top;">glob2rx(pattern, trim.head = FALSE, trim.tail = TRUE)<br>将通配符模式变成正则表达式</td><td style="vertical-align: top;"><pre style="margin: 0;">> glob2rx("abc.*")
[1] "^abc\\."
> glob2rx("a?b.*")
[1] "^a.b\\."
> glob2rx("a?b.*", trim.tail = FALSE)
[1] "^a.b\\..*$"
> glob2rx("*.doc")
[1] "^.*\\.doc$"
> glob2rx("*.doc", trim.head = TRUE)
[1] "\\.doc$"
> glob2rx("*.t*")
[1] "^.*\\.t"
> glob2rx("*.t??")
[1] "^.*\\.t..$"
> glob2rx("*[*")
[1] "^.*\\["</pre></td></tr></tbody></table>