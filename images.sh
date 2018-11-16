#!/bin/bash

# You can get images list by execute `kubeadm config images list`
images = (
    kube-apiserver:v1.12.2
    kube-controller-manager:v1.12.2
    kube-scheduler:v1.12.2
    kube-proxy:v1.12.2
    pause:3.1
    etcd:3.2.24
    coredns:1.2.2
)

function download {
    for img in ${images[@]}
    do
        docker pull k8s.gcr.io/$img
        docker save k8s.gcr.io/$img -o ${img}.tar
    done
}

function upload {
    for img in ${images[@]}
    do
        docker load ${img}.tar
        docker tag k8s.gcr.io/$img
    done
}

