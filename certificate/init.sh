#!/bin/bash

workdir=$(cd "$(dirname "$0")";pwd)

function install_cfssl {
    local install_dir="/usr/local/bin"
    if [ ! -f $install_dir/cfssl ]; then
        cp -a $workdir/bin/cfssl_linux-amd64 $install_dir/cfssl
        chmod a+x $install_dir/cfssl
    fi

    if [ ! -f $install_dir/cfssljson ]; then
        cp -a $workdir/bin/cfssljson_linux-amd64 $install_dir/cfssljson
        chmod a+x $install_dir/cfssljson
    fi

    if [ ! -f $install_dir/cfssl-certinfo ]; then
        cp -a $workdir/bin/cfssl-certinfo_linux-amd64 $install_dir/cfssl-certinfo
        chmod a+x $install_dir/cfssl-certinfo
    fi
}

function gencert {
    output=$workdir/output
    rm -rf $output
    mkdir -p $workdir/output

    cfssl gencert -initca ca-csr.json | cfssljson -bare ca
    cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json \
          -profile=kubernetes etcd-csr.json | cfssljson -bare etcd

    mv ca-key.pem $output
    mv ca.pem $output
    mv ca.csr $output

    mv etcd-key.pem $output
    mv etcd.pem $output
    mv etcd.csr $output
}

install_cfssl
gencert
