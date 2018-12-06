---
title: 'FileUpload Streaming'
date: 2015-12-13 06:02:47
categories: 
- Service及JavaEE
tags: 
- fileupload
- streaming
---
最近看一下org.apache.tomcat.util.http.fileupload，这个包是从commons-fileupload和commons-io复制而来，为了避免冲突而改名。
[Apache Commons FileUpload](http://commons.apache.org/proper/commons-fileupload/index.html)是用于servlet和web应用的健壮、高性能文件上传库，它支持 RFC 1867和RFC2047。
传统的文件上传API假设文件在被用户访问前必须存储在某处，这种途径便捷、易于访问，但是消耗内存和耗时。流处理API允许在高性能和低内存配置之间做一点折中。
首先，需要确保请求是一个文件上传请求。这通过与传统API相同的静态方法实现：
```
// Check that we have a file upload request
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
```

现在需要解析请求获取成分项：
```
// Create a new file upload handler
ServletFileUpload upload = new ServletFileUpload();

// Parse the request
FileItemIterator iter = upload.getItemIterator(request);
while (iter.hasNext()) {
  FileItemStream item = iter.next();
  if (!item.isFormField()) {
    String name = item.getFieldName();
    if(name==null) continue;
    InputStream stream = item.openStream();
    System.out.println("File field " + name + " with file name "
            + item.getName() + " detected.");
    // Process the input stream
    ...
  }
}```

这就是全部所需工作！
