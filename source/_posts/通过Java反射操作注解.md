---
title: '通过Java反射操作注解'
date: 2014-06-29 09:47:16
categories: 
- Java
tags: 
- java
- annotation
- reflection
---
注解是Java5加入的特性，它是可以插入Java代码的注释或元数据，可被预编译工具在编译时进行处理，或在运行态通过Java反射进行操作。开发者可以通过元编程（Metaprogramming）等技术提高生产率，注解在其中扮演了核心角色。其思想是通过注解够告诉工具如何生成新代码、转换代码或者决定运行期的行为。

#### MyAnnotation.java

```
package com.yqu.reflection.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
//@Target(ElementType.TYPE)
public @interface MyAnnotation {
  public String name() default "[unknown name]";
  public String value() default "[unassigned value]";
}
```

定义注解类有点类似于定义Java接口类interface，但和一般的接口类比起来，interface前面多了一个@，这样就声明了注解是一个Annotation类。另外，Stringname()和Stringvalue()这个写法是@interface中一个比较独特的地方。它实际上定义的不并是注解类的方法，而是注解类的属性。
@Target指定此注解的作用域：
- TYPE：用于类、接口、注解类和枚举
- CONSTRUCTOR：用于构造方法
- LOCAL_VARIABLE：用于本地变量
- FIELD：用于类的属性(包括枚举常量)
- METHOD：用于方法
- PACKAGE：用于包
- PARAMETER：用于方法的参数
- ANNOTATION_TYPE：用于注解类
- TYPE_PARAMETER：使用类型参数，表示注解可以用在Type的声明式前
- TYPE_USE： 使用类型注解。表示注解所有使用Type的地方（如泛型、类型转换等）@Retention指定此注解的生命周期：
- SOURCE：代表此注解仅在代码编译前存活。比如@Deprecated，仅在编译前提供一些提示信息。在编译时，这些注解并不会编译到class文件中。
- CLASS：与SOURCE不同，这类标记会编译到class文件中，但不会成为程序的一部分，也不可以通过代码在运行时调用到。
- RUNTIME： 这类标记将成为代码的一部分，并会在实际运行时起到作用。

#### TheClass.java

```
package com.yqu.reflection.annotation;

import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

@MyAnnotation(name = "classAnnotation", value = "Hello Class")
// I18NOK:CLS
public class TheClass {
 @MyAnnotation(name = "fieldAnnotation", value = "Hello Field")
 public String theField = null;

 public TheClass() {
 }

 @MyAnnotation(name = "methodAnnotation", value = "Hello Method")
 public void doSomething() {
  System.out.println("doSomething");
 }

 public static void doSomethingElse(
   @MyAnnotation(name = "paramAnnotation", value = "Hello Parameter") String param) {
  System.out.println("doSomethingElse:" + param);
 }

 public static void testClassAnnotation() {
  Class aClass = TheClass.class;

  Annotation[] annotations = aClass.getAnnotations();
  for (Annotation annotation : annotations) {
   if (annotation instanceof MyAnnotation) {
    MyAnnotation myAnnotation = (MyAnnotation) annotation;
    System.out.println("name: " + myAnnotation.name());
    System.out.println("value: " + myAnnotation.value());
   }
  }

  Annotation annotation = aClass.getAnnotation(MyAnnotation.class);
  if (annotation instanceof MyAnnotation) {
   MyAnnotation myAnnotation = (MyAnnotation) annotation;
   System.out.println("name: " + myAnnotation.name());
   System.out.println("value: " + myAnnotation.value());
  }
 }

 public static void testMethodAnnotation() throws NoSuchMethodException,
   SecurityException {
  Class aClass = TheClass.class;
  Method method = aClass.getMethod("doSomething", null);

  Annotation[] annotations = method.getDeclaredAnnotations();
  for (Annotation annotation : annotations) {
   if (annotation instanceof MyAnnotation) {
    MyAnnotation myAnnotation = (MyAnnotation) annotation;
    System.out.println("name: " + myAnnotation.name());
    System.out.println("value: " + myAnnotation.value());
   }
  }

  Annotation annotation = method.getAnnotation(MyAnnotation.class);
  if (annotation instanceof MyAnnotation) {
   MyAnnotation myAnnotation = (MyAnnotation) annotation;
   System.out.println("name: " + myAnnotation.name());
   System.out.println("value: " + myAnnotation.value());
  }

 }

 public static void testParameterAnnotation() throws NoSuchMethodException,
   SecurityException {
  Class aClass = TheClass.class;
  Method method = aClass.getMethod("doSomethingElse",
    new Class[] { String.class });

  Annotation[][] parameterAnnotations = method.getParameterAnnotations();
  Class[] parameterTypes = method.getParameterTypes();

  int i = 0;
  for (Annotation[] annotations : parameterAnnotations) {
   Class parameterType = parameterTypes[i++];

   for (Annotation annotation : annotations) {
    if (annotation instanceof MyAnnotation) {
     MyAnnotation myAnnotation = (MyAnnotation) annotation;
     System.out.println("param: " + parameterType.getName());
     System.out.println("name : " + myAnnotation.name());
     System.out.println("value: " + myAnnotation.value());
    }
   }
  }
 }

 public static void testFieldAnnotation() throws NoSuchFieldException,
   SecurityException {
  Class aClass = TheClass.class;
  Field field = aClass.getField("theField");

  Annotation[] annotations = field.getDeclaredAnnotations();
  for (Annotation annotation : annotations) {
   if (annotation instanceof MyAnnotation) {
    MyAnnotation myAnnotation = (MyAnnotation) annotation;
    System.out.println("name: " + myAnnotation.name());
    System.out.println("value: " + myAnnotation.value());
   }
  }

  Annotation annotation = field.getAnnotation(MyAnnotation.class);
  if (annotation instanceof MyAnnotation) {
   MyAnnotation myAnnotation = (MyAnnotation) annotation;
   System.out.println("name: " + myAnnotation.name());
   System.out.println("value: " + myAnnotation.value());
  }
 }

 public static void main(String[] args) throws Exception {
  testClassAnnotation();

  System.out.println("------------------>");
  testMethodAnnotation();

  System.out.println("------------------>");
  testParameterAnnotation();

  System.out.println("------------------>");
  testFieldAnnotation();
 }

}
```

#### 测试结果

```
name: classAnnotation
value: Hello Class
name: classAnnotation
value: Hello Class
------------------>
name: methodAnnotation
value: Hello Method
name: methodAnnotation
value: Hello Method
------------------>
param: java.lang.String
name : paramAnnotation
value: Hello Parameter
------------------>
name: fieldAnnotation
value: Hello Field
name: fieldAnnotation
value: Hello Field
```
