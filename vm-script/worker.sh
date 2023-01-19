#! /bin/bash
 
/bin/bash /vagrant/joincluster.sh -v

sudo systemctl restart systemd-resolved
sudo swapoff -a && sudo systemctl daemon-reload && sudo systemctl restart kubelet
