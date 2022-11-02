---
title: '折腾openui5-sample-app之使用Yarn替换Bower'
date: 2018-09-13
categories: 
- FrontEnd
tags: 
- build
- nodejs
- npm
- yarn
- bower
- 包管理器
---

[SAP/openui5-sample-app](https://github.com/SAP/openui5-sample-app)是使用[npm](https://www.npmjs.com/)下载依赖的后端开发和构建模块，使用[bower](https://bower.io/)下载依赖的前端openui5库。
在npm install的过程中提示"npm WARN deprecated bower@1.8.4: We don't recommend using Bower for new projects. Please consider Yarn and Webpack or Parcel. You can read how to migrate legacy project here: https://bower.io/blog/2017/how-to-migrate-away-from-bower/"。
对于SAP这个小示例，区分前端和后端使用包管理器有点浪费！对于所有的依赖模块，可以要么使用[npm](https://www.npmjs.com/)，要么使用[yarn](https://yarnpkg.com/en/)。

1. 删除bower_components和dist目录

2. 安装yarn：
```
npm install yarn -g
```

3. 去掉[bower.json](https://github.com/SAP/openui5-sample-app/blob/master/bower.json)
不过其中依赖的[openui5/packaged-sap.ui.core](https://github.com/openui5/packaged-sap.ui.core)、[openui5/packaged-sap.m](https://github.com/openui5/packaged-sap.m)、[openui5/packaged-themelib_sap_belize](https://github.com/openui5/packaged-themelib_sap_belize)仅仅[bower](https://bower.io/)能够获取，在[npm](https://www.npmjs.com/)仓库里是找不到的。

4. 修改package.json
- 去除bower模块
- 去除postinstall脚本
- 增加@openui5/sap.m依赖
- 增加@openui5/sap.ui.core依赖
- 增加@openui5/themelib_sap_belize依赖
![package.json改动](/images/2018/09/openui5-sample-app-yarn-package.png)

5. 修改Gruntfile.js
[npm](https://www.npmjs.com/)仓库里的@openui5/sap.m、@openui5/sap.ui.core、@openui5/themelib_sap_belize仅包含[openui5/packaged-sap.ui.core](https://github.com/openui5/packaged-sap.ui.core)、[openui5/packaged-sap.m](https://github.com/openui5/packaged-sap.m)、[openui5/packaged-themelib_sap_belize](https://github.com/openui5/packaged-themelib_sap_belize)中resources的部分，而不包含test-resources的部分。
对于openui5_connect任务，我认为无需test-resources部分即可。
- 将openui5库的定位从bower_components目录下改为node_modules目录下的相应位置
![Gruntfile.js改动](/images/2018/09/openui5-sample-app-yarn-gruntfile.png)

6. 构建测试
```
yarn
grunt build
grunt serve
```

# 参考
-----
[SAP/grunt-openui5](https://github.com/SAP/grunt-openui5)  
[JS新包管理工具yarn和npm的对比与使用入门](https://www.jb51.net/article/99536.htm)  