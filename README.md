# npd-centos
Kubernetes node problem detector configration for centos

### Install Guideline

1. Initialize configmap for npd config and plugin


```
# make sure you have install kubectl and has configured to connect to your kubernetes cluster

git clone https://github.com/vipdocker/npd-centos.git
cd npd-centos
chmod +x init-configmap.sh
./init-configmap.sh
```

2. Install node problem detector as daemonset

```
# only the worker node will deploy the node problem detector
kubectl create -f npd.yaml
```

3. Verfiy node problem dectector is working well

- Make sure the node problem detector has running
- Check the npd log, something like below

```
I1009 11:52:45.311135       7 log_watchers.go:40] Use log watcher of plugin "journald"
I1009 11:52:45.311798       7 log_monitor.go:73] Start log monitor
I1009 11:52:45.313032       7 log_watcher.go:69] Start watching journald
I1009 11:52:45.313066       7 log_monitor.go:73] Start log monitor
I1009 11:52:45.313373       7 log_watcher.go:69] Start watching journald
I1009 11:52:45.313421       7 problem_detector.go:73] Problem detector started
I1009 11:52:45.313340       7 log_monitor.go:170] Initialize condition generated: [{Type:KernelDeadlock Status:False Transition:2018-10-09 11:52:45.313264794 +0800 CST m=+0.095167151 Reason:KernelHasNoDeadlock Message:kernel has no deadlock}]
I1009 11:52:45.313447       7 log_monitor.go:170] Initialize condition generated: []
```

- Send a journl message to simulate the docker daemon blocker 
```
echo "task docker:7 blocked for more than 300 seconds." |systemd-cat -t kernel
```

- Check the corresponding node has the Kernel deadlock=true conditioin

### Uninstall NPD

```
chmod +x uninstall-npd.sh
./uninstall-npd.sh
``` 
