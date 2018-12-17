---
title: '[OpenUI5] 示例: Sorted, grouped and multi-selectable list'
date: 2015-05-02 08:14:50
categories: 
- 前端
tags: 
- openui5
- list
- multi-selectable
- sorter
- grouper
---
做了一个可多选、使用定制分组和排序的list示例，示例位置：[http://jsbin.com/jetena/1/edit?html,output](http://jsbin.com/jetena/1/edit?html,output)

```
var fGrouper = function(oContext) {
 var v = oContext.getProperty("workbook");
 return { key: v, text: v };
}

var oSorter = new sap.ui.model.Sorter("", false, fGrouper);
oSorter.fnCompare = function(a, b) {
 // Determine the group and group order
 var agroup = a.workbook;
 var bgroup = b.workbook;
 // Return sort result, by group ...
 if (agroup < bgroup) return -1;
 if (agroup > bgroup) return  1;
  // ... and then within group (when relevant)
 if (a.worksheet < b.worksheet) return -1;
 if (a.worksheet == b.worksheet) return 0;
 if (a.worksheet > b.worksheet) return  1;
}
                
var sheetSelList = new sap.m.List({
 id: "workSheetSelectionList",
 mode: sap.m.ListMode.MultiSelect,
 headerToolbar: new sap.m.Toolbar({
  content: [
   new sap.m.CheckBox({
    id:"workSheetSelectionList-selAll",
    text: "All",
    selected: true,
    select : function() {
     if(this.getSelected()) {
      sheetSelList.selectAll();
     }
    }
   })
  ]
 }),
 items:{
  path: '/modelData',
  template: new sap.m.StandardListItem({
   title: '{worksheet}',
   selected: "{selected}"
  }),
  sorter: oSorter,
  groupHeaderFactory: function (oGroup) {
   return new sap.m.GroupHeaderListItem({
    title: oGroup.key,
    upperCase: false
   });
  }
 },
 selectionChange: function(ev) {
  if(!ev.getParameters().selected) {
   var oCB = sap.ui.getCore().byId("workSheetSelectionList-selAll");
   oCB.setSelected(false);
  }
 }
});

var workbookInfo= [
 {workbook:"1.xlsx", worksheet:"sheet1", selected:true},
 {workbook:"2.xlsx", worksheet:"sheet1", selected:true},
 {workbook:"1.xlsx", worksheet:"sheet2", selected:true},
 {workbook:"1.xlsx", worksheet:"sheet3", selected:true}
];

var listModel = new sap.ui.model.json.JSONModel();
listModel.setData({modelData:workbookInfo});
sheetSelList.setModel(listModel);

sheetSelList.placeAt("content");
```
![[OpenUI5] 示例: Sorted, grouped and multi-selectable list](/images/2015/5/0026uWfMgy6Sn0abLun1f.png)

### 参考

[Custom Sorting and Grouping](http://scn.sap.com/community/developer-center/front-end/blog/2013/11/29/custom-sorter-and-grouper)    