---
title: 'Upload file to Google Drive using LibCurl'
date: 2017-01-06 05:26:57
categories: 
- DataBuilder
tags: 
- upload
- google drive
- api
- libcurl
---
This is a sequel to my last blog "[Upload file to Google Drive using Postman and cURL](/post/upload_file_to_google_drive_using_postman_and_curl)".  
I wrote C++ code using LibCurl to redo the three types of upload, and all of them work which shown in the below log snippet.

### Simple upload
```
=> Send header, 0000000309 bytes (0x00000135)
0000: 50 4f 53 54 20 2f 75 70 6c 6f 61 64 2f 64 72 69 POST /upload/dri
0010: 76 65 2f 76 33 2f 66 69 6c 65 73 3f 75 70 6c 6f ve/v3/files?uplo
0020: 61 64 54 79 70 65 3d 6d 65 64 69 61 26 61 63 63 adType=media&acc
0030: 65 73 73 5f 74 6f 6b 65 6e 3d 79 61 32 39 2e 47 ess_token=ya29.G
######################################################################
00b0: 6e 6c 4c 46 5f 4e 51 78 57 32 48 20 48 54 54 50 nlLF_NQxW2H HTTP
00c0: 2f 31 2e 31 0d 0a 48 6f 73 74 3a 20 77 77 77 2e /1.1..Host: www.
00d0: 67 6f 6f 67 6c 65 61 70 69 73 2e 63 6f 6d 0d 0a googleapis.com..
00e0: 41 63 63 65 70 74 3a 20 2a 2f 2a 0d 0a 63 61 63 Accept: **.
00f0: 0a 63 61 63 68 65 2d 63 6f 6e 74 72 6f 6c 3a 20 .cache-control: 
0100: 6e 6f 2d 63 61 63 68 65 0d 0a 63 6f 6e 74 65 6e no-cache..conten
0110: 74 2d 74 79 70 65 3a 20 61 70 70 6c 69 63 61 74 t-type: applicat
0120: 69 6f 6e 2f 6a 73 6f 6e 3b 20 63 68 61 72 73 65 ion/json; charse
0130: 74 3d 55 54 46 2d 38 0d 0a 58 2d 55 70 6c 6f 61 t=UTF-8..X-Uploa
0140: 64 2d 43 6f 6e 74 65 6e 74 2d 54 79 70 65 3a 74 d-Content-Type:t
0150: 65 78 74 2f 63 73 76 0d 0a 58 2d 55 70 6c 6f 61 ext/csv..X-Uploa
0160: 64 2d 43 6f 6e 74 65 6e 74 2d 4c 65 6e 67 74 68 d-Content-Length
0170: 3a 38 33 38 31 39 33 35 0d 0a 43 6f 6e 74 65 6e :8381935..Conten
0180: 74 2d 4c 65 6e 67 74 68 3a 20 33 32 0d 0a 0d 0a t-Length: 32....
=> Send data, 0000000032 bytes (0x00000020)
0000: 7b 22 6e 61 6d 65 22 3a 22 6d 72 79 71 75 2d 63 {"name":"mryqu-c
0010: 73 76 2d 72 75 70 6c 6f 61 64 2e 63 73 76 22 7d sv-rupload.csv"}
<= Recv header, 0000000017 bytes (0x00000011)
0000: 48 54 54 50 2f 31 2e 31 20 32 30 30 20 4f 4b 0d HTTP/1.1 200 OK.
0010: 0a                                              .
<= Recv header, 0000000122 bytes (0x0000007a)
0000: 58 2d 47 55 70 6c 6f 61 64 65 72 2d 55 70 6c 6f X-GUploader-Uplo
0010: 61 64 49 44 3a 20 41 45 6e 42 32 55 6f 71 5a 33 adID: AEnB2UoqZ3
0020: 6b 2d 35 66 2d 6a 43 55 39 68 47 59 77 47 42 79 k-5f-jCU9hGYwGBy
0030: 4c 6e 55 66 2d 61 67 42 4f 49 66 45 46 4f 76 4e LnUf-agBOIfEFOvN
0040: 6c 70 73 57 55 31 79 62 73 46 30 5f 35 64 66 45 lpsWU1ybsF0_5dfE
0050: 57 78 6e 51 69 6a 50 6b 51 71 75 4b 43 50 7a 63 WxnQijPkQquKCPzc
0060: 4d 55 35 63 70 5a 6a 44 55 36 38 51 4d 56 65 57 MU5cpZjDU68QMVeW
0070: 44 42 7a 6f 79 37 62 77 0d 0a                   DBzoy7bw..
<= Recv header, 0000000333 bytes (0x0000014d)
0000: 4c 6f 63 61 74 69 6f 6e 3a 20 68 74 74 70 73 3a Location: https:
0010: 2f 2f 77 77 77 2e 67 6f 6f 67 6c 65 61 70 69 73 //www.googleapis
0020: 2e 63 6f 6d 2f 75 70 6c 6f 61 64 2f 64 72 69 76 .com/upload/driv
0030: 65 2f 76 33 2f 66 69 6c 65 73 3f 75 70 6c 6f 61 e/v3/files?uploa
0040: 64 54 79 70 65 3d 72 65 73 75 6d 61 62 6c 65 26 dType=resumable&
0050: 61 63 63 65 73 73 5f 74 6f 6b 65 6e 3d 79 61 32 access_token=ya2
######################################################################
00d0: 6d 61 77 6e 6c 4c 46 5f 4e 51 78 57 32 48 26 75 mawnlLF_NQxW2H&u
00e0: 70 6c 6f 61 64 5f 69 64 3d 41 45 6e 42 32 55 6f pload_id=AEnB2Uo
00f0: 71 5a 33 6b 2d 35 66 2d 6a 43 55 39 68 47 59 77 qZ3k-5f-jCU9hGYw
0100: 47 42 79 4c 6e 55 66 2d 61 67 42 4f 49 66 45 46 GByLnUf-agBOIfEF
0110: 4f 76 4e 6c 70 73 57 55 31 79 62 73 46 30 5f 35 OvNlpsWU1ybsF0_5
0120: 64 66 45 57 78 6e 51 69 6a 50 6b 51 71 75 4b 43 dfEWxnQijPkQquKC
0130: 50 7a 63 4d 55 35 63 70 5a 6a 44 55 36 38 51 4d PzcMU5cpZjDU68QM
0140: 56 65 57 44 42 7a 6f 79 37 62 77 0d 0a          VeWDBzoy7bw..
<= Recv header, 0000000014 bytes (0x0000000e)
0000: 56 61 72 79 3a 20 4f 72 69 67 69 6e 0d 0a       Vary: Origin..
<= Recv header, 0000000016 bytes (0x00000010)
0000: 56 61 72 79 3a 20 58 2d 4f 72 69 67 69 6e 0d 0a Vary: X-Origin..
<= Recv header, 0000000063 bytes (0x0000003f)
0000: 43 61 63 68 65 2d 43 6f 6e 74 72 6f 6c 3a 20 6e Cache-Control: n
0010: 6f 2d 63 61 63 68 65 2c 20 6e 6f 2d 73 74 6f 72 o-cache, no-stor
0020: 65 2c 20 6d 61 78 2d 61 67 65 3d 30 2c 20 6d 75 e, max-age=0, mu
0030: 73 74 2d 72 65 76 61 6c 69 64 61 74 65 0d 0a    st-revalidate..
<= Recv header, 0000000018 bytes (0x00000012)
0000: 50 72 61 67 6d 61 3a 20 6e 6f 2d 63 61 63 68 65 Pragma: no-cache
0010: 0d 0a                                           ..
<= Recv header, 0000000040 bytes (0x00000028)
0000: 45 78 70 69 72 65 73 3a 20 4d 6f 6e 2c 20 30 31 Expires: Mon, 01
0010: 20 4a 61 6e 20 31 39 39 30 20 30 30 3a 30 30 3a  Jan 1990 00:00:
0020: 30 30 20 47 4d 54 0d 0a                         00 GMT..
<= Recv header, 0000000037 bytes (0x00000025)
0000: 44 61 74 65 3a 20 ############################################## 
0020: 47 4d 54 0d 0a                                  GMT..
<= Recv header, 0000000019 bytes (0x00000013)
0000: 43 6f 6e 74 65 6e 74 2d 4c 65 6e 67 74 68 3a 20 Content-Length: 
0010: 30 0d 0a                                        0..
<= Recv header, 0000000022 bytes (0x00000016)
0000: 53 65 72 76 65 72 3a 20 55 70 6c 6f 61 64 53 65 Server: UploadSe
0010: 72 76 65 72 0d 0a                               rver..
<= Recv header, 0000000040 bytes (0x00000028)
0000: 43 6f 6e 74 65 6e 74 2d 54 79 70 65 3a 20 74 65 Content-Type: te
0010: 78 74 2f 68 74 6d 6c 3b 20 63 68 61 72 73 65 74 xt/html; charset
0020: 3d 55 54 46 2d 38 0d 0a                         =UTF-8..
<= Recv header, 0000000045 bytes (0x0000002d)
0000: 41 6c 74 2d 53 76 63 3a 20 71 75 69 63 3d 22 3a Alt-Svc: quic=":
0010: 34 34 33 22 3b 20 6d 61 3d 32 35 39 32 30 30 30 443"; ma=2592000
0020: 3b 20 76 3d 22 33 35 2c 33 34 22 0d 0a          ; v="35,34"..
<= Recv header, 0000000002 bytes (0x00000002)
0000: 0d 0a                                           ..
== Info: Connection #0 to host www.googleapis.com left intact

=> Send header, 0000000429 bytes (0x000001ad)
0000: 50 4f 53 54 20 2f 75 70 6c 6f 61 64 2f 64 72 69 POST /upload/dri
0010: 76 65 2f 76 33 2f 66 69 6c 65 73 3f 75 70 6c 6f ve/v3/files?uplo
0020: 61 64 54 79 70 65 3d 72 65 73 75 6d 61 62 6c 65 adType=resumable
0030: 26 61 63 63 65 73 73 5f 74 6f 6b 65 6e 3d 79 61 &access_token=ya
######################################################################
00b0: 4e 6d 61 77 6e 6c 4c 46 5f 4e 51 78 57 32 48 26 NmawnlLF_NQxW2H&
00c0: 75 70 6c 6f 61 64 5f 69 64 3d 41 45 6e 42 32 55 upload_id=AEnB2U
00d0: 6f 71 5a 33 6b 2d 35 66 2d 6a 43 55 39 68 47 59 oqZ3k-5f-jCU9hGY
00e0: 77 47 42 79 4c 6e 55 66 2d 61 67 42 4f 49 66 45 wGByLnUf-agBOIfE
00f0: 46 4f 76 4e 6c 70 73 57 55 31 79 62 73 46 30 5f FOvNlpsWU1ybsF0_
0100: 35 64 66 45 57 78 6e 51 69 6a 50 6b 51 71 75 4b 5dfEWxnQijPkQquK
0110: 43 50 7a 63 4d 55 35 63 70 5a 6a 44 55 36 38 51 CPzcMU5cpZjDU68Q
0120: 4d 56 65 57 44 42 7a 6f 79 37 62 77 20 48 54 54 MVeWDBzoy7bw HTT
0130: 50 2f 31 2e 31 0d 0a 48 6f 73 74 3a 20 77 77 77 P/1.1..Host: www
0140: 2e 67 6f 6f 67 6c 65 61 70 69 73 2e 63 6f 6d 0d .googleapis.com.
0150: 0a 41 63 63 65 70 74 3a 20 2a 2f 2a 0d 0a 54 72 .Accept: */*..Tr
0160: 61 6e 73 66 65 72 2d 45 6e 63 6f 64 69 6e 67 3a ansfer-Encoding:
0170: 20 63 68 75 6e 6b 65 64 0d 0a 63 61 63 68 65 2d  chunked..cache-
0180: 63 6f 6e 74 72 6f 6c 3a 20 6e 6f 2d 63 61 63 68 control: no-cach
0190: 65 0d 0a 63 6f 6e 74 65 6e 74 2d 74 79 70 65 3a e..content-type:
01a0: 20 74 65 78 74 2f 63 73 76 0d 0a 0d 0a           text/csv....
=> Send data, 0000016380 bytes (0x00003ffc)
0000: 33 66 66 34 0d 0a 43 4f 55 4e 54 52 59 2c 53 54 3ff4..COUNTRY,ST
######################################################################
3fe0: 55 2e 53 2e 41 2e 2c 43 61 6c 69 66 6f 72 6e 69 U.S.A.,Californi
3ff0: 61 2c 2c 22 24 31 2c 30 33 37 0d 0a             a,,"$1,037..
=> Send data, 0000016380 bytes (0x00003ffc)
0000: 33 66 66 34 0d 0a 2e 30 30 20 22 2c 22 24 31 2c 3ff4...00 ","$1,
0010: 32 32 38 2e 30 30 20 22 2c 46 55 52 4e 49 54 55 228.00 ",FURNITU
######################################################################
3fe0: 2c 37 33 34 2e 30 30 20 22 2c 46 55 52 4e 49 54 ,734.00 ",FURNIT
3ff0: 55 52 45 2c 42 45 44 2c 31 39 0d 0a             URE,BED,19..
=> Send data, 0000016380 bytes (0x00003ffc)
0000: 33 66 66 34 0d 0a 39 37 2c 31 2c 46 65 62 2c 46 3ff4..97,1,Feb,F
0010: 65 62 2d 39 37 2c 55 2e 53 2e 41 2e 2c 43 61 6c eb-97,U.S.A.,Cal
######################################################################
3fe0: 2c 43 61 6c 69 66 6f 72 6e 69 61 2c 2c 22 24 31 ,California,,"$1
3ff0: 2c 32 39 30 2e 33 30 20 22 2c 0d 0a             ,290.30 ",..
######################################################################
######################################################################
=> Send data, 0000015851 bytes (0x00003deb)
0000: 33 64 65 33 0d 0a 69 6e 67 74 6f 6e 2c 2c 22 24 3de3..ington,,"$
0010: 31 2c 38 33 34 2e 30 30 20 22 2c 22 24 31 2c 32 1,834.00 ","$1,2
######################################################################
3dd0: 55 52 45 2c 42 45 44 2c 31 39 39 38 2c 32 2c 4d URE,BED,1998,2,M
3de0: 61 79 2c 4d 61 79 2d 39 38 0d 0a                ay,May-98..
=> Send data, 0000000005 bytes (0x00000005)
0000: 30 0d 0a 0d 0a                                  0....
<= Recv header, 0000000017 bytes (0x00000011)
0000: 48 54 54 50 2f 31 2e 31 20 32 30 30 20 4f 4b 0d HTTP/1.1 200 OK.
0010: 0a                                              .
<= Recv header, 0000000122 bytes (0x0000007a)
0000: 58 2d 47 55 70 6c 6f 61 64 65 72 2d 55 70 6c 6f X-GUploader-Uplo
0010: 61 64 49 44 3a 20 41 45 6e 42 32 55 6f 71 5a 33 adID: AEnB2UoqZ3
0020: 6b 2d 35 66 2d 6a 43 55 39 68 47 59 77 47 42 79 k-5f-jCU9hGYwGBy
0030: 4c 6e 55 66 2d 61 67 42 4f 49 66 45 46 4f 76 4e LnUf-agBOIfEFOvN
0040: 6c 70 73 57 55 31 79 62 73 46 30 5f 35 64 66 45 lpsWU1ybsF0_5dfE
0050: 57 78 6e 51 69 6a 50 6b 51 71 75 4b 43 50 7a 63 WxnQijPkQquKCPzc
0060: 4d 55 35 63 70 5a 6a 44 55 36 38 51 4d 56 65 57 MU5cpZjDU68QMVeW
0070: 44 42 7a 6f 79 37 62 77 0d 0a                   DBzoy7bw..
<= Recv header, 0000000014 bytes (0x0000000e)
0000: 56 61 72 79 3a 20 4f 72 69 67 69 6e 0d 0a       Vary: Origin..
<= Recv header, 0000000016 bytes (0x00000010)
0000: 56 61 72 79 3a 20 58 2d 4f 72 69 67 69 6e 0d 0a Vary: X-Origin..
<= Recv header, 0000000047 bytes (0x0000002f)
0000: 43 6f 6e 74 65 6e 74 2d 54 79 70 65 3a 20 61 70 Content-Type: ap
0010: 70 6c 69 63 61 74 69 6f 6e 2f 6a 73 6f 6e 3b 20 plication/json; 
0020: 63 68 61 72 73 65 74 3d 55 54 46 2d 38 0d 0a    charset=UTF-8..
<= Recv header, 0000000063 bytes (0x0000003f)
0000: 43 61 63 68 65 2d 43 6f 6e 74 72 6f 6c 3a 20 6e Cache-Control: n
0010: 6f 2d 63 61 63 68 65 2c 20 6e 6f 2d 73 74 6f 72 o-cache, no-stor
0020: 65 2c 20 6d 61 78 2d 61 67 65 3d 30 2c 20 6d 75 e, max-age=0, mu
0030: 73 74 2d 72 65 76 61 6c 69 64 61 74 65 0d 0a    st-revalidate..
<= Recv header, 0000000018 bytes (0x00000012)
0000: 50 72 61 67 6d 61 3a 20 6e 6f 2d 63 61 63 68 65 Pragma: no-cache
0010: 0d 0a                                           ..
<= Recv header, 0000000040 bytes (0x00000028)
0000: 45 78 70 69 72 65 73 3a 20 4d 6f 6e 2c 20 30 31 Expires: Mon, 01
0010: 20 4a 61 6e 20 31 39 39 30 20 30 30 3a 30 30 3a  Jan 1990 00:00:
0020: 30 30 20 47 4d 54 0d 0a                         00 GMT..
<= Recv header, 0000000037 bytes (0x00000025)
0000: 44 61 74 65 3a 20 ############################################## 
0020: 47 4d 54 0d 0a                                  GMT..
<= Recv header, 0000000021 bytes (0x00000015)
0000: 43 6f 6e 74 65 6e 74 2d 4c 65 6e 67 74 68 3a 20 Content-Length: 
0010: 31 32 34 0d 0a                                  124..
<= Recv header, 0000000022 bytes (0x00000016)
0000: 53 65 72 76 65 72 3a 20 55 70 6c 6f 61 64 53 65 Server: UploadSe
0010: 72 76 65 72 0d 0a                               rver..
<= Recv header, 0000000045 bytes (0x0000002d)
0000: 41 6c 74 2d 53 76 63 3a 20 71 75 69 63 3d 22 3a Alt-Svc: quic=":
0010: 34 34 33 22 3b 20 6d 61 3d 32 35 39 32 30 30 30 443"; ma=2592000
0020: 3b 20 76 3d 22 33 35 2c 33 34 22 0d 0a          ; v="35,34"..
<= Recv header, 0000000002 bytes (0x00000002)
0000: 0d 0a                                           ..
<= Recv data, 0000000124 bytes (0x0000007c)
0000: 7b 0a 20 22 6b 69 6e 64 22 3a 20 22 64 72 69 76 {. "kind": "driv
0010: 65 23 66 69 6c 65 22 2c 0a 20 22 69 64 22 3a 20 e#file",. "id": 
0020: 22 30 42 35 56 45 56 7a 65 66 51 4c 47 78 61 33 "0B5VEVzefQLGxa3
0030: 68 54 4f 46 4d 77 62 30 35 4c 4c 54 41 22 2c 0a hTOFMwb05LLTA",.
0040: 20 22 6e 61 6d 65 22 3a 20 22 6d 72 79 71 75 2d  "name": "mryqu-
0050: 63 73 76 2d 72 75 70 6c 6f 61 64 2e 63 73 76 22 csv-rupload.csv"
0060: 2c 0a 20 22 6d 69 6d 65 54 79 70 65 22 3a 20 22 ,. "mimeType": "
0070: 74 65 78 74 2f 63 73 76 22 0a 7d 0a             text/csv".}.
```

### Reference
* * *
[Google Drive APIs - REST - Upload Files](https://developers.google.com/drive/v3/web/manage-uploads)  
[libcurl fileupload example](https://curl.haxx.se/libcurl/c/fileupload.html)  
[libcurl http2-upload example](https://curl.haxx.se/libcurl/c/http2-upload.html)  
[libcurl postit2 example](https://curl.haxx.se/libcurl/c/postit2.html)  
[libcurl multi-post example](https://curl.haxx.se/libcurl/c/multi-post.html)  
[libcurl ftpuploadresume example](https://curl.haxx.se/libcurl/c/ftpuploadresume.html)  