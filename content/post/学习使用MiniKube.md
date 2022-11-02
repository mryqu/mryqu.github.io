---
title: '学习使用Minikube'
date: 2019-06-13 06:12:34
categories: 
- Cloud
tags: 
- kubernetes
- minikube
---

在管理容器化应用方面，[Kubernetes](https://kubernetes.io/)是目前最好的工具之一。而[Minikube](https://github.com/kubernetes/minikube)能够在macOS、Linux和Windows平台上实现一个本地[Kubernetes](https://kubernetes.io/)集群，用于[Kubernetes](https://kubernetes.io/)的学习。  

[Minikube](https://github.com/kubernetes/minikube)是由Go语言实现，当前支持如下[Kubernetes](https://kubernetes.io/)特性：  
- DNS  
- NodePort  
- ConfigMap和Secret  
- 仪表盘  
- 容器运行时: Docker、rkt、CRI-O和containerd  
- 使能容器网络接口  
- Ingres  

![Minikube 本地安装部署示意](/images/2019/6/Minikube-localinstall-diagram.png)  
由上图可知，要使用Minikube，需要安装Minikube、kubectl和虚拟机。好在有[Katacoda](https://www.katacoda.com/)提供浏览器内的带有[Kubernetes](https://kubernetes.io/)环境的免费虚拟终端，省却了安装这一步骤。  
按照[Kubernetes](https://kubernetes.io/)的[Hello Minikube教程](https://kubernetes.io/docs/tutorials/hello-minikube/)走了一遍。  
![Run Minikube with Katacoda](/images/2019/6/Minikube-1.png) 
```
minikube version; minikube start
$
$ minikube version; minikube start
minikube version: v0.28.2
Starting local Kubernetes v1.10.0 cluster...
Starting VM...
Getting VM IP address...
Moving files into cluster...
Setting up certs...
Connecting to cluster...
Setting up kubeconfig...
Starting cluster components...
Kubectl is now configured to use the cluster.
Loading cached images from config file.
$
$ minikube --help
Minikube is a CLI tool that provisions and manages single-node Kubernetes clusters optimized for development workflows.

Usage:
  minikube [command]

Available Commands:
  addons           Modify minikube's kubernetes addons
  cache            Add or delete an image from the local cache.
  completion       Outputs minikube shell completion for the given shell (bash or zsh)
  config           Modify minikube config
  dashboard        Opens/displays the kubernetes dashboard URL for your local cluster
  delete           Deletes a local kubernetes cluster
  docker-env       Sets up docker env variables; similar to '$(docker-machine env)'
  get-k8s-versions Gets the list of Kubernetes versions available for minikube when using the localkube bootstrapper
  help             Help about any command
  ip               Retrieves the IP address of the running cluster
  logs             Gets the logs of the running localkube instance, used for debugging minikube, not user code
  mount            Mounts the specified directory into minikube
  profile          Profile sets the current minikube profile
  service          Gets the kubernetes URL(s) for the specified service in your local cluster
  ssh              Log into or run a command on a machine with SSH; similar to 'docker-machine ssh'
  ssh-key          Retrieve the ssh identity key path of the specified cluster
  start            Starts a local kubernetes cluster
  status           Gets the status of a local kubernetes cluster
  stop             Stops a running local kubernetes cluster
  update-check     Print current and latest version number
  update-context   Verify the IP address of the running cluster in kubeconfig.
  version          Print the version of minikube

Flags:
      --alsologtostderr                  log to standard error as well as files
  -b, --bootstrapper string              The name of the cluster bootstrapper that will set up the kubernetes cluster. (default "kubeadm")
  -h, --help                             help for minikube
      --log_backtrace_at traceLocation   when logging hits line file:N, emit a stack trace (default :0)
      --log_dir string                   If non-empty, write log files in this directory
      --loglevel int                     Log level (0 = DEBUG, 5 = FATAL) (default 1)
      --logtostderr                      log to standard error instead of files
  -p, --profile string                   The name of the minikube VM being used.
        This can be modified to allow for multiple minikube instances to be run independently (default "minikube")
      --stderrthreshold severity         logs at or above this threshold go to stderr (default 2)
  -v, --v Level                          log level for V logs
      --vmodule moduleSpec               comma-separated list of pattern=N settings for file-filtered logging

Use "minikube [command] --help" for more information about a command.
$
$ minikube status
minikube: Running
cluster: Running
kubectl: Correctly Configured: pointing to minikube-vm at 172.17.0.48
$ minikube dashboard
Opening kubernetes dashboard in default browser...
$ kubectl create deployment hello-node --image=gcr.io/hello-minikube-zero-install/hello-node
deployment.apps/hello-node created
$ kubectl get deployments
NAME         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
hello-node   1         1         1            0           6s
$ kubectl get deployments
NAME         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
hello-node   1         1         1            1           1m
$ kubectl get pods
NAME                          READY     STATUS    RESTARTS   AGE
hello-node-7f5b6bd6b8-xsv8q   1/1       Running   0          1m
$ kubectl get events
LAST SEEN   FIRST SEEN   COUNT     NAME                                           KIND         SUBOBJECT                     TYPE      REASON SOURCE                  MESSAGE
8m          8m           1         minikube.15a7b294ca3e3206                      Node                                       Normal    Starting kubelet, minikube       Starting kubelet.
8m          8m           1         minikube.15a7b294fd3f5d0a                      Node                                       Normal    Starting kube-proxy, minikube    Starting kube-proxy.
8m          8m           1         minikube.15a7b294d0df5af8                      Node                                       Normal    NodeHasSufficientPID kubelet, minikube       Node minikube status is now: NodeHasSufficientPID
8m          8m           1         minikube.15a7b294d0df44a0                      Node                                       Normal    NodeHasNoDiskPressure kubelet, minikube       Node minikube status is now: NodeHasNoDiskPressure
8m          8m           1         minikube.15a7b294d0df2ab9                      Node                                       Normal    NodeHasSufficientMemory kubelet, minikube       Node minikube status is now: NodeHasSufficientMemory
8m          8m           1         minikube.15a7b294d0df04be                      Node                                       Normal    NodeHasSufficientDisk kubelet, minikube       Node minikube status is now: NodeHasSufficientDisk
8m          8m           1         minikube.15a7b2954df56145                      Node                                       Normal    NodeAllocatableEnforced kubelet, minikube       Updated Node Allocatable limit across pods
8m          8m           1         minikube.15a7b2972a0b97fc                      Node                                       Normal    NodeReady kubelet, minikube       Node minikube status is now: NodeReady
1m          1m           1         hello-node.15a7b2f9dca4ac42                    Deployment                                 Normal    ScalingReplicaSet deployment-controller   Scaled up replica set hello-node-7f5b6bd6b8 to 1
1m          1m           1         hello-node-7f5b6bd6b8.15a7b2f9dcb8c32e         ReplicaSet                                 Normal    SuccessfulCreate replicaset-controller   Created pod: hello-node-7f5b6bd6b8-xsv8q
1m          1m           1         hello-node-7f5b6bd6b8-xsv8q.15a7b2f9fe7cf48f   Pod          spec.containers{hello-node}   Normal    Pulling kubelet, minikube       pulling image "gcr.io/hello-minikube-zero-install/hello-node"
1m          1m           1         hello-node-7f5b6bd6b8-xsv8q.15a7b2f9ef33a6b7   Pod                                        Normal    SuccessfulMountVolume kubelet, minikube       MountVolume.SetUp succeeded for volume "default-token-kmdrg"
1m          1m           1         hello-node-7f5b6bd6b8-xsv8q.15a7b2f9dda4da8c   Pod                                        Normal    Scheduled default-scheduler       Successfully assigned hello-node-7f5b6bd6b8-xsv8q to minikube
59s         59s          1         hello-node-7f5b6bd6b8-xsv8q.15a7b301584221b0   Pod          spec.containers{hello-node}   Normal    Started kubelet, minikube       Started container
59s         59s          1         hello-node-7f5b6bd6b8-xsv8q.15a7b301517672cd   Pod          spec.containers{hello-node}   Normal    Created kubelet, minikube       Created container
59s         59s          1         hello-node-7f5b6bd6b8-xsv8q.15a7b3014df0fe95   Pod          spec.containers{hello-node}   Normal    Pulled kubelet, minikube       Successfully pulled image "gcr.io/hello-minikube-zero-install/hello-node"
$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /root/.minikube/ca.crt
    server: https://172.17.0.48:8443
  name: minikube
contexts:
- context:
    cluster: minikube
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /root/.minikube/client.crt
    client-key: /root/.minikube/client.key
$ kubectl expose deployment hello-node --type=LoadBalancer --port=8080
service/hello-node exposed
$ kubectl get services
NAME         TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
hello-node   LoadBalancer   10.103.104.233   <pending>     8080:31739/TCP   4s
kubernetes   ClusterIP      10.96.0.1        <none>        443/TCP          9m
$ minikube service hello-node
Opening kubernetes service default/hello-node in default browser...
$ minikube addons list
- addon-manager: enabled
- coredns: disabled
- dashboard: enabled
- default-storageclass: enabled
- efk: disabled
- freshpod: disabled
- heapster: disabled
- ingress: disabled
- kube-dns: enabled
- metrics-server: disabled
- nvidia-driver-installer: disabled
- nvidia-gpu-device-plugin: disabled
- registry: disabled
- registry-creds: disabled
- storage-provisioner: enabled
$ minikube addons enable heapster
heapster was successfully enabled
$ kubectl get pod,svc -n kube-system
NAME                                        READY     STATUS    RESTARTS   AGE
pod/heapster-2mztm                          1/1       Running   0          3m
pod/influxdb-grafana-v5j5q                  2/2       Running   0          3m
pod/kube-addon-manager-minikube             1/1       Running   0          17m
pod/kube-dns-6dcb57bcc8-84zs7               3/3       Running   0          17m
pod/kubernetes-dashboard-5498ccf677-xc4kr   1/1       Running   0          17m
pod/storage-provisioner                     1/1       Running   0          17m

NAME                           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/heapster               ClusterIP   10.107.109.88    <none>        80/TCP              3m
service/kube-dns               ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP       17m
service/kubernetes-dashboard   NodePort    10.111.86.255    <none>        80:30000/TCP        17m
service/monitoring-grafana     NodePort    10.111.167.239   <none>        80:30002/TCP        3m
service/monitoring-influxdb    ClusterIP   10.98.229.238    <none>        8083/TCP,8086/TCP   3m
$ minikube addons disable heapster
heapster was successfully disabled
$ kubectl delete service hello-node
service "hello-node" deleted
$ kubectl delete deployment hello-node
deployment.extensions "hello-node" deleted
$ minikube stop
Stopping local Kubernetes cluster...
Machine stopped.
$
```

唯一要注意的是，教程里提到打开Kubernetes仪表盘使用`Select port to view on Host 1`菜单，结果是502 Bad GateWay错误。可使用`View HTTP port 80 on Host 1`然后修改端口为30000即可。
![Postman: new Env](/images/2019/6/Minikube-2.png)  

![Postman: new Env](/images/2019/6/Minikube-3.png)  

![Postman: new Env](/images/2019/6/Minikube-4.png)  
  
使用[Katacoda](https://www.katacoda.com/)，下列命令也可以一试。  
```
minikube ip                      # Get IP address of the running cluster
kubectl cluster-info             # Get cluster information
minikube dashboard --url         # Get the Dashboard URL
minikube service --url SERVICE   # Get the URL of service
```
  
### 参考

[Install Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)  
[Installing Kubernetes with Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/)  
[Kubernetes NodePort vs LoadBalancer vs Ingress? When should I use what?](https://medium.com/google-cloud/kubernetes-nodeport-vs-loadbalancer-vs-ingress-when-should-i-use-what-922f010849e0)  
[MINIKUBE CHEATSHEET](https://cheatsheet.dennyzhang.com/cheatsheet-minikube-a4)  
[Minikube体验](https://www.cnblogs.com/cocowool/p/minikube_setup_and_first_sample.html)  
[Minikube: easily run Kubernetes locally](https://kubernetes.io/blog/2016/07/minikube-easily-run-kubernetes-locally/)  