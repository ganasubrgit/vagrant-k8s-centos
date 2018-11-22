# vagrant-k8s-centos

```bash
$ vagrant up --provision
$ vagrant halt
$ vagrant destroy
```

# Test
Test if services is working by executing this tutorial [kubernetes by example](http://kubernetesbyexample.com/services/) and running curl from each cluster node

```bash
$ curl CLUSTER_IP/info
```
