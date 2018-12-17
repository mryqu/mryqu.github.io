---
title: 'Markdown介绍'
date: 2014-02-19 22:39:56
categories: 
- Tech
tags: 
- markdown
- rmarkdown
- knitr
- 文艺编程
- 可重复性研究
---
Markdown是一种用于普通文本的便于读写的轻量级标记语言，可以转换成HTML、LaTeX或Docbook文档。很多网站都支持Markdown，如GitHub、Wikipedia和博客平台WordPress。RMarkdown将R代码和markdown进行有效集成以用于文学编程（LiterateProgramming），R代码会在RMarkdown转化markdown处理过程中被执行，并将R代码结果一同插入markdown文档。下面的示例是基于knitr工具完成RMarkDown转换的。

# Markdown

## 文字样式：斜体和粗体、删除线

```
*斜体表述1* 和 _斜体表述2_ 示例。
**粗体表述1** 和 __粗体表述2__ 示例。
___斜粗体表述1___ 和 ***斜粗体表述2*** 示例。
~~删除线表述~~ 示例。
```

_斜体表述1_ 和 _斜体表述2_ 示例。**粗体表述1** 和 **粗体表述2** 示例。**_斜粗体表述1_** 和 **_斜粗体表述2_**示例。~~删除线表述~~ 示例。

## 段落和换行

一个空行（两个回车）会被转换成分段，在行末加两个或多个空格会被转换成换行。

## 标题
```
在行首用一到六个井号 (#) 开始该行为标题行  
# H1示例  
## H2示例  
### H3示例  
#### H4示例  
##### H5示例  
###### H6示例   
```

# H1示例

## H2示例

### H3示例

#### H4示例

##### H5示例

###### H6示例


另一种方式用下一行的一到多个等号表示一级标题，一到多个短划线表示二级标题。  
```
H1示例  
=========
H2示例  
---------   
```

H1示例  
=========
H2示例  
--------- 

## 水平分割线

通过单行输入3个或3个以上中短划线、星号或下划线进行输入水平分隔线, 短划线、星号或下划线之间可以包含空格：
```
---
***
___
- - -
*  *  *
_ _ _
```

---
***
___
- - -
*  *  *
_ _ _


## 列表

HTML 列表分无序列表 (unordered list, ul) 和有序列表 (ordered list, ol) 两种。在Markdown 中用星号、加号、减号开始一行表示无序列表，用数字开始一行表示有序列表。例如：
```
无序列表示例
- 无序列表1
 
+ 无序列表2
 
* 无序列表3
```
- 无序列表1
- 无序列表2
- 无序列表3

嵌套列表示例，下一级列表需较当前列表级增加4个空格缩进。
```
- 无序列表级1
    - 无序列表级2
+ 无序列表级1
    + 无序列表级2
* 无序列表级1
    * 无序列表级2
```
- 无序列表级1
  - 无序列表级2
- 无序列表级1
  - 无序列表级2
- 无序列表级1
  - 无序列表级2

```
有序列表示例 
1. 有序列表
2. 有序列表 
3. 有序列表
```

1. 有序列表
2. 有序列表 
3. 有序列表

## 表格
```
| 左对齐列       | 居中对齐列       | 右对齐列  |  
| :------------- |:----------------:| ---------:|  
| col 7 is       | thanks, bye bye  | $2012     |  
| col 123 is     | centered         |   $14     |  
| zebra stripes  | are neat         |    $1      |  
```

| 左对齐列       | 居中对齐列       | 右对齐列  |  
| :------------- |:----------------:| ---------:|  
| col 7 is       | thanks, bye bye  | $2012     |  
| col 123 is     | centered         |   $14     |  
| zebra stripes  | are neat         |    $1     |


## 代码及代码块

使用\`printf()\`函数，转换后的printf()会在HTML的code标签体内.
如果一到多行代码段每行前使用4个空格对齐，标准MD就会识别为代码段。

## 引用块

用右尖括号 (>) 表示 blockquote，你一定见过邮件中这样表示引用别人的内容。可以嵌套，可以包含其它的Markdown 元素，例如：
```
> ## This is a header.
>
> 1.   This is the first list item.
> 2.   This is the second list item.
>
> Here's some example code:
>
>     return shell_exec("echo $input | $markdown_script");
```

> ## This is a header.
>
> 1.   This is the first list item.
> 2.   This is the second list item.
>
> Here's some example code:
>
>     return shell_exec("echo $input | $markdown_script");

## 链接

### 链接
```
[Download R] (http://www.r-project.org/ )
[RStudio] (http://www.rstudio.com/ )
```

[Download R](http://www.r-project.org/)  
[RStudio](http://www.rstudio.com/)  

### 高级链接
```
两个网址 [R bloggers][1] 和 [Simply Statistics][2] 值得关注！
[1]: http://www.r-bloggers.com/   "R bloggers"  
[2]: http://simplystatistics.org/ "Simply Statistics" 
```

两个网址 [R bloggers](http://www.r-bloggers.com/) 和 [Simply Statistics](http://simplystatistics.org/) 值得关注！

### 自动URL连接
```
当MD中存在URL，转换后的HTML会包含其链接。
http://example.com
```
http://example.com

## 反斜杠

Markdown可以利用反斜杠来消除Markdown语法中的标记。例如：如果期望最终HTML的字符串两侧外包星号，可以在星号的前面加上反斜杠消除粗体转换：
```
\*literal asterisks\*
*literal asterisks*
```

\*literal asterisks\*
*literal asterisks*

# RMarkdown

下列是RMarkdown特有的R代码段。
<code>\`\`\`{r echo=TRUE}
plot(sin, -pi, 2 * pi)
\`\`\`</code>

plot(sin, -pi, 2 * pi)
![plot of chunk unnamed-chunk-2](/images/2014/2/0026uWfMgy6Jgv6ukcl5d.jpg)

# knitr

RStudio对knitr有很好的集成，可以通过工具栏完成对RMarkdown文件进行编译生成md和html文件，还可以发布到[RPubs](http://rpubs.com/)网站上。
但有时候烦懒只想用RGui，可以通过下列命令使用knitr：
```
library(knitr)
setwd(working directory)
knit2html("test.Rmd")
browseURI("test.html")
```

# 引用

[Markdown语法](http://daringfireball.net/projects/markdown/syntax)  
[GitHub: Markdown基础](https://help.github.com/articles/markdown-basics)  
[GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown)  
[Knitr with R Markdown](http://kbroman.github.io/knitr_knutshell/pages/Rmarkdown.html)  
[文艺编程 Literate Programming](http://legendsland.wordpress.com/2012/06/06/literate-programming-%E6%96%87%E8%89%BA%E7%BC%96%E7%A8%8B/)  
