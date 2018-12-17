---
title: '[Eclipse] 遭遇Unable to install breakpoint due to missing line number attribute'
date: 2015-10-30 05:49:54
categories: 
- Tool
- Eclipse
tags: 
- eclipse
- breakpoint
- enhancerbyspringcgli
- absent
- line_number
---
今天遇到了“Unable to install breakpoint due to missing line numberattribute. Modify compiler options to generate line numberattributes”问题。
![[Eclipse] 遭遇"Unable to install breakpoint due to missing line number attribute"](/images/2015/10/0026uWfMgy6WClZQ0lY62.png)
检查**Preferences -> Java -> Perference**，"Add linenumber attributes to generated class files (used by thedebugger)"已经勾选了。
![[Eclipse] 遭遇"Unable to install breakpoint due to missing line number attribute"](/images/2015/10/0026uWfMgy6WCm0AEYgd8.png)
应该是SpringAOP产生的代码没有行数信息，但是我自己写的代码还是带行数信息的，因此虽然会弹出这些烦人的警告，所设断点还是其作用的。让它不再提示即可。
