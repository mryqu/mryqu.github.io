---
title: '在Google Drive上创建存在多个目录下的文件'
date: 2016-12-29 06:10:45
categories: 
- DataBuilder
tags: 
- google drive
- multiple
- parent
- file
---
### 准备环境

在Google Drive上创建两个目录: parent1和parent2
![GoogleDrive: Folder parent1](/content/images/2016/12/gdFolder_parent1.png) ![GoogleDrive: Folder parent2](/content/images/2016/12/gdFolder_parent2.png)

### 代码
```
package com.yqu.gd;

import java.io.IOException;
import java.util.ArrayList;
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

public class FileWithMultiParents {

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
      List folderIds) throws IOException {
    File fileMetadata = new File();
    fileMetadata.setName(newFileName);
    fileMetadata.setMimeType("application/vnd.google-apps.spreadsheet");
    if(folderIds!=null && !folderIds.isEmpty()) {
      fileMetadata.setParents(folderIds);
    }

    File filePath = new File("c:/gdtest/test.csv"); //本行File包为java.io
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

    List parentIds = new ArrayList();
    parentIds.add("0B5VEVzefQLGxZTVPZ1V1eGxrcE0");
    parentIds.add("0B5VEVzefQLGxVmpXc3diV3EyLWc");

    createFile(service, "HiMultiParents", parentIds);

    listFiles(service);    
  }
}
```

### 查看结果

在两个目录parent1和parent2下都发现所创建的HiMultiParents文件：
![GoogleDrive: Multi-parent file in folder parent1](/content/images/2016/12/gdFolder_parent1_file.png) ![GoogleDrive: Multi-parent file in folder parent2](/content/images/2016/12/gdFolder_parent2_file.png)
通过HiMultiParents属性也可知存放在两个目录下：![GoogleDrive: Multi-parent file properties](/content/images/2016/12/gdMultiParentFile.png)
此外，在任何一个目录下删除该文件，另一个目录下的文件也将不存在。