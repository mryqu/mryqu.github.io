---
title: '遭遇Python*重复运算符陷阱'
date: 2014-01-18 18:12:43
categories: 
- Python
tags: 
- python
- 重复运算符
- 陷阱
---
在python中有个特殊的符号“\*”，可以用做数值运算的乘法算子，也是用作对象的重复算子，但在作为重复算子使用时一定要注意\* **重复出来的对象有可能是指向在内存中同一块地址的同一对象。**

测试代码：
```
grid_width=2
grid_height=2

def modify_grid(cells, row, col, val):
   cells[row][col]=val
   print cells

#testing 1
print '\ntesting 1'
cells=[ [88 for col in range(grid_width)] for row in range(grid_height)]
print cells
modify_grid(cells,0,1,66)

#testing 2: In the trap
print '\ntesting 2'
cells=[[88]*grid_width]*grid_height
print cells
modify_grid(cells,0,1,66)
print '\n'
cells=[["88"]*grid_width]*grid_height
print cells
modify_grid(cells,0,1,"66")

#testing 3
print '\ntesting 3'
cells=[]
for idx in range(grid_height):
    cells.append([88]*grid_width)
print cells
modify_grid(cells,0,1,66)

#testing 4
print '\ntesting 4'
cells=[123]*(grid_height*grid_width)
print cells
cells[1]=321

print cells
```

结果
```
testing 1
[[88, 88], [88, 88]]
[[88, **66**], [88, 88]]

testing 2
[[88, 88], [88, 88]]
[[88, 66], [88, 66]]

[['88', '88'], ['88', '88']]
[['88', '66'], ['88', '66']]

testing 3
[[88, 88], [88, 88]]
[[88, 66], [88, 88]]

testing 4
[123, 123, 123, 123]
[123, 321, 123, 123]
```
