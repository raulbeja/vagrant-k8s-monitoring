#!/bin/bash

kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address $(getent ahostsv4 $(hostname) | grep STREAM | tail -n 1 | awk '{print $1}')

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubeadm token create --print-join-command > /vagrant/joincluster.sh

sudo mkdir -p /home/vagrant/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown vagrant:vagrant /home/vagrant/.kube/config
sudo cp -i -r /home/vagrant/.kube /vagrant

#kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/v0.20.2/Documentation/kube-flannel.yml
kubectl apply -f /vagrant/vm-script/kube-flannel.yml

sudo apt-get install nfs-kernel-server
sudo mkdir -p /mnt/nfs/prometheus-data
echo '/mnt/nfs/prometheus-data  *(rw,no_root_squash)' | sudo tee -a /etc/exports
sudo systemctl restart nfs-kernel-server

curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
