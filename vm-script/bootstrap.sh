#!/bin/bash

sudo apt-get update

sudo swapoff -a
sudo sed -i.bak '/swap.img/d' /etc/fstab

sudo cat <<EOF | sudo tee /etc/sysctl.conf 
net.ipv4.ip_forward = 1
EOF

sudo apt-get install apt-transport-https ca-certificates curl software-properties-common nfs-common -y
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get install docker-ce -y

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get update -y
sudo apt-get install kubelet kubeadm kubectl -y

sudo cat <<EOF | sudo tee /etc/docker/daemon.json 
{ "exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts":
{ "max-size": "100m" },
"storage-driver": "overlay2"
}
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker

sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd

