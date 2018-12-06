---
title: '试试swagger-codegen的invokerPackage和basePackage'
date: 2017-07-24 05:42:35
categories: 
- Service及JavaEE
- Swagger
tags: 
- swagger
- codegen
- invokerpackage
- basepackage
- packageprefix
---
### 环境

```
mryqu@mryqu MINGW64 /c/playground/helloSwaggerCodegen
$ ls
config.json  swagger.json  swagger.yaml  swagger-codegen-cli-2.2.3.jar

mryqu@mryqu MINGW64 /c/playground/helloSwaggerCodegen
$ cat swagger.yaml
swagger: '2.0'
info:
  description: Just a SpringFox demo
  version: '2.0'
  title: mryqu's REST API Demo
  contact:
    name: mryqu
  license:
    name: Apache License Version 2.0
    url: https://github.com/mryqu/
host: localhost:8080
basePath: "/hellospringfox"
tags:
- name: greeting-controller
  description: Greeting Controller
paths:
  "/greeting{?name}":
    get:
      tags:
      - greeting-controller
      summary: Get greeting information
      operationId: greeting
      consumes:
      - application/json
      produces:
      - application/json
      - "*/*"
      parameters:
      - name: name
        in: query
        description: User Name
        required: true
        type: string
        default: World
      responses:
        '200':
          description: OK
          schema:
            "$ref": "#/definitions/Greeting"
        '204':
          description: No Content
        '401':
          description: Unauthorized
        '403':
          description: Forbidden
definitions:
  Greeting:
    type: object
    properties:
      content:
        type: string
      links:
        type: array
        items:
          "$ref": "#/definitions/Link"
  Link:
    type: object
    properties:
      href:
        type: string
      rel:
        type: string
      templated:
        type: boolean

mryqu@mryqu MINGW64 /c/playground/helloSwaggerCodegen
$ cat config.json
{
  "sourceFolder" : "src/generated/java",
  "apiPackage" : "com.yqu.swagger.api",
  "modelPackage" : "com.yqu.swagger.model",
  "configPackage" : "com.yqu.swagger.conf"
}
```

### basePackage

```
mryqu@mryqu MINGW64 /c/playground/helloSwaggerCodegen
$ java -jar  swagger-codegen-cli-2.2.3.jar generate -i swagger.yaml -l spring -o ./output1 -c config.json
[main] INFO io.swagger.parser.Swagger20Parser - reading from swagger.yaml
[main] WARN io.swagger.codegen.ignore.CodegenIgnoreProcessor - Output directory does not exist, or is inaccessible. No file (.swager-codegen-ignore) will be evaluated.
[main] INFO io.swagger.codegen.DefaultCodegen - Invoker Package Name, originally not set, is now dervied from api package name: com.yqu.swagger
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\src\generated\java\com\yqu\swagger\model\Greeting.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\src\generated\java\com\yqu\swagger\model\Link.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\src\generated\java\com\yqu\swagger\api\GreetingnameApiController.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\src\generated\java\com\yqu\swagger\api\GreetingnameApi.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\pom.xml
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\README.md
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\src/generated/java\com\yqu\swagger\conf\HomeController.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\src/generated/java\io\swagger\Swagger2SpringBoot.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\src/generated/java\io\swagger\RFC3339DateFormat.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\src\main\resources\application.properties
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\src/generated/java\com\yqu\swagger\api\ApiException.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\src/generated/java\com\yqu\swagger\api\ApiResponseMessage.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\src/generated/java\com\yqu\swagger\api\NotFoundException.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\src/generated/java\com\yqu\swagger\api\ApiOriginFilter.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\src/generated/java\com\yqu\swagger\conf\SwaggerDocumentationConfig.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\.swagger-codegen-ignore
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output1\.swagger-codegen\VERSION

mryqu@mryqu MINGW64 /c/playground/helloSwaggerCodegen
$ java -jar  swagger-codegen-cli-2.2.3.jar generate -i swagger.yaml -l spring -o ./output2 -c config.json --additional-properties basePackage=com.yqu.helloswagger
[main] INFO io.swagger.parser.Swagger20Parser - reading from swagger.yaml
[main] WARN io.swagger.codegen.ignore.CodegenIgnoreProcessor - Output directory does not exist, or is inaccessible. No file (.swager-codegen-ignore) will be evaluated.
[main] INFO io.swagger.codegen.DefaultCodegen - Invoker Package Name, originally not set, is now dervied from api package name: com.yqu.swagger
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\src\generated\java\com\yqu\swagger\model\Greeting.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\src\generated\java\com\yqu\swagger\model\Link.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\src\generated\java\com\yqu\swagger\api\GreetingnameApiController.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\src\generated\java\com\yqu\swagger\api\GreetingnameApi.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\pom.xml
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\README.md
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\src/generated/java\com\yqu\swagger\conf\HomeController.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\src/generated/java\com\yqu\helloswagger\Swagger2SpringBoot.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\src/generated/java\com\yqu\helloswagger\RFC3339DateFormat.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\src\main\resources\application.properties
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\src/generated/java\com\yqu\swagger\api\ApiException.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\src/generated/java\com\yqu\swagger\api\ApiResponseMessage.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\src/generated/java\com\yqu\swagger\api\NotFoundException.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\src/generated/java\com\yqu\swagger\api\ApiOriginFilter.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\src/generated/java\com\yqu\swagger\conf\SwaggerDocumentationConfig.java
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\.swagger-codegen-ignore
[main] INFO io.swagger.codegen.AbstractGenerator - writing file C:\playground\helloSwaggerCodegen\.\output2\.swagger-codegen\VERSION
```

在config.json中添加basePackage或者使用--additional-properties选项添加basePackage，仅影响Swagger2SpringBoot和RFC3339DateFormat的包名。

### invokerPackage

invokerPackage对Swagger的客户端语言有意义（例如Java），但对Spring语言没有什么影响。

### packagePrefix

SAS有一个swagger-codegen gradle插件，其中使用了packagePrefix，但是使用对象是gradle任务所对的project。而使用swagger-codegen-cli.jar时这个配置没有什么作用。

### 参考
* * *
[GitHub: swagger-api/swagger-codegen](https://github.com/swagger-api/swagger-codegen)  
[](https://gitlab.sas.com/athens/swagger-codegen-gradle-plugin/)  
