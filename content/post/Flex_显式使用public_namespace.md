---
title: '[Flex] 显式使用public namespace'
date: 2012-09-01 17:24:28
categories: 
- FrontEnd
tags: 
- flex
- namespace

---
今天看代码时，发现public namespace的使用，搜了一下flex4 in action，貌似没有。
放狗搜了一下，学习学习。 

myspace.as
```
package
{
  public namespace myspace ="http://myspace";
}
```

TestClass.as
```
package
{
  import myspace;

  public class TestClass
  {

    public function foo():void
    {
      trace("Public foo is called");
    }

    myspace function foo():void
    {
      trace("MySpace foo is called");
    }

    private function fooPrivate():void
    {
      trace("Called private function");
    }

    protected function fooProtected():void
    {
      trace("Called protected function");
    }

    public function callFoo(t:TestClass):void
    {
      // call the private/protected members on the object.
      t.fooPrivate();
      t.fooProtected();
    }
  }
}
```

testApp.mxml
```
<?xml version="1.0" encoding="utf-8"?>
<mx:Application xmlns:mx="http://www.adobe.com/2006/mxml" layout="absolute"
 creationComplete="testFunc()">
<mx:Script>
 <![CDATA[

use namespace myspace;

private function testFunc():void
{
   var test:TestClass = new TestClass;
   //public can be also used as namespace name to call the correct function.
   test.public::foo();

   // call the myspace namespace function
   test.myspace::foo();

   var test2:TestClass = new TestClass;
   // call the function to demonstrate that private/protected functions
   // can be called on test2 object.
   test.callFoo(test2);

}
]]>
</mx:Script>
</mx:Application>
```

原文 [Using public namespace explicitly](http://flexpearls.blogspot.com/2007/06/using-public-namespace-explicitly.html)