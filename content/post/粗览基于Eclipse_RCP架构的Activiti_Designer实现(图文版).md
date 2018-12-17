---
title: '粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)'
date: 2015-03-31 06:08:51
categories: 
- workflow
tags: 
- activiti
- designer
- bpmn
- eclipse
- rcp
---
# org.activiti.designer.feature

contains an Eclipse feature definition, which groups the variousprojects into the installable Activiti Designer feature.

## org.activiti.designer.eclipse plug-in

contains the main extensions of Eclipse extension points and a lotof shared code for working with the model, saving resources andutilities.

### org.activiti.designer.eclipse.extension.ExportMarshallerextension-point

Activiti Designer Export Marshaller: Use this extension point toprovide custom output marshallers when Activiti diagrams areexported.

### org.activiti.designer.eclipse.extension.ProcessValidatorextension-point

Activiti Designer Process Validator: Use this extension point toprovide validation when Activiti diagrams are validated.

### org.activiti.designer.eclipse.extension.IconProviderextension-point

Icon Provider: Use this extension point to provide custom iconproviders to be used for displaying icons at certain places inActiviti Designer.

### org.activiti.designer.eclipse.extension.PaletteExtensionProviderextension-point

Palette extension Provider: Use this extension point to providecustom palette in diagram editor of Activiti Designer.

### org.eclipse.ui.perspectives extension

To add Activiti perspective factory to the workbench.
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReQgepUU3c.jpg)

### org.eclipse.ui.newWizards extension

To register Activiti project/diagram creation wizardextensions.
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReQuTq3If6.jpg)

### org.eclipse.ui.editors extension

To add "Activiti Diagram Editor" to the workbench.
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReQAPX8x25.jpg)

### org.eclipse.ui.views extension

To define "Activiti Explorer" and "Activiti Cloud Editor" view forthe workbench.

### org.eclipse.ui.navigator.viewer extension

To define the viewer within the "Activiti Explorer" and "ActivitiCloud Editor" view
- Defines popup menu for the viewer
- Binds content and actions to the viewer
- Additionally defines filter extensions for the Designer filtersto the default Project Explorer

![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6RiWiJMtd4b.jpg)
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReQYFmpq78.jpg)

### org.eclipse.ui.navigator.navigatorContent extension

To add "Activiti Diagram Contents", "Activiti Project Contents" and"Activiti Cloud Editor content" to the navigator.

### org.eclipse.ui.preferencePages extension

To declare Activiti cloud editor page to the preference dialogbox.
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReRhKN9afc.jpg)

### org.eclipse.ui.commands extension

To declare refreh command to Activiti Cloud Editor Navigator.

### org.eclipse.ui.handlers extension

a To declare download handler to Activiti Cloud Editor Navigatorwhich will trigger a download dialog.

### org.eclipse.ui.menus extension

To declare "Download" menu to Activiti Cloud EditorNavigator.
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReRQ7JmK9e.jpg)

### org.eclipse.ui.popupMenus extension

To declare "Activiti Editor" popup menu with two actions:
- Upload new version
- Download latest version

![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReS1nIAN31.jpg)

### org.eclipse.graphiti.ui.imageProviders extension

To register Activiti's image provider for Activiti Designer? The source location of these icons are Activiti-Designer\org.activiti.designer.eclipse\icons.

### org.eclipse.wst.xml.core.catalogContributions extension

To register XML schemas in the catalog from a codecontribution
- BPMN20.xsd
- activiti-bpmn-extensions-5.4.xsd

### org.eclipse.core.resources.natures extension

To register Activiti project nature
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReRLzGEd9d.png)

### org.eclipse.core.resources.markers extension

Activiti Marker?

### org.eclipse.core.resources.markers extension

Activiti General Marker?

### org.eclipse.core.resources.markers extension

Activiti Marshaller Marker?

### org.eclipse.core.resources.markers extension

Activiti Validator Marker?

### org.eclipse.core.contenttype.contentTypes extension

To declare "Activiti Diagram Editor File" content type which havefile extension ".bpmn".

### org.eclipse.core.runtime.preferences extension

To set the default values of "Activiti" and "Activiti cloud editor"preferences

### org.eclipse.core.exp_ressions.definitions extension

To check if the selected node is mode node in Activiti Cloud EditorNavigator.

## org.activiti.designer.libs plug-in

