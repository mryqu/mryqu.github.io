---
title: 'Activiti Designer开发环境配置'
date: 2015-03-27 08:51:10
categories: 
- workflow
tags: 
- activiti
- designer
- bpmn
---
1. Download eclipse-modeling-juno-SR2-win32-x86_64.zip,eclipse-rcp-juno-SR2-win32-x86_64.zip and extract to the sameeclipse folder
   **Use Eclipse juno instead of kepler which can easily consume your day!!!**
2. Add Eclipse Graphiti SDK 0.10.1 from update site http://archive.eclipse.org/graphiti/updates/0.10.1/
3. Add the following location as source code repository: https://github.com/Activiti/Activiti-Designer
  ![Activiti Designer开发环境配置](/images/2015/3/0026uWfMgy6R80WqFUd91.png)
  ![Activiti Designer开发环境配置](/images/2015/3/0026uWfMgy6R813aonY6e.png)
4. Import Maven project - Activiti Designer
   ![Activiti Designer开发环境配置](/images/2015/3/0026uWfMgy6R81hBVmv9f.jpg)
   ![Activiti Designer开发环境配置](/images/2015/3/0026uWfMgy6R81hECzm58.png)
5. Open a console and navigate to the directory of your Eclipseworkspace and then into the org.activiti.designer.parent directory,which is of course the directory of the project with the same name.Now perform the following Maven commands:
   ```
   mvn clean eclipse:clean
   mvn eclipse:eclipse
   ```
6. Go back to Eclipse, select all of the projects, right click andchoose Refresh. The information set by Maven will now be picked upby Eclipse.
7. Solve issue at Activiti-Designer\examples\text-export-marshaller\pom.xml then update Maven projects:change "5.15.0-SNAPSHOT" to"5.16.0-SNAPSHOT"
8. Now you have a environment without compilation errors.
   ![Activiti Designer开发环境配置](/images/2015/3/0026uWfMgy6R81RvS5ze9.jpg)
9. The Activiti Designer still can't run successfully by now. 
   To solve the issue Eclipse plug-in unable to instantiate class "org.activiti.designer.eclipse.editor.ActivitiDiagramEditor",add the missing jars inActiviti-Designer\org.activiti.designer.libs\META-INF\MANIFEST.MF re-written by the mvn eclipse:eclipse process
   ![Activiti Designer开发环境配置](/images/2015/3/0026uWfMgy6R8nNBrTd53.jpg)
10. To run Designer, right click the org.activiti.designer.eclipseproject and choose Run as -> Eclipse application.

### Reference

[Activiti Designer Developer Guide](http://docs.codehaus.org/display/ACT/Activiti+Designer+Developer+Guide)  
[Compiling github activiti-designer project](http://forums.activiti.org/content/compiling-github-activiti-designer-project)  
[Eclipse plug-in unable to instantiate class "org.activiti.designer.eclipse.editor.ActivitiDiagramEditor"](http://forums.activiti.org/content/eclipse-plug-unable-instantiate-class-orgactivitidesignereclipseeditoractivitidiagrameditor)  