---
title: 'FLEX组件的生命周期'
date: 2012-07-16 13:19:52
categories: 
- 前端
tags: 
- flex
- 组件
- 生命周期
---
组件实例化生命周期描述了用组件类创建组件对象时所发生的一系列步骤,作为生命周期的一部分,flex自动调用组件的的方法,发出事件,并使组件可见。
下面例子用as创建一个btn控件,并将其加入容器中
```
var boxContainer:Box = new Box();

//设置Box容器
...

//创建btn
var b:Button = new Button();
b.label = "Submit";
...

//将btn添加到Box容器中
boxContainer.addChild(b);
```

下面的步骤显示了用代码创建一个Button控件，并将这个控件添加到Box容器中时所发生的一切：
1. 调用了组件的构造函数;
   var b:Button = new Button();
2. 通过设置组件的属性对组件进行设置:
   //Configure the button control.
   b.label = "Submit";
   组件的setter方法将会调用invalidateProperties()、invalidateSize()、invalidateDisplayList()方法。
3. 调用addChild()方法将该组件添加到父组件。
   //Add the Button control to the Box container.
   boxContainer.addChild(b);
4. 将component的parent的属性设置为对父容器的引用.
5. 计算组件样式(style)设置。
6. 在组件上发布priininialize事件。
7. 调用组件的createChildren()方法。
8. 调用invalidateProperties(),invalidateSize(),invalidateDisplayList()方法以触发后续到来的,下一个"渲染事件"(render event)期间对commitProperties(),measure(),updateDisplayList()方法的调用.这个规则唯一一个例外就是当用户设置组件的height和width属性时,Flex不会调用measure()方法。
9. 在组件上分发initialize事件。此时，组件所有的子组件都被初始化，但是组件没有改更size和处理布局。可以利用这个事件在组件布局之前执行一些附加的处理。
10. 在父容器上分发childAdd事件。
11. 在父容器上分发initialize事件。
12. 在下一个"渲染事件"(render event)中,Flex执行以下动作:
    - 调用组件的commitProperties()方法。
    - 调用组件的measure()方法。
    - 调用组件的layoutChrome方法。
    - 调用组件的updateDisplayList()方法。
    - 在组件上发布updateComplete事件。
13. 如果commitProperties(),measure,updateDisplayList方法调用了invalidateProperties(),invalidateSize(),或invalidateDisplayList()方法,则Flex会分发另外一个render事件。
14. 在最后的render事件发生后,Flex执行以下动作:
    - 通过设置组件的visible属性使组件变为可视.
    - 在组件上分发creationComplete事件.组件的大小(size)和布局被确定. 这个事件只在组件创建时分发一次.
    - 在组件上分发updateComplete事件.无论什么时候,只要组件的布局(layout),位置,大小或其它可视的属性发生变化就会分发这事件,然后组件被更新，以使组件能够被正确地显示.

原文：[http://blog.csdn.net/stonywang/article/details/2667551](http://blog.csdn.net/stonywang/article/details/2667551)
