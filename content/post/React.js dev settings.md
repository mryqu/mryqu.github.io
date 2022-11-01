---
title: 'React.js开发环境设置'
date: 2020-04-19 12:01:23
categories: 
- 前端
tags: 
- react

---

### 设置Node.js和NPM

升级Node(n不支持Windows操作系统)：  
```
node -v              #查看Node版本
npm cache clean -f   #清除Node的缓存
npm install -g n     #安装n工具，该工具是专门管理Node版本的工具
n stable             #安装最新稳定的Node版本
```

升级NPM：  
```
npm -v                      #查看NPM版本 
npm install npm@latest -g   #安装最新稳定的NPM版本
```

我在两台机器上安装了Node 12.16.2 TLS，其中一台机器上npm死活有问题，从Node 10.16版本开始总是报错`verbose stack TypeError: Cannot read property 'resolve' of undefined`。  
最后在那台机器上重新安装了[Node 10.15.3](https://nodejs.org/download/release/v10.15.3/),才避免了问题。  
  
### 安装Chrome插件React Developer Tools
  
从[Chrome Extensions](https://chrome.google.com/webstore/category/extensions)上搜索React Developer Tools进行安装。  
![install React Dev Tools](/images/2020/4/ChromeExtension_ReactDevTools.png) 
安装后，在Chrome开发者工具中可以看到React的Components和Profiler两个Tab并使用。  
![use React Dev Tools](/images/2020/4/ReactDevTools_DebugDemo.png) 
   
### 安装脚手架create-react-app
  
```
npm install -g create-react-app
```

### 使用create-react-app创建React项目

```
C:\devpg>create-react-app hello-react

Creating a new React app in  C:\devpg\hello-react.

Installing packages. This might take a couple of minutes.
Installing react, react-dom, and react-scripts with cra-template...


> core-js@2.6.11 postinstall  C:\devpg\hello-react\node_modules\babel-runtime\node_modules\core-js
> node -e "try{require('./postinstall')}catch(e){}"


> core-js@3.6.5 postinstall  C:\devpg\hello-react\node_modules\core-js
> node -e "try{require('./postinstall')}catch(e){}"


> core-js-pure@3.6.5 postinstall  C:\devpg\hello-react\node_modules\core-js-pure
> node -e "try{require('./postinstall')}catch(e){}"

+ cra-template@1.0.3
+ react-scripts@3.4.1
+ react@16.13.1
+ react-dom@16.13.1
added 1606 packages from 750 contributors and audited 931196 packages in 2128.923s
found 0 vulnerabilities


Initialized a git repository.

Installing template dependencies using npm...
npm WARN react-scripts@3.4.1 requires a peer of typescript@^3.2.1 but none is installed. You must install peer dependencies yourself.
npm WARN sass-loader@8.0.2 requires a peer of node-sass@^4.0.0 but none is installed. You must install peer dependencies yourself.
npm WARN sass-loader@8.0.2 requires a peer of sass@^1.3.0 but none is installed. You must install peer dependencies yourself.
npm WARN sass-loader@8.0.2 requires a peer of fibers@>= 3.1.0 but none is installed. You must install peer dependencies yourself.
npm WARN tsutils@3.17.1 requires a peer of typescript@>=2.8.0 || >= 3.2.0-dev || >= 3.3.0-dev || >= 3.4.0-dev || >= 3.5.0-dev || >= 3.6.0-dev || >= 3.6.0-beta || >= 3.7.0-dev || >= 3.7.0-beta but none is installed. You must install peer dependencies yourself.
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@2.1.2 (node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@2.1.2: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.12 (node_modules\webpack-dev-server\node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.12: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.12 (node_modules\watchpack\node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.12: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.12 (node_modules\jest-haste-map\node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.12: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})

+ @testing-library/jest-dom@4.2.4
+ @testing-library/react@9.5.0
+ @testing-library/user-event@7.2.1
added 36 packages from 56 contributors and audited 931402 packages in 81.133s
found 0 vulnerabilities

Removing template package using npm...

npm WARN react-scripts@3.4.1 requires a peer of typescript@^3.2.1 but none is installed. You must install peer dependencies yourself.
npm WARN sass-loader@8.0.2 requires a peer of node-sass@^4.0.0 but none is installed. You must install peer dependencies yourself.
npm WARN sass-loader@8.0.2 requires a peer of sass@^1.3.0 but none is installed. You must install peer dependencies yourself.
npm WARN sass-loader@8.0.2 requires a peer of fibers@>= 3.1.0 but none is installed. You must install peer dependencies yourself.
npm WARN tsutils@3.17.1 requires a peer of typescript@>=2.8.0 || >= 3.2.0-dev || >= 3.3.0-dev || >= 3.4.0-dev || >= 3.5.0-dev || >= 3.6.0-dev || >= 3.6.0-beta || >= 3.7.0-dev || >= 3.7.0-beta but none is installed. You must install peer dependencies yourself.
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@2.1.2 (node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@2.1.2: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.12 (node_modules\webpack-dev-server\node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.12: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.12 (node_modules\watchpack\node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.12: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.12 (node_modules\jest-haste-map\node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.12: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})

removed 1 package and audited 931401 packages in 11.837s
found 0 vulnerabilities


Created git commit.

Success! Created hello-react at  C:\devpg\hello-react
Inside that directory, you can run several commands:

  npm start
    Starts the development server.

  npm run build
    Bundles the app into static files for production.

  npm test
    Starts the test runner.

  npm run eject
    Removes this tool and copies build dependencies, configuration files
    and scripts into the app directory. If you do this, you can’t go back!

We suggest that you begin by typing:

  cd hello-react
  npm start

Happy hacking!

 C:\devpg>
```
要是觉得npm下载挺慢的，可以提前改用国内taobao的npm源：`npm config set registry https://registry.npm.taobao.org`。

### 使用IntelliJ创建React项目

![create React prj in IntelliJ - 1](/images/2020/4/intellij_ReactPrj1.png)  

![create React prj in IntelliJ - 2](/images/2020/4/intellij_ReactPrj2.png)  

![create React prj in IntelliJ - 3](/images/2020/4/intellij_ReactPrj3.png) 
  
### 参考

* [n – Interactively Manage Your Node.js Versions](https://www.npmjs.com/package/n)  
* [Cannot read property 'resolve' of undefined #1941](https://github.com/nodejs/help/issues/1941)  
* [Try the latest stable version of npm](https://docs.npmjs.com/try-the-latest-stable-version-of-npm)  
