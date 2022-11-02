---
title: '[OpenUI5] 十分钟了解sap.ui.table.Table'
date: 2014-11-12 20:00:19
categories: 
- FrontEnd
tags: 
- web
- openui5
- sap.ui.table.table
- sap
- table
---
转发一篇SAP community network的好帖子：http://scn.sap.com/docs/DOC-54075
### Introduction

_sap.ui.table.Table_ is commonly used inOpenUI5 desktop application. Many questions (related to thiscontrol) that are posted in this group, it is evident thatdocumentation for this control is lacking and we (developers) haveto dive deep into debugging its source code to figure things out.It is fortunate that Javascript source code is always available;modern browsers provide debugging capability and personally, I amfortunate to have the opportunity to work with someone in SAPUI5team while using this control. Hence it is an opportunity for me tocontribute back to the community on what I have learned about thiscontrol.

_I am assuming that reader of this document has some basicunderstanding of OpenUI5. The person understands what is OpenUI5control, model and model binding. Please ask questions if you haveany and I (the community experts) will try answer them. I am hopingthat I can keep this as a live document where I can constantlyreceive feedback and update it._
In this document, we show
- A sample JSON model where we are use it our sample code;
- Some code snippet on how to instantiate a table
- Creating columns and binding of rows
- Getting context of selected row(s),
- Two ways binding of model and control

### Sample JSON Model

```
  var naughtyList = [
   {lastName: "Dente", name: "Al", stillNaughty: true},
   {lastName: "Friese", name: "Andy", stillNaughty: true},
   {lastName: "Mann", name: "Anita", stillNaughty: false}
  ];

  var oModel = new sap.ui.model.json.JSONModel();
  oModel.setData(naughtyList);
```

### Instantiate a table

It can be as simple as
```
var oTable = new sap.ui.table.Table();
```

