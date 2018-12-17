---
title: '[JavaScript] retrieve data table'
date: 2014-08-20 22:06:08
categories: 
- 前端
tags: 
- javascript
- datatable
- ajax
- rest
- spring
---
想学学怎么提交一个Form中的Table，放狗出去，结果不够给力。
曾经有很多年Table标签被用作格式对齐的工具，这使搜出来的页面很少讲的是数据表格。
看了看[DataTables](http://www.datatables.net/)这个JQuery插件，可以加载和更新数据，但是没有找到存储所有表格数据的功能。
看了看ajaxsubmit，必须有formcontent，此外可以有可选的data。由于表格里有很多行，没想好path的设置问题。
最后还是用JS提取所有表格数据，生成JS数组，通过AJAX post函数发送给服务器侧。
JS侧的代码示例：[http://jsfiddle.net/mryqu/d7rubzut/](http://jsfiddle.net/mryqu/d7rubzut/)
服务器侧的用于REST的Spring控制器代码如下：
```
@RequestMapping(params="action=test", method = RequestMethod.POST)
public @ResponseBody 
        TestResultVO test(HttpServletRequest request, @ModelAttribute("tqs")ArrayList tqs)
        throws Exception {
    ......
}
```

运行结果正常