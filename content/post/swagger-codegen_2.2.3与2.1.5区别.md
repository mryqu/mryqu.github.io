---
title: 'swagger-codegen 2.2.3与2.1.5区别'
date: 2017-07-23 06:13:46
categories: 
- Service+JavaEE
- Swagger
tags: 
- swagger
- codegen
- rest
- api
- spring
---

### 支持的语法

```
$ java -jar  swagger-codegen-cli-2.1.6.jar langs
Available languages: [android, aspnet5, async-scala, csharp, dart, flash, python-flask, go, java, jaxrs, jaxrs-cxf, jaxrs-resteasy, inflector, javascript, javascript-closure-angular, jmeter, nodejs-server, objc, perl, php, python, qt5cpp, ruby, scala, scalatra, silex-PHP, sinatra, slim, spring-mvc, dynamic-html, html, swagger, swagger-yaml, swift, tizen, typescript-angular, typescript-node, akka-scala, CsharpDotNet2, clojure, haskell-servant]

$ java -jar  swagger-codegen-cli-2.2.3.jar langs
Available languages: [akka-scala, android, apache2, apex, aspnet5, aspnetcore, async-scala, bash, csharp, clojure, cwiki, cpprest, CsharpDotNet2, dart, elixir, eiffel, erlang-server, finch, flash, python-flask, go, go-server, groovy, haskell, jmeter, jaxrs-cxf-client, jaxrs-cxf, java, inflector, jaxrs-cxf-cdi, jaxrs-spec, jaxrs, msf4j, java-play-framework, jaxrs-resteasy-eap, jaxrs-resteasy, javascript, javascript-closure-angular, java-vertx, kotlin, lumen, nancyfx, nodejs-server, objc, perl, php, php-symfony, powershell, pistache-server, python, qt5cpp, rails5, restbed, ruby, scala, scalatra, silex-PHP, sinatra, slim, spring, dynamic-html, html2, html, swagger, swagger-yaml, swift4, swift3, swift, tizen, typescript-angular2, typescript-angular, typescript-fetch, typescript-jquery, typescript-node, undertow, ze-ph]
```
swagger-codegen 2.2.3相较2.1.5而言，多了35种语言支持。此外我最关心的sping-mvc也换成Spring，增加了对Spring Boot和Spring Cloud的支持。
<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><th>swagger-codegen 2.1.5</th><th>swagger-codegen 2.2.3</th></tr><tr><td>akka-scala</td><td>akka-scala</td></tr><tr><td>android</td><td>android</td></tr><tr><td></td><td><font color="red">apache2</font></td></tr><tr><td></td><td><font color="red">apex</font></td></tr><tr><td>aspnet5</td><td>aspnet5</td></tr><tr><td></td><td><font color="red">aspnetcore</font></td></tr><tr><td>async-scala</td><td>async-scala</td></tr><tr><td>csharp</td><td>bash</td></tr><tr><td></td><td><font color="red">csharp</font></td></tr><tr><td>clojure</td><td>clojure</td></tr><tr><td></td><td><font color="red">cwiki</font></td></tr><tr><td></td><td><font color="red">cpprest</font></td></tr><tr><td>CsharpDotNet2</td><td>CsharpDotNet2</td></tr><tr><td>dart</td><td>dart</td></tr><tr><td></td><td><font color="red">elixir</font></td></tr><tr><td></td><td><font color="red">eiffel</font></td></tr><tr><td></td><td><font color="red">erlang-server</font></td></tr><tr><td></td><td><font color="red">finch</font></td></tr><tr><td>flash</td><td>flash</td></tr><tr><td>python-flask</td><td>python-flask</td></tr><tr><td>go</td><td>go</td></tr><tr><td></td><td><font color="red">go-server</font></td></tr><tr><td></td><td><font color="red">groovy</font></td></tr><tr><td><font color="blue">haskell-servant</font></td><td><font color="blue">haskell</font></td></tr><tr><td>jmeter</td><td>jmeter</td></tr><tr><td></td><td><font color="red">jaxrs-cxf-client</font></td></tr><tr><td>jaxrs-cxf</td><td>jaxrs-cxf</td></tr><tr><td>java</td><td>java</td></tr><tr><td>inflector</td><td>inflector</td></tr><tr><td></td><td><font color="red">jaxrs-cxf-cdi</font></td></tr><tr><td></td><td><font color="red">jaxrs-spec</font></td></tr><tr><td>jaxrs</td><td>jaxrs</td></tr><tr><td></td><td><font color="red">msf4j</font></td></tr><tr><td></td><td><font color="red">java-play-framework</font></td></tr><tr><td></td><td><font color="red">jaxrs-resteasy-eap</font></td></tr><tr><td>jaxrs-resteasy</td><td>jaxrs-resteasy</td></tr><tr><td>javascript</td><td>javascript</td></tr><tr><td>javascript-closure-angular</td><td>javascript-closure-angular</td></tr><tr><td></td><td><font color="red">java-vertx</font></td></tr><tr><td></td><td><font color="red">kotlin</font></td></tr><tr><td></td><td><font color="red">lumen</font></td></tr><tr><td></td><td><font color="red">nancyfx</font></td></tr><tr><td>nodejs-server</td><td>nodejs-server</td></tr><tr><td>objc</td><td>objc</td></tr><tr><td>perl</td><td>perl</td></tr><tr><td>php</td><td>php</td></tr><tr><td></td><td><font color="red">php-symfony</font></td></tr><tr><td></td><td><font color="red">powershell</font></td></tr><tr><td></td><td><font color="red">pistache-server</font></td></tr><tr><td>python</td><td>python</td></tr><tr><td>qt5cpp</td><td>qt5cpp</td></tr><tr><td></td><td><font color="red">rails5</font></td></tr><tr><td></td><td><font color="red">restbed</font></td></tr><tr><td>ruby</td><td>ruby</td></tr><tr><td>scala</td><td>scala</td></tr><tr><td>scalatra</td><td>scalatra</td></tr><tr><td>silex-PHP</td><td>silex-PHP</td></tr><tr><td>sinatra</td><td>sinatra</td></tr><tr><td>slim</td><td>slim</td></tr><tr><td><font color="blue">spring-mvc</font></td><td><font color="blue">spring</font></td></tr><tr><td>dynamic-html</td><td>dynamic-html</td></tr><tr><td></td><td><font color="red">html2</font></td></tr><tr><td>html</td><td>html</td></tr><tr><td>swagger</td><td>swagger</td></tr><tr><td>swagger-yaml</td><td>swagger-yaml</td></tr><tr><td></td><td><font color="red">swift4</font></td></tr><tr><td></td><td><font color="red">swift3</font></td></tr><tr><td>swift</td><td>swift</td></tr><tr><td>tizen</td><td>tizen</td></tr><tr><td></td><td><font color="red">typescript-angular2</font></td></tr><tr><td>typescript-angular</td><td>typescript-angular</td></tr><tr><td></td><td><font color="red">typescript-fetch</font></td></tr><tr><td></td><td><font color="red">typescript-jquery</font></td></tr><tr><td>typescript-node</td><td>typescript-node</td></tr><tr><td></td><td><font color="red">undertow</font></td></tr><tr><td></td><td><font color="red">ze-ph</font></td></tr></tbody></table>

