#!/bin/bash

sudo apt-get update

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get update -y
sudo apt-get install kubectl -y

vagrant up --provider=virtualbox

cp -r .kube $HOME/
rm -r .kube
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -k ./deployment