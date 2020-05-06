---
title: 'Vue.js开发环境设置'
date: 2020-04-20 06:01:23
categories: 
- 前端
tags: 
- vue

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
  
### 安装Chrome插件[vue-devtools](https://github.com/vuejs/vue-devtools)  
  
在[vue-devtools](https://github.com/vuejs/vue-devtools) github项目页面里找到Chrome插件网址，进行安装。
![install Vue.js Dev Tools](/images/2020/4/ChromeExtension_VueDevTools.png) 
安装后，在Chrome开发者工具中可以看到Vue Tab并使用。  
![use Vue Dev Tools](/images/2020/4/VueDevTools_DebugDemo.png) 
   
### 安装[Vue CLI](https://github.com/vuejs/vue-cli)  
  
```
npm install -g @vue/cli
```

### 使用[Vue CLI](https://github.com/vuejs/vue-cli)创建Vue项目

```
C:\ws>vue create hello-vue


Vue CLI v4.3.1
? Please pick a preset: default (babel, eslint)


Vue CLI v4.3.1
✨  Creating project in C:\ws\hello-vue.
🗃  Initializing git repository...
⚙️  Installing CLI plugins. This might take a while...


> yorkie@2.0.0 install C:\ws\hello-vue\node_modules\yorkie
> node bin/install.js

setting up Git hooks
done


> core-js@3.6.5 postinstall C:\ws\hello-vue\node_modules\core-js
> node -e "try{require('./postinstall')}catch(e){}"


> ejs@2.7.4 postinstall C:\ws\hello-vue\node_modules\ejs
> node ./postinstall.js

added 1203 packages from 845 contributors in 265.235s
🚀  Invoking generators...
📦  Installing additional dependencies...

added 54 packages from 39 contributors in 27.284s
⚓  Running completion hooks...

📄  Generating README.md...

🎉  Successfully created project hello-vue.
👉  Get started with the following commands:

 $ cd hello-vue
 $ npm run serve


C:\ws>
```

此外也可以使用`vue ui`以网页图形界面的方式创建Vue项目。  
要是觉得npm下载挺慢的，可以提前改用国内taobao的npm源：`npm config set registry https://registry.npm.taobao.org`。

### 使用IntelliJ创建Vue项目

首先需要安装Vue.js插件：  
![install Vue.js plugin in IntelliJ](/images/2020/4/intellij_VuePlugin.png)  

然后创建Vue.js项目：  
![create Vue prj in IntelliJ - 1](/images/2020/4/intellij_VuePrj1.png)  

![create Vue prj in IntelliJ - 2](/images/2020/4/intellij_VuePrj2.png)  

![create Vue prj in IntelliJ - 3](/images/2020/4/intellij_VuePrj3.png) 
  
### 参考

* [n – Interactively Manage Your Node.js Versions](https://www.npmjs.com/package/n)  
* [Cannot read property 'resolve' of undefined #1941](https://github.com/nodejs/help/issues/1941)  
* [Try the latest stable version of npm](https://docs.npmjs.com/try-the-latest-stable-version-of-npm)  
* [Intellij IDEA help - Vue.js](https://www.jetbrains.com/help/idea/vue-js.html)  
* [Intellij IDEA plugin - Vue.js](https://plugins.jetbrains.com/plugin/9442-vue-js)