Provide APIs in the below libraries/projects to other plug-ins:
- activiti-bpmn-converter
- activiti-image-generator
- activiti-simple-workflow
- activiti-simple-workflow-alfresco
- Apache Chemistry: Content Management InteroperabilityServices
- Apache Commons Logging
- Apache HttpComponents
- Joda-Time: provides a quality replacement for the Java date andtime classes

## org.activiti.designer.gui plug-in

contains most of the UI code, mainly functionality that utilizesGraphiti for drawing diagrams.

### org.eclipse.graphiti.ui.diagramTypes extension

Activiti BPMN diagram type: as Activiti create a diagram typeprovider for a diagram type which does not exist in the repository,it is necessary to provide the information about the new diagramtype.

### org.eclipse.graphiti.ui.diagramTypeProviders extension

To register Activiti's diagram type provider for Activiti BPMNeditor.

### org.eclipse.graphiti.ui.imageProviders extension

To register Activiti's image provider for Activiti BPMNeditor.For each diagram at org.activiti.designer.PluginImage, it has aicon at palette.These keys and paths of icons are defined at classorg.activiti.designer.PluginImage, and source location of theseicons are Activiti-Designer\org.activiti.designer.gui\icons.

### org.eclipse.ui.views.properties.tabbed.propertyContributorextension

Property Contributor for Activiti tabbed properties view. It mostimportantly identifies the unique contributor identifier forActiviti tabs and sections.Activiti tabbed properties view apply to whole process or aspecified BPMN element such as StartEvent, UserTask.
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReSdx5sif6.jpg)
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReSdJULC10.jpg)

### org.eclipse.ui.views.properties.tabbed.propertyTabsextension

To describes the tabs for Activiti contributor. For example,Process, Data Object and Listener tabs in tabbed properties viewfor Activiti process.

### org.eclipse.ui.views.properties.tabbed.propertySectionsextension

To describes the sections for Activiti contributor. OnepropertySection will create a property sheet page (form) on aspecified tab for a process or a BPMN element.

### org.eclipse.ui.preferencePages extension

To describes Activiti pages to the preference dialog box such as"Activiti", "Activiti languages", "Alfresco settings", "Editor" and"Save Actions" page.
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReRpLumE6c.jpg)

### org.eclipse.ui.popupMenus extension

To add add new actions to context menus:
- "Create deployment artifacts" action at popup menu for aActiviti project
- "Generate unit test" action at popup menu for a bpmn a Activitidiagram editor file

![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReShexqhc1.jpg)
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReShsbF993.jpg)

### org.activiti.designer.eclipse.extension.IconProviderextension

Activiti Designer GUI Icon Provider: provide icon providers to beused for displaying icons at certain places in the Designer.The source location of these icons are Activiti-Designer\org.activiti.designer.gui\icons.

## org.activiti.designer.integration plug-in

provides APIs to developers creating CustomServiceTaskextensions.

## org.activiti.designer.help plug-in

### org.eclipse.help.toc extension

help files about usage and preferences for end users

## org.activiti.designer.validation.bpmn20 plug-in

### org.activiti.designer.eclipse.extension.ProcessValidatorextension

Validate diagrams such as ScriptTask, ServiceTask, UserTask,SequenceFlow and SubProcess according to BPMN 2.0 rules.

## org.activiti.designer.util plug-in

Provoide utility APIs under org.activiti.designer.util to otherplug-ins

## org.activiti.designer.kickstart.eclipse plug-in

### org.eclipse.ui.newWizards extension

To register Activiti kickstart project/process diagram/formcreation wizard extensions.
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReSyfOdyf8.jpg)

### org.eclipse.ui.editors extension

To add "Kickstart Process Editor" and "Kickstart Form Editor" tothe workbench.
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReSSAyBV37.jpg)
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReSSMuMV71.jpg)

### org.eclipse.ui.views extension

To define "CMIS Navigator" view for the workbench.

### org.eclipse.ui.navigator.viewer extension

To define the viewer within the "CMIS Navigator" view
- Defines popup menu for the viewer
- Binds content to the viewer

![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReTk0Ndv69.jpg)

### org.eclipse.ui.navigator.navigatorContent extension

To add "CMIS Navigator Content" to the navigator.

### org.eclipse.ui.preferencePages extension

To declare "Kickstart settings" page to the preference dialogbox.
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReTmzDM1a5.jpg)

### org.eclipse.ui.popupMenus extension

To declare "kickstart" popup menu with "Synchronize withrepository" action
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReTpjeyUc4.jpg)

### org.eclipse.ui.menus extension

