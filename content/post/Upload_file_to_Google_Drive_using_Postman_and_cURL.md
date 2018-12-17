---
title: 'Upload file to Google Drive using Postman and cURL'
date: 2017-01-03 05:07:44
categories: 
- DataBuilder
tags: 
- upload
- google drive
- postman
- curl
---
### Simple upload

For quick transfer of smaller files, for example, 5 MB or less.
#### Postman
![postman: google drive simple upload](/images/2017/01/gd_simpleUpload_postman.png) ![postman: google drive simple upload result](/images/2017/01/gd_simpleUploadRes_postman.png)
#### cURL
```
curl -T mytest.csv -X POST -H "Content-Type: text/csv" -H "Cache-Control: no-cache" "https://www.googleapis.com/upload/drive/v3/files?uploadType=media&access_token={YOUR_ACCESS_TOKEN}"
```

### Multipart upload

For quick transfer of smaller files and metadata; transfers the file along with metadata that describes it, all in a single request.
#### Postman
![postman: google drive multipart upload](/images/2017/01/gd_mpartUpload_postman.png) ![postman: google drive multipart upload result](/images/2017/01/gd_mpartUploadRes_postman.png)
At the beginning, I try to use form-data for body, then the second value can use file directly. But Postman can't configure Content-Type for each part, and Google Drive return error. I use raw data for body finally.
#### cURL
```
curl -X POST -H "Content-Type: multipart/related; boundary=foo_bar_baz" -H "Cache-Control: no-cache" -d '--foo_bar_baz
Content-Type: application/json; charset=UTF-8

{
  "name": "postman-gdmultipartupload"
}

--foo_bar_baz
Content-Type: text/csv

Name,Sex,Age,Height,Weight
Alfred,M,14,69,112.5
Alice,F,13,56.5,84
Barbara,F,13,65.3,98
Carol,F,14,62.8,102.5
--foo_bar_baz--' "https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart&access_token={YOUR_ACCESS_TOKEN}"
```

### Resumable upload

For reliable transfer, especially important with larger files. With this method, you use a session initiating request, which optionally can include metadata. This is a good strategy to use for most applications, since it also works for smaller files at the cost of one additional HTTP request per upload.
#### Postman
![postman: google drive resumable upload - step 1](/images/2017/01/gd_resumableUpload1_postman.png) ![postman: google drive resumable upload - step 2](/images/2017/01/gd_resumableUpload2_postman.png)
#### cURL
```
curl -X POST -H "Content-Type: application/json; charset=UTF-8" -H "X-Upload-Content-Type: text/csv" -H "Cache-Control: no-cache" -d '{
  "name": "postman-gdresumableupload"
}' "https://www.googleapis.com/upload/drive/v3/files?uploadType=resumable&access_token={YOUR_ACCESS_TOKEN}"

curl -X PUT -H "Content-Type: text/csv" -H "Cache-Control: no-cache" -d 'Name,Sex,Age,Height,Weight
Alfred,M,14,69,112.5
Alice,F,13,56.5,84
Barbara,F,13,65.3,98
Carol,F,14,62.8,102.5' "https://www.googleapis.com/upload/drive/v3/files?uploadType=resumable&access_token={YOUR_ACCESS_TOKEN}&upload_id={GOTTEN_UOLOAD_ID}"
```

### Reference
* * *
[Google Drive APIs - REST - Upload Files](https://developers.google.com/drive/v3/web/manage-uploads)  
[libcurl fileupload example](https://curl.haxx.se/libcurl/c/fileupload.html)  
[libcurl http2-upload example](https://curl.haxx.se/libcurl/c/http2-upload.html)  
[libcurl postit2 example](https://curl.haxx.se/libcurl/c/postit2.html)  
[libcurl multi-post example](https://curl.haxx.se/libcurl/c/multi-post.html)  
[libcurl ftpuploadresume example](https://curl.haxx.se/libcurl/c/ftpuploadresume.html)  