### Spring配置

```
$ java -jar  swagger-codegen-cli-2.1.5.jar config-help -l spring-mvc

CONFIG OPTIONS
    sortParamsByRequiredFlag
      Sort method arguments to place required parameters before optional parameters. (Default: true)

    ensureUniqueParams
      Whether to ensure parameter names are unique in an operation (rename parameters that are not). (Default: true)

    modelPackage
      package for generated models

    apiPackage
      package for generated api classes

    invokerPackage
      root package for generated code

    groupId
      groupId in generated pom.xml

    artifactId
      artifactId in generated pom.xml

    artifactVersion
      artifact version in generated pom.xml

    sourceFolder
      source folder for generated code

    localVariablePrefix
      prefix for generated code members and local variables

    serializableModel
      boolean - toggle "implements Serializable" for generated models (Default: false)

    bigDecimalAsString
      Treat BigDecimal values as Strings to avoid precision loss. (Default: false)

    fullJavaUtil
      whether to use fully qualified name for classes under 

    library
      library template (sub-template) to use (Default: )
         - Default Spring MVC server stub.
        j8-async - Use async servlet feature and Java 8's default interface. Generating interface with service declaration is useful when using Maven plugin. Just provide a implementation with @Controller to instantiate service.

    configPackage
      configuration package for generated code

$ java -jar  swagger-codegen-cli-2.2.3.jar config-help -l spring

CONFIG OPTIONS
    sortParamsByRequiredFlag
      Sort method arguments to place required parameters before optional parameters. (Default: true)

    ensureUniqueParams
      Whether to ensure parameter names are unique in an operation (rename parameters that are not). (Default: true)

    allowUnicodeIdentifiers
      boolean, toggles whether unicode identifiers are allowed in names or not, default is false (Default: false)

    modelPackage
      package for generated models

    apiPackage
      package for generated api classes

    invokerPackage
      root package for generated code

    groupId
      groupId in generated pom.xml

    artifactId
      artifactId in generated pom.xml

    artifactVersion
      artifact version in generated pom.xml

    artifactUrl
      artifact URL in generated pom.xml

    artifactDescription
      artifact description in generated pom.xml

    scmConnection
      SCM connection in generated pom.xml

    scmDeveloperConnection
      SCM developer connection in generated pom.xml

    scmUrl
      SCM URL in generated pom.xml

    developerName
      developer name in generated pom.xml

    developerEmail
      developer email in generated pom.xml

    developerOrganization
      developer organization in generated pom.xml

    developerOrganizationUrl
      developer organization URL in generated pom.xml

    licenseName
      The name of the license

    licenseUrl
      The URL of the license

    sourceFolder
      source folder for generated code

    localVariablePrefix
      prefix for generated code members and local variables

    serializableModel
      boolean - toggle "implements Serializable" for generated models (Default: false)

    bigDecimalAsString
      Treat BigDecimal values as Strings to avoid precision loss. (Default: false)

    fullJavaUtil
      whether to use fully qualified name for classes under 

    hideGenerationTimestamp
      hides the timestamp when files were generated

    withXml
      whether to include support for application/xml content type. This option only works for 

    dateLibrary
      Option. Date library to use
        joda - Joda
        legacy - Legacy java.util.Date

        java8 - Java 8 native - note: this also sets "java8" to true

    java8
      Option. Use Java8 classes instead of third party equivalents
        true - Use Java 8 classes such as Base64
        false - Various third party libraries as needed

    title
      server title name or client service name

    configPackage
      configuration package for generated code

    basePackage
      base package for generated code

    interfaceOnly
      Whether to generate only API interface stubs without the server files. (Default: false)

    delegatePattern
      Whether to generate the server files using the delegate pattern (Default: false)

    singleContentTypes
      Whether to select only one produces/consumes content-type by operation. (Default: false)

    java8
      use 

    async
      use async Callable controllers (Default: false)

    responseWrapper
      wrap the responses in given type (Future,Callable,CompletableFuture,ListenableFuture,DeferredResult,HystrixCommand,RxObservable,RxSingle or fully qualified type)

    useTags
      use tags for creating interface and controller classnames (Default: false)

    useBeanValidation
      Use BeanValidation API annotations (Default: false)

    implicitHeaders
      Use of @ApiImplicitParams for headers. (Default: false)

    useOptional
      Use Optional container for optional parameters (Default: false)

    library
      library template (sub-template) to use (Default: spring-boot)
        spring-boot - Spring-boot Server application using the SpringFox integration.
        spring-mvc - Spring-MVC Server application using the SpringFox integration.
        spring-cloud - Spring-Cloud-Feign client with Spring-Boot auto-configured settings.
```
对于Spring程序，swagger-codegen 2.2.3相较2.1.5而言增加了28项配置。
<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><th>swagger-codegen 2.1.5</th><th>swagger-codegen 2.2.3</th></tr><tr><td>sortParamsByRequiredFlag</td><td>sortParamsByRequiredFlag</td></tr><tr><td>ensureUniqueParams</td><td>ensureUniqueParams</td></tr><tr><td></td><td><font color="red">allowUnicodeIdentifiers</font></td></tr><tr><td>modelPackage</td><td>modelPackage</td></tr><tr><td>apiPackage</td><td>apiPackage</td></tr><tr><td>invokerPackage</td><td>invokerPackage</td></tr><tr><td>groupId</td><td>groupId</td></tr><tr><td>artifactId</td><td>artifactId</td></tr><tr><td>artifactVersion</td><td>artifactVersion</td></tr><tr><td></td><td><font color="red">artifactUrl</font></td></tr><tr><td></td><td><font color="red">artifactDescription</font></td></tr><tr><td></td><td><font color="red">scmConnection</font></td></tr><tr><td></td><td><font color="red">scmDeveloperConnection</font></td></tr><tr><td></td><td><font color="red">scmUrl</font></td></tr><tr><td></td><td><font color="red">developerName</font></td></tr><tr><td></td><td><font color="red">developerEmail</font></td></tr><tr><td></td><td><font color="red">developerOrganization</font></td></tr><tr><td></td><td><font color="red">developerOrganizationUrl</font></td></tr><tr><td></td><td><font color="red">licenseName</font></td></tr><tr><td></td><td><font color="red">licenseUrl</font></td></tr><tr><td>sourceFolder</td><td>sourceFolder</td></tr><tr><td>localVariablePrefix</td><td>localVariablePrefix</td></tr><tr><td>serializableModel</td><td>serializableModel</td></tr><tr><td>bigDecimalAsString</td><td>bigDecimalAsString</td></tr><tr><td>fullJavaUtil</td><td>fullJavaUtil</td></tr><tr><td></td><td><font color="red">hideGenerationTimestamp</font></td></tr><tr><td></td><td><font color="red">withXml</font></td></tr><tr><td></td><td><font color="red">dateLibrary</font></td></tr><tr><td></td><td><font color="red">java8</font></td></tr><tr><td></td><td><font color="red">title</font></td></tr><tr><td>configPackage</td><td>configPackage</td></tr><tr><td></td><td><font color="red">basePackage</font></td></tr><tr><td></td><td><font color="red">interfaceOnly</font></td></tr><tr><td></td><td><font color="red">delegatePattern</font></td></tr><tr><td></td><td><font color="red">singleContentTypes</font></td></tr><tr><td></td><td><font color="red">java8</font></td></tr><tr><td></td><td><font color="red">async</font></td></tr><tr><td></td><td><font color="red">responseWrapper</font></td></tr><tr><td></td><td><font color="red">useTags</font></td></tr><tr><td></td><td><font color="red">useBeanValidation</font></td></tr><tr><td></td><td><font color="red">implicitHeaders</font></td></tr><tr><td></td><td><font color="red">useOptional</font></td></tr><tr><td>library</td><td>library</td></tr></tbody></table>
