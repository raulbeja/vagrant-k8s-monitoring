# Monitoring Kubernetes Cluster with Prometheus and AlertManager via Vagrant

## Prerequisites

1. Vagrant Installed
[![Vagrant](https://img.shields.io/static/v1?message=Vagrant&logo=vagrant&labelColor=5c5c5c&color=1182c3&logoColor=white&label=%20&style=plastic)](https://developer.hashicorp.com/vagrant/downloads)
2. Virtualbox provider
[![VirtualBox](https://img.shields.io/static/v1?message=Virtualbox&logo=virtualbox&labelColor=5c5c5c&color=1182c3&logoColor=white&label=%20&style=plastic)](https://www.virtualbox.org/wiki/Downloads)
3. At least 4 cpus and 4Gb RAM workstation.

## Cloning the repo to get files and create cluster;

It is considered that you have Github account and access to clone the repo.

Once you traversed to the local path where you want to clone the repo execute:

```shell
git clone https://github.com/raulbeja/vagrant-k8s-moniotoring.git
cd vagrant-k8s-monitoring
sh ./k8s-cluster-monitoring.sh
```

## Automation Files ...

### Vagrantfile
```shell
Use nodes to map your cluster nodes configuration
nodes = [
    { :hostname => 'K8master',
      :ip => '192.168.56.20',
      :box => 'bento/ubuntu-20.04',
      :ram => 2048,
      :cpus => 2 }, 
    { :hostname => 'K8worker1',
      :ip => '192.168.56.51',
      :box => 'bento/ubuntu-20.04',
      :ram => 1024,
      :cpus => 1 }
  ]

Enabled hostmanager plugin to get hosts files updated.

```

### deployment files
```shell
- monitoring.yaml
    Create a namespace for application
- persistent-volume.yaml
    Create a persistent volume for prometheus data
- cluster-role.yaml
    Create a cluster role for prometheus
- service-account.yaml
    Create a service account for prometheus
- cluster-role-binding.yaml
    Bind cluster role to service account
- prometheus-config-map.yaml
    Configure prometheus and define rules
- prometheus-deployment.yaml
    Deploy prometheus application pods
- prometheus-service.yaml
    Expose prometheus in port 30000
- alertmanager-config-map.yaml
    Configure alertmanager to send alerts to a slack channel
- alertmanager-deployment.yaml
    Deploy alertmanager application pods
- alertmanager-service.yaml
    Expose alertmanager in port 31000

```

### vm-/script/bootstrap.sh
```shell
Install docker community edition as container runtime and kubernetes tools in cluster nodes.

```
### vm-/script/master.sh
```shell
Initialize cluster and install Kustomize in master node.
Enable regular user to start using de cluster.
Create shell script used by workers to join the cluster.
Set flannel as network fabric for containers using a local customized file configuring flannel to use a non default interface (eth1 in this case)
Create and export nfs directory for persistent data

```

### vm-/script/worker.sh
```shell
Run joincluster.sh created by master.sh to join workers nodes to the cluster

```

### k8s-cluster-monitoring.sh
```shell
Install Kubernetes tool kubectl in local machine.
Start up vagrantfile
Enable your user to start using the cluster
Deploy prometheus and alertmanager in the cluster using kustomization.

```
## Basic Operations ...

### To check all container status, 
```shell
kubectl get pods -A

```

### To connect to a cluster machine, 
```shell
vagrant ssh node[:hostname]

```

### To shutdown the cluster, 
```shell
vagrant halt

```

### To restart the cluster,
```shell
vagrant up

```

### To destroy the cluster, 
```shell
vagrant destroy -f

```