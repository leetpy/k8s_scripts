#!/bin/bash

function install {
    yum install -y kubelet-1.10.0 kubeadm-1.10.0
}

function config {
    systemctl stop firewalld
    systemctl disable firewalld

    setenforce  0
    sed -i "s/^SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

    systemctl enable kubelet
    systemctl start kubelet

    kubeadm init --apiserver-advertise-address 192.168.31.2 --pod-network-cidr 192.168.4.0/24
}
