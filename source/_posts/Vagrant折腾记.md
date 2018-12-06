---
title: 'Vagrant折腾记'
date: 2018-06-19 05:59:52
categories:
- Tool 
- Vagrant
tags: 
- vagrant
- virtualbox
- win10
- private_key
- vagrant-vbguest
---

自从用了OpenStack，真是很久没玩Vagrant。偶尔想用用，问题不断，废了一点功夫才解决。

### 遭遇VBoxManage.exe: error

```
$ vagrant up
Bringing machine 'xdevimg' up with 'virtualbox' provider...
==> xdevimg: Checking if box 'devimage-ubuntu' is up to date...
==> xdevimg: A newer version of the box 'devimage-ubuntu' is available! You currently
==> xdevimg: have version '0.13.0'. The latest is version '0.13.2'. Run
==> xdevimg: `vagrant box update` to update.
==> xdevimg: Clearing any previously set forwarded ports...
==> xdevimg: Clearing any previously set network interfaces...
==> xdevimg: Preparing network interfaces based on configuration...
    xdevimg: Adapter 1: nat
==> xdevimg: You are trying to forward to privileged ports (ports <= 1024). Most
==> xdevimg: operating systems restrict this to only privileged process (typically
==> xdevimg: processes running as an administrative user). This is a warning in case
==> xdevimg: the port forwarding doesn't work. If any problems occur, please try a
==> xdevimg: port higher than 1024.
==> xdevimg: Forwarding ports...
    xdevimg: 7980 => 80 (adapter 1)
    xdevimg: 7981 => 7981 (adapter 1)
    xdevimg: 7982 => 7982 (adapter 1)
    xdevimg: 8500 => 8500 (adapter 1)
    xdevimg: 5672 => 5672 (adapter 1)
    xdevimg: 15672 => 15672 (adapter 1)
    xdevimg: 5577 => 5577 (adapter 1)
    xdevimg: 5432 => 5432 (adapter 1)
    xdevimg: 8787 => 8787 (adapter 1)
    xdevimg: 22 => 2222 (adapter 1)
==> xdevimg: Running 'pre-boot' VM customizations...

==> xdevimg: Booting VM...
There was an error while executing `VBoxManage`, a CLI used by Vagrant
for controlling VirtualBox. The command and stderr is shown below.

Command: ["startvm", "3e7f8816-e32b-4bce-943b-a7cefc5ec43e", "--type", "headless"]

Stderr: VBoxManage.exe: error: The virtual machine 'dev-image_xdevimg_1529568385166_16024' has terminated unexpectedly during startup with exit code 1 (0x1).  More details may be available in 'C:\Users\mryqu\VirtualBox VMs\dev-image_xdevimg_1529568385166_16024\Logs\VBoxHardening.log'
VBoxManage.exe: error: Details: code E_FAIL (0x80004005), component MachineWrap, interface IMachine
```
想一想我的操作系统都从Win7升成Win10，网上说跟Win10有关，需要升级VirtualBox。结果将VirtualBox从5.0.32升到5.2.12，结果Vagrant 1.7.4又不认新的VirtualBox，索性将Vagrant也升级到2.1.1。过关！

### 遭遇Warning: Remote connection disconnect. Retrying...

