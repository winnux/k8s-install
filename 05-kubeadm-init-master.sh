#!/bin/bash
#kubeadm init --image-repository=https://registry.aliyuncs.com/google_containers --apiserver-advertise-address 172.17.96.1 --pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.21.2

kubeadm init  --apiserver-advertise-address 172.17.96.1 --pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.21.2
