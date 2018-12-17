---
title: '使用OneDrive的根API资源'
date: 2016-10-16 06:40:59
categories: 
- DataBuilder
tags: 
- onedrive
- root
- api
- resource
- storage
---
### OneDrive的根API资源

可以使用OneDrive的这些根API资源来访问一个项目或驱动。

|路径|资源
|-----
|[/drive](https://dev.onedrive.com/drives/default.htm)|用户的默认[驱动](https://dev.onedrive.com/README.htm#drive-resource)。
|[/drives](https://dev.onedrive.com/drives/list-drives.htm)|列举对认证用户可用的[驱动](https://dev.onedrive.com/README.htm#drive-resource)。
|[/drives/{drive-id}](https://dev.onedrive.com/drives/get.htm)|通过ID访问一个特定[驱动](https://dev.onedrive.com/README.htm#drive-resource)。
|[/drives/{drive-id}/root/children](https://dev.onedrive.com/items/list.htm)|列举特定[驱动](https://dev.onedrive.com/README.htm#drive-resource)根路径下项目。
|[/drive/items/{item-id}](https://dev.onedrive.com/items/get.htm)|通过ID访问一个[元素](https://dev.onedrive.com/README.htm#item-resource)。
|[/drive/special/{special-id}](https://dev.onedrive.com/items/special_folders.htm)|通过已知名访问一个[特殊（命名）目录](https://dev.onedrive.com/items/special_folders.htm)。ID目前可取值为：documents、photos、cameraroll、approot、music。
|[/shares/{share-id}](https://dev.onedrive.com/shares/shares.htm)|通过共享ID或共享URL访问一个[元素](https://dev.onedrive.com/README.htm#item-resource)。


元素可由路径定位，通过在任何元素或驱动URL后加冒号。

|路径|资源
|-----
|/drive/root:/path/to/file|通过根绝对路径访问一个[元素](https://dev.onedrive.com/README.htm#item-resource)。
|/drive/items/{item-id}:/path/to/file|通过相对路径访问一个[元素](https://dev.onedrive.com/README.htm#item-resource)。
|/drive/root:/path/to/file:/children|通过根绝对路径列举一个[元素](https://dev.onedrive.com/README.htm#item-resource)的子项。
|/drive/items/{item-id}:/path/to/file:/children|通过相对路径列举一个[元素](https://dev.onedrive.com/README.htm#item-resource)的子项。


### 测试


#### 获取默认驱动
![使用OneDrive的根API资源](/images/2016/10/0026uWfMzy75I4IvDa5d5.jpg)
#### 列举可用驱动
![使用OneDrive的根API资源](/images/2016/10/0026uWfMzy75I4IziWm12.jpg)
#### 通过ID获取指定驱动
![使用OneDrive的根API资源](/images/2016/10/0026uWfMzy75I4IC50yc6.jpg)
#### 列举特定驱动根路径下项目
![使用OneDrive的根API资源](/images/2016/10/0026uWfMzy75I4IHxYw94.jpg)
#### 通过ID访问一个目录"文档"
![使用OneDrive的根API资源](/images/2016/10/0026uWfMzy75I4IZuIH23.jpg)
#### 访问特殊目录documents
![使用OneDrive的根API资源](/images/2016/10/0026uWfMzy75I4J8fK9f9.jpg)
#### 通过共享ID访问文件CN_EN_JP_KO.xlsx

将文件CN_EN_JP_KO.xlsx共享，获取其共享URL：
![使用OneDrive的根API资源](/images/2016/10/0026uWfMzy75I4JaPyoa0.jpg)
通过共享ID使用OneDrive API访问文件CN_EN_JP_KO.xlsx：
![使用OneDrive的根API资源](/images/2016/10/0026uWfMzy75I4Jd6l298.jpg)
#### 通过根绝对路径访问文件CN_EN_JP_KO.xlsx

<font color="#FF0000">**注意root后有冒号：**</font>
![使用OneDrive的根API资源](/images/2016/10/0026uWfMzy75I4JfiEv6f.jpg)
#### 通过相对路径访问文件CN_EN_JP_KO.xlsx

<font color="#FF0000">**712B21FCE8E08C92!442是目录"文档"的ID，注意其后有冒号：**</font>
![使用OneDrive的根API资源](/images/2016/10/0026uWfMzy75I4JhWKr6f.jpg)
#### 通过根绝对路径列举目录"文档"的子元素

<font color="#FF0000">**注意root和路径（/文档）后都有冒号：**</font>
![使用OneDrive的根API资源](/images/2016/10/0026uWfMzy75I4Jk9u49c.jpg)
#### 通过相对路径列举目录"FolderTest"的子元素

为了测试，首先我在目录"文档"创建子目录"FolderTest"，然后在目录"FolderTest"中创建mryqu.txt文件。

**<font color="#FF0000">712B21FCE8E08C92!442是目录"文档"的ID，注意其后有冒号；路径（/FolderTest）后也有冒号。</font>**
![使用OneDrive的根API资源](/images/2016/10/0026uWfMzy75I4Jorypd1.jpg)