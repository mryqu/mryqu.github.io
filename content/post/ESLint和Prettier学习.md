---
title: ESLint和Prettier学习  
date: 2020-05-01 06:01:23
categories: 
- 前端
tags:
- JavaScript
- ESLint
- Prettier
---

[Devias Kit - React Admin Dashboard](https://material-ui.com/store/items/devias-kit/)使用了ESLint进行代码检测，使用Prettier进行代码格式化。  
下面就其代码[devias-io/react-material-dashboard](https://github.com/devias-io/react-material-dashboard)进行学习。  

### ESLint简介  

[ESLint](https://eslint.org/)是一个用来识别ECMAScript/JavaScript并且按照规则给出报告的代码检测工具，使用它可以避免低级错误和统一代码的风格。如果每次在代码提交之前都进行一次ESLint代码检查，就不会因为某个字段未定义为undefined或null这样的错误而导致服务崩溃，可以有效的控制项目代码的质量。  

在许多方面，它和 JSLint、JSHint 相似，除了少数的例外：  
* ESLint使用Espree解析JavaScript。  
* ESLint使用AST去分析代码中的模式。  
* ESLint是完全插件化的。 每一个规则都是一个插件并且你可以在运行时添加更多的规则。  

### Prettier简介  

[Prettier](https://prettier.io/)是一个opinionated(有态度的)代码格式化工具，支持多种语言，可以和绝大多数编辑器集成，选项少。  
什么是opinionated？就是有态度有倾向，尽量减少配置项，相反的意思是Unopinionated。 像Spring Boot也是宣称有态度的。  
![Prettier supportted languanges and editors](/images/2020/5/PrettierSupport.png)  

### [devias-io/react-material-dashboard](https://github.com/devias-io/react-material-dashboard)开发环境依赖  

```
"devDependencies": {
  "eslint": "5.16.0",
  "eslint-plugin-prettier": "^3.0.1",
  "eslint-plugin-react": "^7.12.4",
  "prettier": "^1.17.1",
  "prettier-eslint": "^8.8.2",
  "prettier-eslint-cli": "^4.7.1",
  "typescript": "^3.5.1"
}
```

[ESLint包](https://www.npmjs.com/package/eslint)是代码检测工具，[Prettier包](https://www.npmjs.com/package/prettier)是代码格式化工具。 ESLint既能完成传统的语法检测，也能检查风格是否符合要求。可以用ESLint完成一切工作，也可以结合ESLint完成代码格式化和错误检测。  

其他包：  
* [ESLint-plugin-React包](https://www.npmjs.com/package/eslint-plugin-react)：ESLint原生支持JSX，但ESLint并不支持React特定的JSX符号，所以要使用ESLint-plugin-React包；  
* [prettier-eslint包](https://www.npmjs.com/package/prettier-eslint)：prettier-eslint会先调用Prettier完成代码格式化，然后将执行`eslint --fix`按照配置进行语法修复；  
* [prettier-eslint-cli包](https://www.npmjs.com/package/prettier-eslint-cli)：prettier-eslint的CLI；  
* [eslint-plugin-prettier包](https://www.npmjs.com/package/eslint-plugin-prettier)：作为ESLint的一个规则运行Prettier。  


[devias-io/react-material-dashboard](https://github.com/devias-io/react-material-dashboard)项目没有介绍怎么使用ESLint和Prettier。 如果使用prettier-eslint/prettier-eslint-cli，那就是次序使用Prettier和ESLint；如果使用eslint-plugin-prettier，就是Prettier作为ESLint的插件，在CLI仅仅使用ESLint，而ESLint会调用Prettier。  
通过.eslintrc分析，ESLint仅使用了react插件，而没有prettier插件，而且ESLint规则里面也没有prettier，所以其实没有使用eslint-plugin-prettier包。  
```
"plugins": [
  "react"
]
```

#### CLI  

上面的开发环境依赖所安装的包共有三个CLI可以使用：  
```
.\node_modules\.bin\eslint -h

.\node_modules\.bin\prettier -h

.\node_modules\.bin\prettier-eslint -h
```

### Prettier配置  

#### .prettierrc  

.prettierrc存储的是Prettier配置：  
```
{
  "bracketSpacing": true,
  "jsxBracketSameLine": true,
  "printWidth": 80,
  "singleQuote": true,
  "trailingComma": "none",
  "tabWidth": 2,
  "useTabs": false,
  "react/jsx-max-props-per-line": [1, { "when": "always" }]
}
```

规则项分析：  
* bracketSpacing：为true的话，在对象字面符和括号之间打印空格。 例如`{ foo: bar }`；  
* jsxBracketSameLine：为true的话，将多行JSX元素的`>`放在最后一行的末尾，而不是单独一行；  
* printWidth：为80的话，行宽超过80字符的会折行；  
* singleQuote：为true的话，使用单引号而不是双引号；  
* trailingComma：为"none"的话，数组最后一个元素不可以尾随逗号；  
* tabWidth：为2的话，缩进级别为2个空格；  
* useTabs：为false的话，使用空格而不是tab进行缩进；  
* react/jsx-max-props-per-line：为1的话，限制JSX单行中prop最大个数为1。该规则定义见ESLint-plugin-React包。  

#### .prettierignore  

.prettierignore存储的是让Prettier忽略的文件的路径模式，该项目中为空。

### ESLint配置  

#### .eslintrc  

.eslintrc存储的是ESLint配置：  
```
{
  "parser": "babel-eslint",
  "rules": {
    "comma-dangle": 0,
    "indent": [
      2,
      2,
      {
        "SwitchCase": 1
      }
    ],
    "jsx-quotes": 1,
    "linebreak-style": [
      2,
      "unix"
    ],
    "quotes": [
      2,
      "single"
    ],
    "react/display-name": 1,
    "react/forbid-prop-types": 0,
    "react/sort-prop-types": 1,
    "react/jsx-boolean-value": 1,
    "react/jsx-first-prop-new-line": [
      1,
      "multiline"
    ],
    "react/jsx-closing-bracket-location": 1,
    "react/jsx-curly-spacing": 1,
    "react/jsx-indent-props": [
      2,
      2
    ],
    "react/jsx-max-props-per-line": 1,
    "react/jsx-no-duplicate-props": 1,
    "react/jsx-no-literals": 0,
    "react/jsx-no-undef": 1,
    "react/jsx-sort-props": 1,
    "react/jsx-uses-react": 1,
    "react/jsx-uses-vars": 1,
    "react/no-danger": 1,
    "react/no-did-mount-set-state": 0,
    "react/no-did-update-set-state": 1,
    "react/no-direct-mutation-state": 1,
    "react/no-multi-comp": 1,
    "react/no-set-state": 1,
    "react/no-unknown-property": 1,
    "react/prefer-es6-class": 1,
    "react/prop-types": 1,
    "react/react-in-jsx-scope": 1,
    "react/self-closing-comp": 1,
    "react/sort-comp": 0,
    "semi": 0
  },
  "env": {
    "es6": true,
    "browser": true
  },
  "extends": "eslint:recommended",
  "ecmaFeatures": {
    "jsx": true,
    "experimentalObjectRestSpread": true
  },
  "plugins": [
    "react"
  ]
}
```

配置项分析：  
* plugins里指定react插件，所以规则里支持[ESLint-plugin-React](https://www.npmjs.com/package/eslint-plugin-react)里面的规则；  
* parser指定的是[babel-eslint](https://github.com/babel/babel/tree/master/eslint/babel-eslint-parser)。ESLint默认的分析器[Espree](https://github.com/eslint/espree)仅支持最新的ECMAScript标准（以及JSX），但是不支持Babel提供的实验性和非标语法（例如Flow或TypeScript类型）。使用[babel-eslint](https://github.com/babel/babel/tree/master/eslint/babel-eslint-parser)分析器后，这些抽象语法树结果将被转换成可被ESLint理解的ESTree兼容结构；
* extends指定的是eslint:recommended。extends可以指定配置文件路径，也可以指定可共享的配置名（例如eslint:recommended或eslint:all）。[ESLint rules](https://eslint.org/docs/rules/)里面列举了ESLint所有核心规则，其中推荐的标对号；  
* ecmaFeatures使能JSX，通过experimentalObjectRestSpread支持[rest/spread操作符](https://v8.dev/features/object-rest-spread)。（注：experimentalObjectRestSpread已废除，ESLint第五版将ecmaFeatures: { experimentalObjectRestSpread: true }视作ecmaVersion: 2018别名，ESLint第六版将取消）；  
* env指定的是es6和browser，即该项目被设计成运行在es6和browser环境，这两个环境都包含一套预定义全局变量。[ESLint的environments.js](https://github.com/eslint/eslint/blob/master/conf/environments.js)里除了有一些ESLint特有环境定义，其他都是来自[globals包的globals.json](https://github.com/sindresorhus/globals/blob/master/globals.json)。

本配置中规则项分析：  
* [comma-dangle](https://eslint.org/docs/rules/comma-dangle)： 为0的话，关闭结尾逗号的规则；  
* [indent](https://eslint.org/docs/rules/indent)：为[2,2,{"SwitchCase": 1}]的话，缩进级别为2空格，Switch语句的Case子句的缩进级别为1，违反则报错；  
* [jsx-quotes](https://eslint.org/docs/rules/jsx-quotes)：为1的话，JSX属性混使单引号和双引号则告警；    
* [linebreak-style](https://eslint.org/docs/rules/linebreak-style)： 为[2,"unix"]的话，换行使用Unix风格（换行），违反则报错；   
* [quotes](https://eslint.org/docs/rules/quotes)：为[2,"single"]的话，对字符串的定义统一使用单引号，违反则报错；  
* [react/display-name](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/display-name.md)：为1的话，React组件定义中缺少displayName的话告警；   
* [react/forbid-prop-types](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/forbid-prop-types)：为0的话，关闭对propTypes使用PropTypes的any、array、object检查的规则；   
* [react/sort-prop-types](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/sort-prop-types)：为1的话，对propTypes中使用不符合排序的告警；   
* [react/jsx-boolean-value](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/jsx-boolean-value)：为1的话，JSX属性赋值为{true}则告警；   
* [react/jsx-first-prop-new-line](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/jsx-first-prop-new-line)：为[1,"multiline"]的话，当JSX标记为当行时第一个prop不在新行则告警；   
* [react/jsx-closing-bracket-location](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/jsx-closing-bracket-location)：为1的话，对JSX标记的`>`没有和`<`对其的告警；   
* [react/jsx-curly-spacing](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/jsx-curly-spacing)：为1的话，对JSX属性和表达式中大括号没有空格的告警；   
* [react/jsx-indent-props](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/jsx-indent-props)：为[2,2]的话，对JSX的props没有采用2空格缩进的报错；   
* [react/jsx-max-props-per-line](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/jsx-max-props-per-line)：为1的话，对每行包含多余一个JSXprops的告警；   
* [react/jsx-no-duplicate-props](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/jsx-no-duplicate-props)：为1的话，对JSX的props有重复的告警；   
* [react/jsx-no-literals](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/jsx-no-literals)：为0的话，关闭字面量必须在JSX容器内的规则（`var Hello = <div>test</div>;var Hello = <div>{'test'}</div>;`该规则打开的话，第一个语句会告警，第二个语句不报警）；   
* [react/jsx-no-undef](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/jsx-no-undef)：为1的话，对没宣称的变量告警；   
* [react/jsx-sort-props](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/jsx-sort-props)：为1的话，对组件实例的props未排序告警；   
* [react/jsx-uses-react](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/jsx-uses-react)：阻止React被错误标记为未使用；   
* [react/jsx-uses-vars](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/jsx-uses-vars)：阻止JSX中使用的变量被错误标记为未使用；   
* [react/no-danger](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/no-danger)：阻止使用危险JSX属性（dangerouslySetInnerHTML）；   
* [react/no-did-mount-set-state](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/no-did-mount-set-state)：为0的话，关闭在componentDidMount不可以设状态state的规则；   
* [react/no-did-update-set-state](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/no-did-update-set-state)：为1的话，在componentDidUpdate设状态state则告警；   
* [react/no-direct-mutation-state](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/no-direct-mutation-state)：为1的话，对直接修改state而不使用setState的告警；   
* [react/no-multi-comp](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/no-multi-comp)：为1的话，对一个文件有多个组件定义的告警；   
* [react/no-set-state](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/no-set-state)：为1的话，对使用setState进行告警（使用Flux、React Redux架构时能分离组件和应用状态）；   
* [react/no-unknown-property](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/no-unknown-property)：为1的话，在JSX中使用未知DOM属性则告警；   
* [react/prefer-es6-class](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/prefer-es6-class)：为1的话，对ES5的create-react-class使用进行告警；   
* [react/prop-types](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/prop-types)：为1的话，对没有propTypes进行告警；   
* [react/react-in-jsx-scope](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/react-in-jsx-scope)：为1的话，对React不是全局变量，且在JSX范围内没有React变量的告警；   
* [react/self-closing-comp](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/self-closing-comp)：为1的话，对没有子孙的且使用额外结束标签的组件进行告警；   
* [react/sort-comp](https://github.com/yannickcr/eslint-plugin-react/blob/HEAD/docs/rules/sort-comp)：为0的话，关闭组件方法次序一致性的规则；   
* [semi](https://eslint.org/docs/rules/semi)：为0的话，关闭分号的规则，修复的话也不会进行分号自动插入；   


### 其他配置

#### .editorconfig  

.editorconfig存储的是编码风格，被各种IDE和编辑器支持：  
```
root = true

[*.js]
end_of_line = lf
insert_final_newline = true
charset = utf-8

[*.js]
indent_style = space
indent_size = 2

[Makefile]
indent_style = tab
```

这里指定的换行也是unix风格，与.eslintrc一只，这样ESLint才不会报错或告警。  

#### jsconfig.json  

jsconfig.json是Visual Studio Code的配置，跟ESLint和Prettier无关。具体见[Visual Studio Code文档](https://code.visualstudio.com/docs/languages/jsconfig)。  

### 题外话  

[devias-io/react-material-dashboard](https://github.com/devias-io/react-material-dashboard)里面缺少git提交的钩子设置，因此代码格式化和监测只能手动进行。

### 参考

* [Prettier配置项](https://prettier.io/docs/en/options.html)  
* [Configuring ESLint](https://eslint.org/docs/user-guide/configuring)  
* [让你的代码更Prettier！代码风格统一终极方案！](https://juejin.im/entry/5b2b4e4451882574bc55bb60)  
* [使用ESLint+Prettier来统一前端代码风格](https://segmentfault.com/a/1190000015315545)  

