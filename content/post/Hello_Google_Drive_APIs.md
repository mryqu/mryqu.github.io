---
title: 'Hello Google Drive APIs'
date: 2016-10-20 06:32:31
categories: 
- DataBuilder
tags: 
- google
- drive
- api
- crawler
- storage
---
### 准备环境

当前我的Google Drive内容如下：
![Hello Google Drive APIs](/images/2016/10/0026uWfMzy75RDJt7r573.jpg)![Hello Google Drive APIs](/images/2016/10/0026uWfMzy75RDJwQvb0d.jpg)
继续使用博文《[Google Sheets API认证和鉴权](/post/google_sheets_api认证和鉴权)》中用过的应用yquGSTest，不过需要激活Google Drive API：
![Hello Google Drive APIs](/images/2016/10/0026uWfMzy75S0pBX2Af4.jpg)
### Google Drive API测试

#### 方法drive.about.get测试

方法drive.about.get用于获取用户、驱动和系统容量等信息。

![Hello Google Drive APIs](/images/2016/10/0026uWfMzy75RTiaHDbd9.jpg)

#### 方法drive.files.list测试

方法drive.files.list用于列举或搜索文件。

![Hello Google Drive APIs](/images/2016/10/0026uWfMzy75REQYM5p2f.jpg)

与Microsoft OneDriveAPI仅列举请求目录下文件不同，方法drive.files.list列举文件时返回了所有目录和文件，例如子目录FolderTest1下的文件Class_cn_Tab.csv也在响应内容里面。

#### 方法drive.files.get测试

方法drive.files.get用于通过ID获取文件元数据。下面获得Class_cn_Tab.csv文件的元数据。

![Hello Google Drive APIs](/images/2016/10/0026uWfMzy75RS1L8R492.jpg)

#### 方法drive.files.create测试

方法drive.files.create用于创建一个新文件。

![Hello Google Drive APIs](/images/2016/10/0026uWfMzy75RTQJKkj5b.jpg)

在API Explorer中仅能指定新文件的元数据，没法上传文件内容，所以虽然测试成功且GoogleDrive里也会显示新的文件，但是打不开。这种仅指定元数据不提供内容的方式特别适合创建目录。

