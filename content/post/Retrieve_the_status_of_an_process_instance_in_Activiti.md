---
title: 'Retrieve the status of an process instance in Activiti'
date: 2015-03-13 19:42:33
categories: 
- workflow
tags: 
- activiti
- process_instance
- status
- retrieve
---
### Retrieve the status of an running process instance

Use the executionQuery() or processInstanceQuery() to find out ifany result is returned or not when querying execution/process byId.
```
runtimeService.createProcessInstanceQuery().processInstanceId(specifiedProcessInstanceId).singleResult()
runtimeService.createExecutionQuery().executionId(specifiedExecutionId).singleResult()
```

Specially when the history capabilities of Activiti engine isenabled:
- Specified process/execution instance id:
   ```
   ProcessInstance inst = historyService.createHistoricProcessInstanceQuery().processInstanceId(specifiedProcessInstanceId).singleResult();
   inst.isEnd()
   ```
- Unspecified process/execution instance id:
   ```
   historyService.createHistoricProcessInstanceQuery().finished().list()
   historyService.createHistoricProcessInstanceQuery().unfinished().list()
   ```

### Retrieve the active node of an running process instance

RuntimeService provide the API to retrieve the active node of anrunning process instance:
```
 // Finds the activity ids for all executions that are waiting in activities.
 // This is a list because a single activity can be active multiple times.
 // 
 // @param executionId
 //          id of the execution, cannot be null.
 // @throws ActivitiObjectNotFoundException
 //           when no execution exists with the given executionId.
 List getActiveActivityIds(String executionId);
```

Its implementation work as below:
![Retrieve the status of an process instance in Activiti](/images/2015/3/0026uWfMgy6QV6UDylXa1.jpg)
The API usage in Activiti demo:
- org.activiti.rest.diagram.services.BaseProcessDefinitionDiagramLayoutResource: dead code
  org.activiti.rest.diagram.services.ProcessDefinitionDiagramLayoutResource doesn't satisfy the condition to run getActiveActivityIds method.
  org.activiti.rest.diagram.services.ProcessInstanceDiagramLayoutResourceis not used in Activiti demo.
- org.activiti.rest.diagram.services.ProcessInstanceHighlightsResource: used to high light current active node and sequence flow
   ![Retrieve the status of an process instance in Activiti](/images/2015/3/0026uWfMgy6QV7Qch7Z73.jpg)
- org.activiti.explorer.ui.process.ProcessDefinitionImageStreamResourceBuilder: used to high light current active node
   ![Retrieve the status of an process instance in Activiti](/images/2015/3/0026uWfMgy6QV82pI20c4.jpg)
- org.activiti.rest.service.api.runtime.process.ExecutionActiveActivitiesCollectionResource: no usage in Activiti demo
- org.activiti.rest.service.api.runtime.process.ProcessInstanceDiagramResource: no usage in Activiti demo

### Reference

[Activiti user guide: history confiugration](http://www.activiti.org/userguide/#historyConfiguration)  
[Activiti Forums: ProcessInstance.isEnded() returns false](http://forums.activiti.org/content/processinstanceisended-returns-false)  
[Activiti Forums: How to determine when process is complete after signal()?](http://forums.activiti.org/content/how-determine-when-process-complete-after-signal)  
[Activiti Forums: any api to get the current node?](http://forums.activiti.org/content/any-api-get-current-node)  