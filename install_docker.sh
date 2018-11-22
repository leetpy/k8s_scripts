#!/bin/bash

function install {
    # remove old docker
    # yum -y remove docker*

    # add repo
    yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

    yum install -y --setopt=obsoletes=0 \
        docker-ce-17.03.2.ce-1.el7.centos.x86_64 \
        docker-ce-selinux-17.03.2.ce-1.el7.centos.noarch
}

install

