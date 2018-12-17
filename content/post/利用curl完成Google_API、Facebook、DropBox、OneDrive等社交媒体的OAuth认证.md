---
title: '利用curl完成Google API、Facebook、DropBox、OneDrive等社交媒体的OAuth认证'
date: 2015-09-14 06:22:41
categories: 
- DataBuilder
tags: 
- curl
- oauth
- google
- facebook
- onedrive
---
### Twitter

没法用curl完成Twitter认证，可以尝试[witter/twurl](https://github.com/twitter/twurl)。

### Facebook

通过curl命令获取访问密钥：
```
curl "https://graph.facebook.com/oauth/access_token?client_id={YOUR_APP_ID}&client_secret={YOUR_APP_SECRET}&grant_type=client_credentials"
```

### Google API

这里Google应用的客户端ID格式大概为XXX-YYY.apps.googleusercontent.com。

#### Google Analytics

首先通过浏览器访问下列链接获取code：
```
https://accounts.google.com/o/oauth2/v2/auth?scope=https://www.googleapis.com/auth/analytics.readonly%20profile&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&client_id={YOUR_APP_ID}
```

通过curl命令获取访问密钥：
```
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Cache-Control: no-cache" -d 'code={GOTTEN_CODE}&client_id={YOUR_APP_ID}&client_secret={YOUR_APP_SECRET}&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code' "https://www.googleapis.com/oauth2/v4/token"
```

#### Youtube Analytics

首先通过浏览器访问下列链接获取code：
```
https://accounts.google.com/o/oauth2/v2/auth?scope=https://www.googleapis.com/auth/yt-analytics.readonly%20profile&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&client_id={YOUR_APP_ID}
```

通过curl命令获取访问密钥：
```
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Cache-Control: no-cache" -d 'code={GOTTEN_CODE}&client_id={YOUR_APP_ID}&client_secret={YOUR_APP_SECRET}&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code' "https://www.googleapis.com/oauth2/v4/token"
```

#### Google drive & sheets

首先通过浏览器访问下列链接获取code：
```
https://accounts.google.com/o/oauth2/v2/auth?scope=https://www.googleapis.com/auth/spreadsheets%20https://www.googleapis.com/auth/drive%20profile&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&client_id={YOUR_APP_ID}
```

通过curl命令获取访问密钥：
```
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Cache-Control: no-cache" -d 'code={GOTTEN_CODE}&client_id={YOUR_APP_ID}&client_secret={YOUR_APP_SECRET}&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code' "https://www.googleapis.com/oauth2/v4/token"
```

### DropBox

首先通过浏览器访问下列链接获取code：
```
https://api.dropbox.com/1/oauth2/authorize?client_id={YOUR_APP_ID}&response_type=code&state=kx123
```

通过curl命令获取访问密钥：
```
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Cache-Control: no-cache" -d 'code={GOTTEN_CODE}&client_id={YOUR_APP_ID}&client_secret={YOUR_APP_SECRET}&grant_type=authorization_code' "https://api.dropboxapi.com/1/oauth2/token"
```

### OneDrive

首先通过浏览器访问下列链接获取code：
```
https://login.live.com/oauth20_authorize.srf?client_id={YOUR_APP_ID}&scope=onedrive.readonly+wl.signin&response_type=code&redirect_uri=https://login.live.com/oauth20_desktop.srf
```

通过curl命令获取访问密钥：
```
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Cache-Control: no-cache" -d 'client_id={YOUR_APP_ID}&redirect_uri=https://login.live.com/oauth20_desktop.srf&code={GOTTEN_CODE}&grant_type=authorization_code' "https://login.live.com/oauth20_token.srf"
```
