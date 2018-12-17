---
title: 'SSH keys for Git System'
date: 2013-09-18 22:58:33
categories: 
- Tool
- Git
tags: 
- ssh
- key
- git
- github
- gitlab
---
## SSH keys[](http://gitlab.sas.com/help/ssh/README#ssh-keys)

An SSH key allows you to establish a secure connection betweenyour computer and Git system such as GitHub, GitLab.
Before generating an SSH key, check if your system already hasone by running `cat ~/.ssh/id_rsa.pub` . If you see a long string startingwith `ssh-rsa` or `ssh-dsa` ,you can skip the ssh-keygen step.
To generate a new SSH key, just open your terminal and use codebelow. The ssh-keygen command prompts you for a location andfilename to store the key pair and for a password. When promptedfor the location and filename, you can press enter to use thedefault.
It is a best practice to use a password for an SSH key, but itis not required and you can skip creating a password by pressingenter. Note that the password you choose here can't be altered orretrieved.
```
ssh-keygen -t rsa -C "quyandong@yahoo.com"
```
Use the code below to show your public key.
```
cat ~/.ssh/id_rsa.pub
```

Copy-paste the key to the 'My SSH Keys' section under the 'SSH'tab in your user profile. Please copy the complete key startingwith `ssh-` andending with your username and host.

Use code below to copy your public key to the clipboard.Depending on your OS you'll need to use a different command:

**Windows:**
```
clip < ~/.ssh/id_rsa.pub
```

**Mac:**
```
pbcopy < ~/.ssh/id_rsa.pub
```

**Linux (requires xclip):**
```
xclip -sel clip < ~/.ssh/id_rsa.pub
```

## Deploy keys[](http://gitlab.sas.com/help/ssh/README#deploy-keys)

Deploy keys allow read-only access to multiple projects with asingle SSH key.
This is really useful for cloning repositories to yourContinuous Integration (CI) server. By using deploy keys, you don'thave to setup a dummy user account.
If you are a project master or owner, you can add a deploy keyin the project settings under the section 'Deploy Keys'. Press the'New Deploy Key' button and upload a public SSH key. After this,the machine that uses the corresponding private key has read-onlyaccess to the project.
You can't add the same deploy key twice with the 'New DeployKey' option. If you want to add the same key to another project,please enable it in the list that says 'Deploy keys from projectsavailable to you'. All the deploy keys of all the projects you haveaccess to are available. This project access can happen throughbeing a direct member of the projecti, or through a group. See `def accessible_deploy_keys` in `app/models/user.rb` for more information.
