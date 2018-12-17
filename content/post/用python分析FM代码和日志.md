---
title: '用python分析FM代码和日志'
date: 2013-11-07 21:53:58
categories: 
- Python
tags: 
- python
- fm
- 分析
- 日志
---
学python有一段时间了，学完不用，结果就是很快遗忘。这周分析一些FM代码和日志，终于弃Java转python，自己乐一下！

### filterDV
```
t6Found=False
with open('SASFinancialManagement5.4f.log', 'w') as fdst:
    with open('SASFinancialManagement5.4.log', 'r') as fsrc:
        for line in fsrc:
            if t6Found:
                if "DataValidation" in line:
                    fdst.write(line)
            else:
                if "formSetId=436,formId=,tableCode=NewTable6" in line:
                    t6Found=True
if not fsrc.closed:
    fsrc.close()
if not fdst.closed:
    fdst.close()
```

### calcDVDuration

```
import re
totalTime=0
with open('SASFinancialManagement5.4f.log', 'r') as fsrc:
    for line in fsrc:
        if "begin data validation at formSubScope for" in line:
            m = re.search('formSetId=.* ]', line)
            target = m.group(0)          
            m = re.search('( <=when )\d+', line)
            startTime = m.group(0)
        elif "DataValidationMapManagerBean addResopnse()" in line:
            m = re.search('( <=when )\d+', line)
            endTime = m.group(0)
            print(target," ",int(endTime)-int(startTime))
            totalTime+=int(endTime)-int(startTime)
print('total time:',totalTime)
if not fsrc.closed:
    fsrc.close()
```

### findArrayListConv

```
import os

def checkArraylistConv(fl,listConvInfo):
    with open(fl, 'r') as fsrc:
        idx = 0
        lastLine=""
        for line in fsrc:
            idx += 1            
            if "super.find(" in line and ("ArrayList<" in line or "ArrayList<" in lastLine):
                listConvInfo.write(fl + ' ' + str(idx) + ':' + line + '\n')
            lastLine = line
    if not fsrc.closed:
        fsrc.close()

def walkDir(dirpath,listConvInfo,topdown=True):
    for root, dirs, files in os.walk(dirpath, topdown):
        for fl in files:
            sufix = os.path.splitext(fl)[1][1:]
            if sufix.lower() == "java":
                checkArraylistConv(os.path.join(root, fl),listConvInfo)

dirpath = input('please input the FM source directory:')
listConvInfo = open('listConvInfo.txt','w')
walkDir(dirpath,listConvInfo)
listConvInfo.close()
```

