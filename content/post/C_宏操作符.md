---
title: '[C] #和##宏操作符'
date: 2013-10-20 10:45:24
categories: 
- C++
tags: 
- C
- macro
- token
---
在看[# and ## in macros](https://stackoverflow.com/questions/4364971/and-in-macros)之前觉得对#和##宏操作符挺明白的，看了之后才感觉需要重新学习一下。
```
#define f(a,b) a##b
#define g(a)   #a
#define h(a) g(a)

int main() {
  printf("%s\n",h(f(1,2)));
  printf("%s\n",g(f(1,2)));
  return 0;
}
```

如果你能确保自己能写出正确答案的话，那么你可以略过这篇帖子。
C/C++语言中对宏的处理属于编译器预处理的范畴，属于编译期概念而非运行期概念。其中#操作符用于对指定的宏参数进行字符串化，而##操作符用来将两个符号连接为一个符号。

```
struct command
{
  char *name;
  void (*function) (void);
};
```

<table border="0"><tr><td>
```
#define COMMAND(NAME) \
  { #NAME, NAME ## _command }

struct command commands[] =
{
  COMMAND (quit),
  COMMAND (help),
  …
};
```
</td><td>等同</td><td>
```
struct command commands[] =
{
  { "quit", quit_command },
  { "help", help_command },
  …
};
```
</td></tr></table>

但是这里还有一个参数预扫描问题。即如果参数不被字符串化或者用于符号连接的情况下，才会在宏定义体内被替换之前进行展开。
```
#define xstr(s) str(s)
#define str(s) #s
#define foo 4
str (foo)
     → "foo" //由于str中对s参数进行字符串化，所以foo不会展开
xstr (foo)
     → xstr (4) //由于xstr中对foo施加#和##操作符，因此foo先展开为4
     → str (4)
     → "4"
```

通过gcc -E可以查看预处理结果、更好地理解宏是如何被评估（evaluate）的。
最后必须说明的是，在使用C++开发时应尽可能地避免使用宏。

### 参考

[The C Preprocessor - Macro](https://gcc.gnu.org/onlinedocs/cpp/Macros.html)    
[Macro Parameter Stringizing](https://gcc.gnu.org/onlinedocs/cpp/Stringizing.html)    
[Macro Token Concatenation](https://gcc.gnu.org/onlinedocs/cpp/Concatenation.html)    
[Macro Argument Prescan](https://gcc.gnu.org/onlinedocs/cpp/Argument-Prescan.html)    