[https://developers.google.com/drive/v3/web/manage-uploads](https://developers.google.com/drive/v3/web/manage-uploads)里面说明了如何在创建或更新文件时上传文件内容。

#### 通过Java JDK创建文件

与博文《[Google Sheets API认证和鉴权](/post/google_sheets_api认证和鉴权)》中获取访问令牌的差异如下：
```
GET https://accounts.google.com/o/oauth2/v2/auth?
 scope=**<font color="#FF0000">https://www.googleapis.com/auth/drive</font>** https://www.googleapis.com/auth/drive.readonly profile&amp;
 redirect_uri=urn:ietf:wg:oauth:2.0:oob&amp;
 response_type=code&amp;
 client_id=826380598768-5935tlo90sccvr691ofmp4nrvpthrnn6.apps.googleusercontent.com```

代码如下：
```
package com.yqu.gd;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.FileContent;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.File;
import com.google.api.services.drive.model.FileList;

public class HelloGoogleDrive {
  
  private static final String APPLICATION_NAME =
    "Hello Google Drive API";

  
  private static final JsonFactory JSON_FACTORY =
    JacksonFactory.getDefaultInstance();

  
  private static HttpTransport HTTP_TRANSPORT;

  static {
    try {
      HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
    } catch (Throwable t) {
      t.printStackTrace();
      System.exit(1);
    }
  }
  
  
  public static Credential authorize(String accessToken) throws IOException {
    Credential credential = new GoogleCredential()
    .setAccessToken(accessToken);
    return credential;
  }
  
  
  public static Drive getDriveService(String accessToken) throws IOException {
    Credential credential = authorize(accessToken);
    return new Drive.Builder(
        HTTP_TRANSPORT, JSON_FACTORY, credential)
        .setApplicationName(APPLICATION_NAME)
        .build();
  }
  
  public static void listFiles(Drive service) throws IOException {
    // Print the names and IDs for up to 10 files.
    FileList result = service.files().list()
       .setPageSize(10)
       .setFields("nextPageToken, files(id, name)")
       .execute();
    List files = result.getFiles();
    if (files == null || files.size() == 0) {
      System.out.println("No files found.");
    } else {
      System.out.println("Files:");
      for (File file : files) {
        System.out.printf("%s (%s)\n", 
        file.getName(), file.getId());
      }
    }
  }
  
  public static void createFile(Drive service, String newFileName, 
      String folderId) throws IOException {
    File fileMetadata = new File();
    fileMetadata.setName(newFileName);
    fileMetadata.setMimeType("application/vnd.google-apps.spreadsheet");
    if(folderId!=null &amp;&amp; !folderId.isEmpty()) {
      fileMetadata.setParents(Collections.singletonList(folderId));
    }
    
    File filePath = new File("c:/gdtest/test.csv"); **<font color="#FF0000">//本行File包为java.io</font>**
    FileContent mediaContent = new FileContent("text/csv", filePath);
    
    File file = service.files().create(fileMetadata, mediaContent)
        .setFields("id, parents")
        .execute();
    System.out.println("File ID: " + file.getId());
  }
  
  public static void main(String[] args) 
      throws IOException {
    String accessToken = "ya29....";
    
    // Build a new authorized API client service.
    Drive service = getDriveService(accessToken);
    
    createFile(service, "WhatWillBeByJava", "0B5VEVzefQLGxX2loMGhQcEVBc00";
    
    listFiles(service);    
  }
}
```

创建的新文件WhatWillBeByJava在Google Drive中显示的是GoogleSheet类型图标，可由Google Sheet打开。程序日志如下：
```
File ID: 1APh0cJKSMfrqrfs4AsYq4m674ZHzVLXUnSbAKdVLdgk
Files:
WhatWillBeBy
WhatWillBe.csv (0B5VEVzefQLGxNERVZzlwa0gxQzg)
2013sales.xls (164YAJYgp5E0jp4qL-ucOV2PTOqPpoYdjFtf47tUit5U)
2013sales.xls (0B5VEVzefQLGxMkl3TldkMG5OejQ)
Class_cn_Tab.csv (0B5VEVzefQLGxMVpTVzd4WF8wWnc)
FolderTest1 (0B5VEVzefQLGxX2loMGhQcEVBc00)
SpreadSheetCreate1 (1RRKvO7TBp1haRp4eJQU4-UX0AXXOVwxwXOXhXCHp9mM)
SpreadSheetTest1 (1nAsY7MDdsuktiUHLPr82dfmXqRIqJSVriAhDKpsUMe0)
To-do list (1m5YXGewJ6SCafNaALObghkfAr4WoIwSCAV0HkLp8H-A)
Getting started (0B5VEVzefQLGxc3RhcnRlcl9maWxl)```

### 相关Scope

- 查看和管理Google Drive中的文件：https://www.googleapis.com/auth/drive
- 查看和管理Google Drive中的配置数据：https://www.googleapis.com/auth/drive.appdata
- 查看和管理当前应用所打开/创建Google Drive文件和目录：https://www.googleapis.com/auth/drive.file
- 查看和管理Google Drive中的文件元数据：https://www.googleapis.com/auth/drive.metadata
- 查看Google Drive中的文件元数据：https://www.googleapis.com/auth/drive.metadata.readonly
- 查看Google Drive中的图片、视频和相册：https://www.googleapis.com/auth/drive.photos.readonly
- 查看Google Drive中的文件：https://www.googleapis.com/auth/drive.readonly

### 学习结论

Google Drive API可以获取用户、驱动及系统容量信息，对文件及其权限、评论和版本等进行操作。

### 参考

[Google Drive](https://drive.google.com/drive/my-drive)    
[Google Drive APIs](https://developers.google.com/drive/)    
[Google API Explorer: Drive](https://developers.google.com/apis-explorer/#search/drive/drive/v3/)    