where we inherit all the default properties from the control.Please refer to the [official doc](https://sapui5.netweaver.ondemand.com/sdk/#docs/api/symbols/sap.ui.table.Table.html) for reference.
There are a few properties that I hope to explain a littlemore.

### SelectionMode ([API](https://sapui5.netweaver.ondemand.com/sdk/#docs/api/symbols/sap.ui.table.SelectionMode.html))

Example
```
var oTable = new sap.ui.table.Table({
   selectionMode : sap.ui.table.SelectionMode.Single
});
```
Here you can control the selection mode such as None (disableselection), Single (maximum one row can be selected at any time)and Multi (one or more rows can be selected) . Default is Multi

### SelectionBehavior ([API](https://sapui5.netweaver.ondemand.com/sdk/#docs/api/symbols/sap.ui.table.SelectionBehavior.html))

Example
```
var oTable = new sap.ui.table.Table({
   selectionMode : sap.ui.table.SelectionMode.Row
});
```
Here you can control how the row can be selected such as RowOnly(mouse click on the row only), Row (mouse click on the row and rowselector) and RowSelector (mouse click on the row selector only).Default is RowSelector.
![[OpenUI5] 十分钟了解sap.ui.table.Table](/images/2014/11/0026uWfMgy6P9AL0O5G58.png)

### Create columns and bind rows

Here is an [example](http://jsbin.com/toqof/1/edit) of howyou can do these.
```
  // instantiate the table
  var oTable = new sap.ui.table.Table({
   selectionMode : sap.ui.table.SelectionMode.Single,
   selectionBehavior: sap.ui.table.SelectionBehavior.Row
  });

  // define the Table columns and the binding values
  oTable.addColumn(new sap.ui.table.Column({
    label: new sap.ui.commons.Label({text: "Last Name"}),
    template: new sap.ui.commons.TextView({text:"{lastName}"})
  }));

  oTable.addColumn(new sap.ui.table.Column({
    label: new sap.ui.commons.Label({text: "First Name"}),
    template: new sap.ui.commons.TextField({value: "{name}"})
  }));

  oTable.addColumn(new sap.ui.table.Column({
    label: new sap.ui.commons.Label({text: "Still Naughty"}),
    template: new sap.ui.commons.CheckBox({checked: '{stillNaughty}'})
  })); 

  oTable.setModel(oModel);
  oTable.bindRows("/");
  oTable.placeAt("content");
```
Observe that we do bindRows("/"), this is because we have theJSON model containing an array.
```
oModel.setData(naughtyList);
```
But if your model is created in this manner,
```
oModel.setData({'mydata' : naughtyList});
```
Then you need to do bindRows('/mydata');
And if your data is modified to
```
  var naughtyList = [
   {lastName: "Dente", name: "Al", stillNaughty: 'true'},
   {lastName: "Friese", name: "Andy", stillNaughty: 'true'},
   {lastName: "Mann", name: "Anita", stillNaughty: 'false'}
  ];
```
where _stillNaugthy_ is astring and not a boolean. We can adapt to this with this change inthe column definition
```
  oTable.addColumn(new sap.ui.table.Column({
    label: new sap.ui.commons.Label({text: "Still Naughty"}),
    template: new sap.ui.commons.CheckBox({
     checked: {
       path: 'stillNaughty',
       formatter: function(v) {
         return (v === 'true')
       }
     }
    })
  }));
```
There are many things that you can do with formatter function.For instance if you want to display the first and last nametogether uppercase the last name. we can do this. ([Example](http://jsbin.com/fuqid/1/edit))
```
  oTable.addColumn(new sap.ui.table.Column({
    label: new sap.ui.commons.Label({text: "Name"}),
    template: new sap.ui.commons.TextView(
     {text:
      {
        parts : ['name', 'lastName'],
        formatter: function(n, l) {
          if (n && l) {
            return n + ', ' + l.toUpperCase();
          }
        }
      }
     }
    )
  }));
```

### Getting context of selected row(s),

Here come the interesting part of this document because manyquestions are asked related to this topic.

### Single Selection Mode

When a row is selected or deselected,a _rowSelectionChange_ eventis fired. And [here](http://jsbin.com/calox/1/edit) is how wedeal with it. And below this is main code.
```
  var oTable = new sap.ui.table.Table({
   selectionMode : sap.ui.table.SelectionMode.Single,
   rowSelectionChange: function(e) {
     var idx = e.getParameter('rowIndex');
     if (oTable.isIndexSelected(idx)) {
       var cxt = oTable.getContextByIndex(idx);
       var path = cxt.sPath;
       var obj = oTable.getModel().getProperty(path);
       console.log(obj);       
     }
    }
  });
```
Here (in the code), we can get the selected or deselected row;then we usethe _isIndexSelected_ functionto check if it is selected or deselected. And by getting thecontext and path, we are able to get the binding object itself.
Please note that if row 1 is already selected and now userselect row #2, this event will not fire for that deselection of row#1, an event will be fired for selection of row #2.

### Multi Selection Mode

When one or more rows are selected or deselected, thesame _rowSelectionChange_ eventwill be fired. And [here](http://jsbin.com/holox/1/edit) is how wedeal with it. And below this is main code.
```
  var oTable = new sap.ui.table.Table({
   selectionMode : sap.ui.table.SelectionMode.Multi,
   rowSelectionChange: function(e) {
     var indices = e.getParameter('rowIndices');
     for (var i = 0; i < indices.length; i++) {
       var idx = indices[i];
       if (oTable.isIndexSelected(idx)) {
         var cxt = oTable.getContextByIndex(idx);
         var path = cxt.sPath;
         var obj = oTable.getModel().getProperty(path);
         console.log(obj);       
       }
     }
    }
  });
```
Here (in the code), we can get the selected or deselected rows;then we iterate through the array and usethe_isIndexSelected_ function to check if itis selected or deselected. And by getting the context and path, weare able to get the binding object itself. This piece of code isalmost identical to the code snippet in the single selection modeexcept for getting an array of selected indices.

### Selection None Mode and Select by control in row

You can also identify the row and context with button, checkbox,etc. in the row. Here is an [example](http://jsbin.com/sabah/1/edit).
```
  oTable.addColumn(new sap.ui.table.Column({
    label: new sap.ui.commons.Label({text: "Still Naughty"}),
    template: new sap.ui.commons.CheckBox({
     checked: {
       path: 'stillNaughty',
       formatter: function(v) {
         return (v === 'true')
       }
     },
     change: function(e) {
       var path = e.getSource().getBindingContext().sPath;
       var obj = oTable.getModel().getProperty(path);
       alert(JSON.stringify(obj));
       
       var index = parseInt(path.substring(path.lastIndexOf('/')+1));
       alert(index);
     }
    })
  }));
```

### Two ways binding of model and control

One of the beauty of OpenUI5 is the binding between model andcontrol. In our example [here](http://jsbin.com/lukij/1/edit) (Checkand uncheck the checkbox and then click on Show button to see thatcurrent data in the model), we are able to bind the checkbox valueto the model effortlessly. You can also bind any controls such astextfield, radio button, etc in the table.
However if you use the formatter function to alter the valuebefore displaying it then you need to update the model manuallylike [this](http://jsbin.com/yikur/1/edit). And below this is maincode.
```
  oTable.addColumn(new sap.ui.table.Column({
    label:new sap.ui.commons.Label({text: "Still Naughty"}),
    template: new sap.ui.commons.CheckBox({
     checked: {
       path: 'stillNaughty',
       formatter: function(v) {
         return (v === 'true')
       }
     },
     change: function(e) {
       var path = e.getSource().getBindingContext().sPath;
       var obj = oTable.getModel().getProperty(path);
       obj.stillNaughty = this.getChecked()
     }
    })
  }));
```