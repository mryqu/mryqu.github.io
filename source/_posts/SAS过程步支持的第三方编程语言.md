---
title: 'SAS过程步支持的第三方编程语言'
date: 2015-08-25 05:58:04
categories: 
- DataScience
tags: 
- sas
- 3rd
- programming
- language
---
<table style="table-layout: fixed !important;"><tbody><tr><th style="width: 80px !important; word-break: word-break  !important; text-align: center;">编程语言</th><th style="width: 120px !important; word-break: word-break !important; text-align: center;">接口</th><th>描述</th style="width: 200px !important;"></tr><tr><td rowspan="2">C, C++</td><td>PROC PROTO</td><td>PROC PROTO可以以批处理模式注册以外部的C或C++程序。当C函数在PROC PROTO注册后，他们能被FCMP过程里声明的任何SAS函数或子程序调用, 也能被COMPILE过程里声明的任何SAS函数、子程序或方法块调用。</td></tr><tr><td>PROC FCMP</td><td>SAS函数编译器(FCMP)过程可以创建、测试和存储SAS函数和CALL子程序，这些SAS函数和CALL子程序之后可用于其它SAS过程步或数据步。PROC FCMP能够使用数据步语法创建存储在数据集内的SAS函数和CALL子程序。该过程步接受数据步语句的轻微变化，你可以使用PROC FCMP所创建的SAS函数和CALL子程序中SAS编程语言的大部分功能。</td></tr><tr><td>Groovy</td><td>PROC GROOVY</td><td>PROC GROOVY是在SAS9.3引入，为特定Groovy内联代码提供提交快的SAS程序，也能运行存储在外部文件中的Groovy程序。</td></tr>
<tr><td rowspan="2">Java</td><td>JAVAOBJ</td><td>SAS9提供的数据步组件对象。示例：
```
data _null_;
  length s_out $200;
  declare JavaObj j1 ('java/lang/String','KE');
  declare JavaObj j2 ('java/lang/String','XIAO');
  j1.callStringMethod ('concat', j2, s_out);
  put s_out=;
  j1.delete();
  j2.delete();
run;
```
</td></tr><tr>
<td>PROC JLAUNCH</td><td>JLaunch过程步允许在SAS显示管理器系统（DMS）内启动Java GUI程序。示例：
```
proc jlaunch direct librefs debug
  app='com/sas/analytics/cmpfunceditor/app/FCmpFunctionEditorApp';
  picklist name='base/cmpedit.txt';
run;
```
</td></tr><tr><td>Lua</td><td>PROC LUA</td><td>PROC LUA是在SAS9.4引入，为特定Lua内联代码提供提交快的SAS程序，也能运行存储在外部文件中的Lua程序。</td></tr><tr><td>R</td><td>PROC IML</td><td>PROC IML提供了灵活的矩阵编程语言，可以与R集成。示例：
```
libname mmsamp "!sasroot\mmcommon\sample";
proc iml;
  run ExportDatasetToR("mmsamp.hmeq_train" , "mm_inds");
  submit /R;
    attach(mm_inds)
      # -----------------------------------------------
      # FITTING THE LOGISTIC MODEL
      # -----------------------------------------------
      logiten<- glm(BAD ~ VALUE + factor(REASON) + factor(JOB) + DEROG + CLAGE + NINQ + CLNO , family=binomial)

      # -----------------------------------------------
      # SAVING THE OUTPUT PARAMETER ESTIMATE TO LOCAL FILE
      # -----------------------------------------------
      save(logiten, file="c:/temp/outmodel.rda")
    endsubmit;
quit;
```
</td></tr></tbody></table>