```
$ vagrant up
Bringing machine 'xdevimg' up with 'virtualbox' provider...
==> xdevimg: Importing base box 'devimage-ubuntu'...
==> xdevimg: Matching MAC address for NAT networking...
==> xdevimg: Checking if box 'devimage-ubuntu' is up to date...
==> xdevimg: Setting the name of the VM: dev-image_xdevimg_1529637278638_25909
==> xdevimg: Clearing any previously set network interfaces...
==> xdevimg: Preparing network interfaces based on configuration...
    xdevimg: Adapter 1: nat
==> xdevimg: You are trying to forward to privileged ports (ports <= 1024). Most
==> xdevimg: operating systems restrict this to only privileged process (typically
==> xdevimg: processes running as an administrative user). This is a warning in case
==> xdevimg: the port forwarding doesn't work. If any problems occur, please try a
==> xdevimg: port higher than 1024.
==> xdevimg: Forwarding ports...
    xdevimg: 7980 (guest) => 80 (host) (adapter 1)
    xdevimg: 7981 (guest) => 7981 (host) (adapter 1)
    xdevimg: 7982 (guest) => 7982 (host) (adapter 1)
    xdevimg: 8500 (guest) => 8500 (host) (adapter 1)
    xdevimg: 5672 (guest) => 5672 (host) (adapter 1)
    xdevimg: 15672 (guest) => 15672 (host) (adapter 1)
    xdevimg: 5577 (guest) => 5577 (host) (adapter 1)
    xdevimg: 5432 (guest) => 5432 (host) (adapter 1)
    xdevimg: 8787 (guest) => 8787 (host) (adapter 1)
    xdevimg: 22 (guest) => 2222 (host) (adapter 1)
==> xdevimg: Running 'pre-boot' VM customizations...
==> xdevimg: Booting VM...
==> xdevimg: Waiting for machine to boot. This may take a few minutes...
    xdevimg: SSH address: 127.0.0.1:2222
    xdevimg: SSH username: vagrant
    xdevimg: SSH auth method: private key
    xdevimg: Warning: Remote connection disconnect. Retrying...
    xdevimg: Warning: Remote connection disconnect. Retrying...
    xdevimg: Warning: Remote connection disconnect. Retrying...
    xdevimg: Warning: Remote connection disconnect. Retrying...
    xdevimg: Warning: Remote connection disconnect. Retrying...
    xdevimg: Warning: Remote connection disconnect. Retrying...
Timed out while waiting for the machine to boot. This means that
Vagrant was unable to communicate with the guest machine within
the configured ("config.vm.boot_timeout" value) time period.

If you look above, you should be able to see the error(s) that
Vagrant had when attempting to connect to the machine. These errors
are usually good hints as to what may be wrong.

If you're using a custom box, make sure that networking is properly
working and you're able to connect to the machine. It is a common
problem that networking isn't setup properly in these boxes.
Verify that authentication configurations are also setup properly,
as well.

If the box appears to be booting properly, you may want to increase
the timeout ("config.vm.boot_timeout") value.
```
Workround：
1.  执行vagrant destroy并强制删除.vagrant\machines\xdevimg\virtualbox\private_key
2.  在Vagrantfile中添加config.ssh.insert_key = false
3.  执行vagrant up
该问题将在Vagrant 2.1.2解决，细节见[issue 9900](https://github.com/hashicorp/vagrant/issues/9900)。

### 遭遇VirtualBox Guest Addition版本与VM不一致

```
$ vagrant up
Bringing machine 'xdevimg' up with 'virtualbox' provider...
==> xdevimg: Importing base box 'devimage-ubuntu'...
==> xdevimg: Matching MAC address for NAT networking...
==> xdevimg: Checking if box 'devimage-ubuntu' is up to date...
==> xdevimg: Setting the name of the VM: dev-image_xdevimg_1529639647353_4390
==> xdevimg: Clearing any previously set network interfaces...
==> xdevimg: Preparing network interfaces based on configuration...
    xdevimg: Adapter 1: nat
==> xdevimg: You are trying to forward to privileged ports (ports <= 1024). Most
==> xdevimg: operating systems restrict this to only privileged process (typically
==> xdevimg: processes running as an administrative user). This is a warning in case
==> xdevimg: the port forwarding doesn't work. If any problems occur, please try a
==> xdevimg: port higher than 1024.
==> xdevimg: Forwarding ports...
    xdevimg: 7980 (guest) => 80 (host) (adapter 1)
    xdevimg: 7981 (guest) => 7981 (host) (adapter 1)
    xdevimg: 7982 (guest) => 7982 (host) (adapter 1)
    xdevimg: 8500 (guest) => 8500 (host) (adapter 1)
    xdevimg: 5672 (guest) => 5672 (host) (adapter 1)
    xdevimg: 15672 (guest) => 15672 (host) (adapter 1)
    xdevimg: 5577 (guest) => 5577 (host) (adapter 1)
    xdevimg: 5432 (guest) => 5432 (host) (adapter 1)
    xdevimg: 8787 (guest) => 8787 (host) (adapter 1)
    xdevimg: 22 (guest) => 2222 (host) (adapter 1)
==> xdevimg: Running 'pre-boot' VM customizations...
==> xdevimg: Booting VM...
==> xdevimg: Waiting for machine to boot. This may take a few minutes...
    xdevimg: SSH address: 127.0.0.1:2222
    xdevimg: SSH username: vagrant
    xdevimg: SSH auth method: private key
    xdevimg:
    xdevimg: Vagrant insecure key detected. Vagrant will automatically replace
    xdevimg: this with a newly generated keypair for better security.
    xdevimg:
    xdevimg: Inserting generated public key within guest...
    xdevimg: Removing insecure key from the guest if it's present...
    xdevimg: Key inserted! Disconnecting and reconnecting using new SSH key...
==> xdevimg: Machine booted and ready!
==> xdevimg: Checking for guest additions in VM...
    xdevimg: The guest additions on this VM do not match the installed version of
    xdevimg: VirtualBox! In most cases this is fine, but in rare cases it can
    xdevimg: prevent things such as shared folders from working properly. If you see
    xdevimg: shared folder errors, please make sure the guest additions within the
    xdevimg: virtual machine match the version of VirtualBox you have installed on
    xdevimg: your host and reload your VM.
    xdevimg:
    xdevimg: Guest Additions Version: 4.3.40
    xdevimg: VirtualBox Version: 5.2
==> xdevimg: Mounting shared folders...
    xdevimg: /vagrant => C:/dev-image
Vagrant was unable to mount VirtualBox shared folders. This is usually
because the filesystem "vboxsf" is not available. This filesystem is
made available via the VirtualBox Guest Additions and kernel module.
Please verify that these guest additions are properly installed in the
guest. This is not a bug in Vagrant and is usually caused by a faulty
Vagrant box. For context, the command attempted was:

mount -t vboxsf -o uid=1000,gid=1000 vagrant /vagrant

The error output from the command was:

/sbin/mount.vboxsf: mounting failed with the error: No such device
```
解决办法：
```
$ vagrant plugin install vagrant-vbguest
Installing the 'vagrant-vbguest' plugin. This can take a few minutes...
Installed the plugin 'vagrant-vbguest (0.15.2)'!
```
终于，又看到Vagrang起来了！

