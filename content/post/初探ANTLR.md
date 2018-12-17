---
title: '初探ANTLR'
date: 2013-07-03 20:25:21
categories: 
- Tech
tags: 
- antlr
- eclipse
- ant
- maven
- 编译器
---
当前的项目是基于多维数据集市的RTOLAP财务系统，其中的公式使用[ANTLR 3](http://www.antlr3.org/)进行语法解析和编译。
此外看Hibernate源码的时候也接触到ANTLR，Hibernate使用ANTLR产生查询分析器。

### ANTLR简介

ANTLR的全称是ANother Tool for LanguageRecognition，其前身是PCCTS，和YACC、LEX、JavaCC、Coco/R等工具一样，都是编译器的编译程序。
ANTLR对语法树构造、遍历和转换、错误修复和报告提供出色的支持，它为包括Java，C++，C#和Python在内的语言提供了一个通过语法描述来自动构造自定义语言的识别器、解析器、编译器和转换器的框架。
ANTLR可以通过断言（Predicate）解决识别冲突；支持动作（Action）和返回值（ReturnValue）来；更棒的是，它可以根据输入自动生成语法树并可视化的显示出来。由此，计算机语言的翻译变成了一项普通的任务。
ANTLR是由旧金山大学的Terence Parr博士领导下完成的，最新版本为[4.1](http://www.antlr4.org/)。

编译器工作主要分有词法分析，语法分析，代码生成三个步骤。ANTLR分别提供了三个东西:
1. 词法分析器（Lexer）
   词法分析器又称为Scanner，Lexicalanalyser和Tokenizer。程序设计语言通常由关键字和严格定义的语法结构组成。编译的最终目的是将程序设计语言的高层指令翻译成物理机器或虚拟机可以执行的指令。词法分析器的工作是分析量化那些本来毫无意义的字符流，将他们翻译成离散的字符组（也就是一个一个的Token），包括关键字、标识符、符号和操作符供语法分析器使用。
1. 语法分析器（Parser）
   编译器又称为Syntacticalanalyser。在分析字符流的时候，Lexer不关心所生成的单个Token的语法意义及其与上下文之间的关系，而这就是Parser的工作。语法分析器将收到的Tokens组织起来，并转换成为目标语言语法定义所允许的序列。
   无论是Lexer还是Parser都是一种识别器，Lexer是字符序列识别器而Parser是Token序列识别器。他们在本质上是类似的东西，而只是在分工上有所不同而已。
1. 抽象语法树遍历器 (Tree walker)
   树分析器可以用于对语法分析生成的抽象语法树进行遍历，并能执行一些相关的操作，可以进行语义匹配生成代码。

### ANTLR 3的Eclipse插件

[ANTLR IDE](antlrv3ide.sourceforge.net)用于ANTLR3的一个Eclipse插件。
- 支持ANTLR 3.0、3.1、3.2、3.3和3.4。
- ANTLR启动器和调试器(仅限Java)
- ANTLR内建解析器。
- 代码格式化工具(Ctrl+Shift+F)
- 语法图（铁路图）
- 定制目标
- 自动生成资源
- 对语法文件中错误和告警自动标注
- 高级文本编辑器、代码选择(F3)和代码补全(Ctrl+Space)
- 对（Java、C#、Python和C等）目标语言自动语法高亮
- 标注生成的资源
- 高级字符串模板(StringTemplate)编辑器(*.st and *.stg)
- 高级语法单元测试(gUnit)编辑器(*.gunit and *.testsuite)![初探ANTLR](/images/2013/7/72ef7beatx6BjAsZSo747.jpg)

### 使用ANTLR生成代码的ANT设置

```
<property name="lib.dir" value="lib" />
<property name="gensrc.dir" value="gen-source/Java" />
<property name="parser.dir" value="/com/sas/yourgramarpackage"/>
<target name="gen-source">
    <mkdir dir="${gensrc.dir}/${parser.dir}" />
<antlr:antlr3 xmlns:antlr="antlib:org/apache/tools/ant/antlr"
    target="${src.dir}/${parser.dir}/YourGrammar.g"
    outputdirectory="${gensrc.dir}/${parser.dir}">
  <classpath>
     <fileset dir="${lib.dir}">
         <include name="*.jar" />
     </fileset>
  </classpath>
</antlr:antlr3>
</target>
```

### 使用ANTLR生成代码的Maven设置

```
<build>
   <plugins>
      <plugin>
         <groupId>org.apache.maven.plugins</groupId>
         <artifactId>maven-antlr-plugin</artifactId>
         <configuration>
            <grammars>com/yqu/yourgramarpackage/yourgrammar.g</grammars>
            <sourceDirectory>Source/Java</sourceDirectory>
            <outputDirectory>target/generated/antlr/Source/Java</outputDirectory>
         </configuration>
         <executions>
            <execution>
               <goals>
                  <goal>generate</goal>
               </goals>
            </execution>
         </executions>
      </plugin>
   </plugins>
</build>
```