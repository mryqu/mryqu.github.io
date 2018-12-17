---
title: 'Hello Dropbox API'
date: 2016-10-04 05:53:29
categories: 
- DataBuilder
tags: 
- dropbox
- api
- crawler
- storage
- quickstart
---
本博文用来记录一下粗略体验Dropbox关于用户、文件、共享三方面API的过程。

### 准备环境

还是用我私人的Dropbox做测试，所以只显示Public目录下的东东了。
![Hello Dropbox API](/images/2016/10/0026uWfMzy75TCuNqqTc3.jpg)
### 用户类API测试

#### 方法get_current_account测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75TEeAbRp1b.jpg)
#### 方法get_account测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75TE5JUXI7e.jpg)
#### 方法get_space_usage测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75TE6h3yY9c.jpg)
### 文件类API测试

#### 方法list_folder测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U3vwc9a78.jpg)
方法list_folder其实是列举文件和目录，而且是分层的。如果path没设，则显示根目录下的元素。

#### 方法get_metadata测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U3vzpDZ0b.png)
方法get_metadata用于获取一个元素（文件/目录）的元数据。

#### 方法create_folder测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U3xixJZ47.png)
#### 方法get_preview测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U3vUjKUf8.png)
方法get_preview仅支持 .doc、 .docx、 .docm、 .ppt、 .pps、 .ppsx、 .ppsm、.pptx、.pptm、 .xls、 .xlsx、 .xlsm、.rtf文件类型。就我的测试而言，没看出跟下面的download方法有多大区别。

这里尝试了一下path的其他使用方式。除了最常规的文件路径外，path参数还可以使用id或rev。

#### 方法download测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U3xUe2M54.png)
#### 方法search测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U3yyrQL63.png)
#### 方法upload测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U3zawyld1.png)
#### 方法delete测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U3zdMLo22.png)![Hello Dropbox API](/images/2016/10/0026uWfMzy75U3zhnYBd1.png)
方法delete用于删除一个元素（文件/目录）。

#### 方法permanently_delete测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U3zlonqb4.jpg)
方法permanently_delete是支持Dropbox商业应用，而我的是开发应用，因而测试失败。

### 共享类API测试

#### 方法share_folder测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U4bpggn1f.jpg)
#### 方法list_folders测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U4bsvzMf6.jpg)
#### 方法unshare_folder测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U56DnUo0c.jpg)
方法unshare_folder使用的是异步任务的方式，需要通过下列的方法check_job_status查询任务进度及结果。

#### 方法check_job_status测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U4ceie0fc.jpg)
#### 方法create_share_link测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U4dhXkY48.png)![Hello Dropbox API](/images/2016/10/0026uWfMzy75U58AeP3d5.jpg)
share_folder可以通过邮件或Dropbox账户的方式分享给其他Dropbox用户，而share_link甚至可以共享给没有安装Dropbox的使用者。

#### 方法get_share_links测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U4dkMgge0.jpg)
#### 方法get_shared_link_file测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U4dn2Vm04.jpg)
#### 方法revoke_shared_link测试
![Hello Dropbox API](/images/2016/10/0026uWfMzy75U4dtZmA54.jpg)
revoke_shared_link竟然不返回结果，查证文档后确实如此。

### 学习总结

Dropbox关于文件共享方面的API占比相对OneDrive、Google Drive要多一些。
Dropbox API相对OneDrive、GoogleDrive而言，成熟度更低。按照REST的Richardson成熟度模型来说仅在2-级别，它的REST资源还是动词，例如get_metadata、check_job_status。

### 参考

[Dropbox](https://www.dropbox.com)    
[Dropbox API v2 for HTTP Developers](https://www.dropbox.com/developers)    
[Dropbox API Explorer](https://dropbox.github.io/dropbox-api-v2-explorer/)    