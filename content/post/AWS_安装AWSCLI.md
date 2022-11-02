---
title: '[AWS] 安装AWSCLI '
date: 2018-07-02 05:40:10
categories: 
- Cloud
tags: 
- aws
- cli
- python
- pip
- cp65001
---

想玩玩AWS CLI，就从[https://aws.amazon.com/cli/](https://aws.amazon.com/cli/)装了一个，但是一执行就是出LookupError: unknown encoding: cp65001错误，查了一下据说是Python2.7导致的。
首先去[https://www.python.org/](https://www.python.org/)下载了最新的Python3.7.0。然后重新安装AWS CLI，依旧出错，只好卸载。
查看是否安装pip，结果发现没有。根据[https://packaging.python.org/tutorials/installing-packages/](https://packaging.python.org/tutorials/installing-packages/)中的提示下载了[get-pip.py](https://bootstrap.pypa.io/get-pip.py)，执行python get-pip.py，成功安装好pip。
```
C:\>pip --version
pip 10.0.1 from c:\users\mryqu\appdata\local\programs\python\python37-32\lib\site-packages\pip (python 3.7
```
最后使用pip安装AWS CLI:
```
C:\>pip install awscli
Collecting awscli
  Downloading https://files.pythonhosted.org/packages/1b/1b/7446d52820533164965f7e7d08cee70b170c78fbbcbd0c7a11ccb9187be6/awscli-1.15.49-py2.py3-none-any.whl (1.3MB)
    100% |████████████████████████████████| 1.3MB 6.6MB/s
Collecting docutils>=0.10 (from awscli)
  Downloading https://files.pythonhosted.org/packages/36/fa/08e9e6e0e3cbd1d362c3bbee8d01d0aedb2155c4ac112b19ef3cae8eed8d/docutils-0.14-py3-none-any.whl (543kB)
    100% |████████████████████████████████| 552kB 3.3MB/s
Collecting s3transfer<0.2.0,>=0.1.12 (from awscli)
  Downloading https://files.pythonhosted.org/packages/d7/14/2a0004d487464d120c9fb85313a75cd3d71a7506955be458eebfe19a6b1d/s3transfer-0.1.13-py2.py3-none-any.whl (59kB
    100% |████████████████████████████████| 61kB 787kB/s
Collecting botocore==1.10.48 (from awscli)
  Downloading https://files.pythonhosted.org/packages/0b/56/44067a8f0cae5f33007e7cbdbaac67cbd9fa598c733ad25eb8f252288fe9/botocore-1.10.48-py2.py3-none-any.whl (4.4MB
    100% |████████████████████████████████| 4.4MB 6.6MB/s
Collecting PyYAML<=3.12,>=3.10 (from awscli)
  Downloading https://files.pythonhosted.org/packages/4a/85/db5a2df477072b2902b0eb892feb37d88ac635d36245a72a6a69b23b383a/PyYAML-3.12.tar.gz (253kB)
    100% |████████████████████████████████| 256kB 6.6MB/s
Collecting colorama<=0.3.9,>=0.2.5 (from awscli)
  Downloading https://files.pythonhosted.org/packages/db/c8/7dcf9dbcb22429512708fe3a547f8b6101c0d02137acbd892505aee57adf/colorama-0.3.9-py2.py3-none-any.whl
Collecting rsa<=3.5.0,>=3.1.2 (from awscli)
  Downloading https://files.pythonhosted.org/packages/e1/ae/baedc9cb175552e95f3395c43055a6a5e125ae4d48a1d7a924baca83e92e/rsa-3.4.2-py2.py3-none-any.whl (46kB)
    100% |████████████████████████████████| 51kB 7.3MB/s
Collecting jmespath<1.0.0,>=0.7.1 (from botocore==1.10.48->awscli)
  Downloading https://files.pythonhosted.org/packages/b7/31/05c8d001f7f87f0f07289a5fc0fc3832e9a57f2dbd4d3b0fee70e0d51365/jmespath-0.9.3-py2.py3-none-any.whl
Collecting python-dateutil<3.0.0,>=2.1; python_version >= "2.7" (from botocore==1.10.48->awscli)
  Downloading https://files.pythonhosted.org/packages/cf/f5/af2b09c957ace60dcfac112b669c45c8c97e32f94aa8b56da4c6d1682825/python_dateutil-2.7.3-py2.py3-none-any.whl (
    100% |████████████████████████████████| 215kB 3.3MB/s
Collecting pyasn1>=0.1.3 (from rsa<=3.5.0,>=3.1.2->awscli)
  Downloading https://files.pythonhosted.org/packages/a0/70/2c27740f08e477499ce19eefe05dbcae6f19fdc49e9e82ce4768be0643b9/pyasn1-0.4.3-py2.py3-none-any.whl (72kB)
    100% |████████████████████████████████| 81kB ...
Collecting six>=1.5 (from python-dateutil<3.0.0,>=2.1; python_version >= "2.7"->botocore==1.10.48->awscli)
  Downloading https://files.pythonhosted.org/packages/67/4b/141a581104b1f6397bfa78ac9d43d8ad29a7ca43ea90a2d863fe3056e86a/six-1.11.0-py2.py3-none-any.whl
Building wheels for collected packages: PyYAML
  Running setup.py bdist_wheel for PyYAML ... done
  Stored in directory: C:\Users\mryqu\AppData\Local\pip\Cache\wheels\03\05\65\bdc14f2c6e09e82ae3e0f13d021e1b6b2481437ea2f207df3f
Successfully built PyYAML
Installing collected packages: docutils, jmespath, six, python-dateutil, botocore, s3transfer, PyYAML, colorama, pyasn1, rsa, awscli
Successfully installed PyYAML-3.12 awscli-1.15.49 botocore-1.10.48 colorama-0.3.9 docutils-0.14 jmespath-0.9.3 pyasn1-0.4.3 python-dateutil-2.7.3 rsa-3.4.2 s3transfe
```
使用AWS CLI，貌似好用，就是help命令报内存不足！
```
C:\>aws --version
aws-cli/1.15.49 Python/3.7.0 Windows/2008ServerR2 botocore/1.10.48

C:\>aws configure list
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                             None    None
access_key                             None    None
secret_key                             None    None
    region                             None    None

C:\>aws help
Not enough memory.
```
最后发现，我在AWS上的SAS联合账户根本没权限获得AWS Access Key ID和AWS Secret Access Key，这样就没法按照[Configuring the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)进行配置了。棋差一招，只好不玩了。