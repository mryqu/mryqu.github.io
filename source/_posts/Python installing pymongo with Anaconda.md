---
title: 'Python: installing pymongo with Anaconda'
date: 2015-04-04 00:06:03
categories: 
- Python
tags: 
- python
- anaconda
- pymongo
- mongodb
- 安装
---
在Anaconda发行版Python上通过`conda install pymongo`安装MongoDBpython驱动，结果失败了，最终通过`conda install -c https://conda.binstar.org/anaconda pymongo`安装成功。

BinstarBinstar和Anaconda都是同一家的产品，是Continuum Analytics推出的一个包管理服务，托管公开的pip和conda。
安装记录如下：
```
C:\tools\Anaconda>conda list
# packages in environment at C:\tools\Anaconda:
#
_license                  1.1                      py27_0
anaconda                  2.0.1                np18py27_0
argcomplete               0.6.7                    py27_0
astropy                   0.3.2                np18py27_0
atom                      0.3.7                    py27_0
backports.ssl-match-hostname 3.4.0.2                   
beautiful-soup            4.3.1                    py27_0
beautifulsoup4            4.3.1                     
binstar                   0.5.3                    py27_0
bitarray                  0.8.1                    py27_1
blaze                     0.5.0                np18py27_1
blz                       0.6.2                np18py27_0
bokeh                     0.4.4                np18py27_1
boto                      2.28.0                   py27_0
casuarius                 1.1                      py27_0
cdecimal                  2.3                      py27_1
chaco                     4.4.1                np18py27_0
colorama                  0.2.7                    py27_0
conda                     3.5.5                    py27_0
conda-build               1.3.5                    py27_0
configobj                 5.0.5                    py27_0
cubes                     0.10.2                   py27_4
cython                    0.20.1                   py27_0
datashape                 0.2.0                np18py27_1
dateutil                  2.1                      py27_2
docutils                  0.11                     py27_0
dynd-python               0.6.2                np18py27_0
enable                    4.3.0                np18py27_2
enaml                     0.9.1                    py27_1
flask                     0.10.1                   py27_1
future                    0.12.1                   py27_0
gevent                    1.0.1                    py27_0
gevent-websocket          0.9.3                    py27_0
greenlet                  0.4.2                    py27_0
grin                      1.2.1                    py27_2
h5py                      2.3.0                np18py27_0
ipython                   2.1.0                    py27_2
ipython-notebook          2.1.0                    py27_0
ipython-qtconsole         2.1.0                    py27_0
itsdangerous              0.24                     py27_0
jdcal                     1.0                      py27_0
jinja2                    2.7.2                    py27_0
kiwisolver                0.1.2                    py27_0
launcher                  0.1.5                    py27_0
libpython                 1.0                      py27_1
llvmpy                    0.12.6                   py27_0
lxml                      3.3.5                    py27_0
markupsafe                0.18                     py27_1
matplotlib                1.3.1                np18py27_2
menuinst                  1.0.3                    py27_0
mingw                     4.7                           1
mock                      1.0.1                    py27_0
multipledispatch          0.4.3                    py27_0
networkx                  1.8.1                    py27_0
nltk                      2.0.4                np18py27_0
nose                      1.3.3                    py27_0
numba                     0.13.2               np18py27_0
numexpr                   2.3.1                np18py27_0
numpy                     1.8.1                    py27_0
openpyxl                  1.8.5                    py27_0
pandas                    0.14.0               np18py27_0
patsy                     0.2.1                np18py27_0
pep8                      1.5.6                    py27_0
pil                       1.1.7                    py27_0
pip                       1.5.6                    py27_0
ply                       3.4                      py27_0
psutil                    2.1.1                    py27_0
py                        1.4.20                   py27_0
pycosat                   0.6.1                    py27_0
pycparser                 2.10                     py27_0
pycrypto                  2.6.1                    py27_1
pyface                    4.4.0                    py27_0
pyflakes                  0.8.1                    py27_0
pygments                  1.6                      py27_0
pyparsing                 2.0.1                    py27_0
pyqt                      4.10.4                   py27_0
pyreadline                2.0                      py27_0
pytables                  3.1.1                np18py27_0
pytest                    2.5.2                    py27_0
python                    2.7.7                         1
python-dateutil           1.5                       
pytz                      2014.3                   py27_0
pywin32                   218.4                    py27_0
pyyaml                    3.11                     py27_0
pyzmq                     14.3.0                   py27_0
requests                  2.3.0                    py27_0
rope                      0.9.4                    py27_1
runipy                    0.1.0                    py27_0
scikit-image              0.10.0               np18py27_0
scikit-learn              0.14.1               np18py27_2
scipy                     0.14.0               np18py27_0
setuptools                3.6                      py27_0
six                       1.6.1                    py27_0
sphinx                    1.2.2                    py27_0
spyder                    2.3.0rc1                 py27_0
spyder-app                2.3.0rc1                 py27_0
sqlalchemy                0.9.4                    py27_0
ssl_match_hostname        3.4.0.2                  py27_0
statsmodels               0.5.0                np18py27_1
sympy                     0.7.5                    py27_0
tables                    3.1.1                     
tornado                   3.2.1                    py27_0
traits                    4.4.0                    py27_0
traitsui                  4.4.0                    py27_0
ujson                     1.33                     py27_0
werkzeug                  0.9.6                    py27_0
wsgiref                   0.1.2                     
xlrd                      0.9.3                    py27_0
xlsxwriter                0.5.5                    py27_0
xlwings                   0.1.0                    py27_0
xlwt                      0.7.5                    py27_0

C:\tools\Anaconda>conda install pymongo
Fetching package metadata: .Could not connect to http://repo.continuum.io/pkgs/pro/win-64/
.Could not connect to http://repo.continuum.io/pkgs/free/win-64/

Error: No packages found matching: pymongo

C:\tools\Anaconda>conda install -c https://conda.binstar.org/anaconda pymongo
Fetching package metadata: .Could not connect to http://repo.continuum.io/pkgs/pro/win-64/
.Could not connect to http://repo.continuum.io/pkgs/free/win-64/
.
Solving package specifications: .
Package plan for installation in environment C:\tools\Anaconda:

The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    conda-3.9.1                |           py27_0         206 KB
    conda-env-2.1.3            |           py27_0          54 KB
    pymongo-2.8                |           py27_0         241 KB
    requests-2.5.3             |           py27_0         588 KB
    ------------------------------------------------------------
                                           Total:         1.1 MB

The following packages will be UN-linked:

    package                    |            build
    ---------------------------|-----------------
    conda-3.5.5                |           py27_0
    requests-2.3.0             |           py27_0

The following packages will be linked:

    package                    |            build
    ---------------------------|-----------------
    conda-3.9.1                |           py27_0   hard-link
    conda-env-2.1.3            |           py27_0   hard-link
    pymongo-2.8                |           py27_0   hard-link
    requests-2.5.3             |           py27_0   hard-link

Proceed ([y]/n)? y

Fetching packages ...
conda-3.9.1-py 100% |###############################| Time: 0:00:01 137.71 kB/s
conda-env-2.1. 100% |###############################| Time: 0:00:00 109.51 kB/s
pymongo-2.8-py 100% |###############################| Time: 0:00:01 136.74 kB/s
requests-2.5.3 100% |###############################| Time: 0:00:13  44.13 kB/s
Extracting packages ...
[      COMPLETE      ] |#################################################| 100%
Unlinking packages ...
[      COMPLETE      ] |#################################################| 100%
Linking packages ...
[      COMPLETE      ] |#################################################| 100%

C:\tools\Anaconda>conda info
Current conda install:

             platform : win-64
        conda version : 3.9.1
  conda-build version : 1.3.5
       python version : 2.7.7.final.0
     requests version : 2.5.3
     root environment : C:\tools\Anaconda  (writable)
  default environment : C:\tools\Anaconda
     envs directories : C:\tools\Anaconda\envs
        package cache : C:\tools\Anaconda\pkgs
         channel URLs : http://repo.continuum.io/pkgs/free/win-64/
                        http://repo.continuum.io/pkgs/free/noarch/
                        http://repo.continuum.io/pkgs/pro/win-64/
                        http://repo.continuum.io/pkgs/pro/noarch/
          config file : None
    is foreign system : False
```