To declare "Download", "Delete" and "Rename" menu to CMISNavigator.
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReTs0aJB13.jpg)

### org.eclipse.ui.commands extension

To declare refreh command to CMIS Navigator.

### org.eclipse.ui.handlers extension

To declare download handler to CMIS Navigator.

### org.eclipse.ui.handlers extension

To declare delete handler to CMIS Navigator.

### org.eclipse.ui.handlers extension

To declare rename handler to CMIS Navigator.

### org.eclipse.ui.exportWizards extension

To register Activiti kickstart process export wizardextension
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReSDyWBYba.jpg)

### org.eclipse.graphiti.ui.imageProviders extension

<font color="#FF0000">**The classorg.activiti.designer.kickstart.eclipse.common.ActivitiEclipseImageProvidernot found!!!**</font>

### org.eclipse.core.contenttype.contentTypes extension

To declare "Kickstart Process Editor File" content type which havefile extension ".kickproc". To declare "Kickstart Form Editor File" content type which havefile extension ".kickform".

### org.eclipse.core.exp_ressions.definitions extension

To check if the selected node is folder or document node in CMISNavigator.

### org.eclipse.core.runtime.preferences extension

To set the default values of "Kickstart settings" preference.

## org.activiti.designer.kickstart.gui.form plug-in

### org.eclipse.graphiti.ui.diagramTypes extension

Kickstart Form diagram type: as Activiti Kickstart Form create adiagram type provider for a diagram type which does not exist inthe repository, it is necessary to provide the information aboutthe new diagram type.

### org.eclipse.graphiti.ui.diagramTypeProviders extension

To register a diagram type provider for Activiti KickstartForm.

### org.eclipse.graphiti.ui.imageProviders extension

To register Activiti's image provider for Activiti KickstartForm.These keys and paths of icons are defined at classorg.activiti.designer.kickstart.form.KickstartFormPluginImage, andsource location of these icons are Activiti-Designer\org.activiti.designer.kickstart.gui.form\icons.

### org.activiti.designer.eclipse.extension.IconProviderextension

**<font color="#FF0000">The method getIcon of classorg.activiti.designer.kickstart.form.diagram.KickstartFormIconProvideralways return null.</font>**

### org.eclipse.ui.views.properties.tabbed.propertyContributorextension

Property Contributor for Activiti Kickstart Form tabbed propertiesview. It most importantly identifies the unique contributoridentifier for Activiti tabs and sections.
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReSKCVwoac.jpg)

### org.eclipse.ui.views.properties.tabbed.propertyTabsextension

To describes the tabs for Activiti Kickstart Formcontributor.

### org.eclipse.ui.views.properties.tabbed.propertySectionsextension

To describes the sections for Activiti contributor. OnepropertySection will create a property sheet page (form) on aspecified tab for a element in Activiti Kickstart Form.

## org.activiti.designer.kickstart.gui.process plug-in

### org.eclipse.graphiti.ui.diagramTypes extension

Kickstart Process diagram type: as Activiti Kickstart Processcreate a diagram type provider for a diagram type which does notexist in the repository, it is necessary to provide the informationabout the new diagram type.

### org.eclipse.graphiti.ui.diagramTypeProviders extension

To register a diagram type provider for Activiti KickstartProcess.

### org.eclipse.graphiti.ui.imageProviders extension

To register Activiti's image provider for Activiti KickstartProcess.These keys and paths of icons are defined at classorg.activiti.designer.kickstart.process.KickstartProcessPluginImage,and source location of these icons are Activiti-Designer\org.activiti.designer.kickstart.gui.process\icons.

### org.eclipse.ui.views.properties.tabbed.propertyContributorextension

Property Contributor for Activiti Kickstart Process tabbedproperties view. It most importantly identifies the uniquecontributor identifier for Activiti tabs and sections.
![粗览基于Eclipse RCP架构的Activiti Designer实现(图文版)](/images/2015/3/0026uWfMgy6ReSILLO060.jpg)

### org.eclipse.ui.views.properties.tabbed.propertyTabsextension

To describes the tabs for Activiti Kickstart Processcontributor.

### org.eclipse.ui.views.properties.tabbed.propertySectionsextension

To describes the sections for Activiti contributor. OnepropertySection will create a property sheet page (form) on aspecified tab for a element in Activiti Kickstart Process.

## org.activiti.designer.kickstart.util plug-in

Provoide utility APIs under org.activiti.designer.kickstart.util toother plug-ins