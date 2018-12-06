---
title: '粗览Activiti Explorer源代码'
date: 2015-03-12 08:52:17
categories: 
- workflow
tags: 
- activiti
- explorer
- 代码
- 分析
---
ActivitiExplorer的应用程序为org.activiti.explorer.ExplorerApp，其界面配置文件为Activiti\modules\activiti-webapp-explorer2\src\main\resources\activiti-ui-context.xml。通过该配置文件创建主窗口org.activiti.explorer.ui.MainWindow类实例，并通过org.activiti.explorer.ViewManagerFactoryBean创建实现org.activiti.explorer.ViewManager接口的org.activiti.explorer.DefaultViewManager或org.activiti.explorer.ui.alfresco.AlfrescoViewManager类实例。
在Activiti演示中采用的是org.activiti.explorer.DefaultViewManager类实例，它对主窗口进行视图管理，完成视图切换、对应导航栏和功能菜单的设置。
主窗口org.activiti.explorer.ui.MainWindow类实例通过org.activiti.explorer.ui.mainlayout.MainLayout类进行界面布局。

下面列举了Activiti Explorer两级导航栏所对应的页面实现类。
- Tasks
  - Inboxorg.activiti.explorer.ui.task.InboxPage
  - My Tasksorg.activiti.explorer.ui.task.TasksPage
  - Queuedorg.activiti.explorer.ui.task.QueuedPage
  - Involvedorg.activiti.explorer.ui.task.InvolvedPage
  - Archivedorg.activiti.explorer.ui.task.ArchivedPage
- Processes
  - My Instancesorg.activiti.explorer.ui.process.MyProcessInstancesPage
  - Deployed process definitionsorg.activiti.explorer.ui.process.ProcessDefinitionPage
  - Model workspaceorg.activiti.editor.ui.EditorProcessDefinitionPage
- Reports
  - Generate reportsorg.activiti.explorer.ui.reports.RunReportsPage
  - Saved reportsorg.activiti.explorer.ui.reports.SavedReportsPage
- Manage
  - Databaseorg.activiti.explorer.ui.management.db.DatabasePage
  - Deploymentsorg.activiti.explorer.ui.management.deployment.DeploymentPage
  - Active Processesorg.activiti.explorer.ui.management.processdefinition.ActiveProcessDefinitionPage
  - Suspend Processesorg.activiti.explorer.ui.management.processdefinition.SuspendedProcessDefinitionPage
  - Jobsorg.activiti.explorer.ui.management.job.JobPage
  - Usersorg.activiti.explorer.ui.management.identity.UserPage
  - Groupsorg.activiti.explorer.ui.management.identity.GroupPage
  - Administrationorg.activiti.explorer.ui.management.admin.AdministrationPage
  - Crystalballorg.activiti.explorer.ui.management.crystalball.CrystalBallPage