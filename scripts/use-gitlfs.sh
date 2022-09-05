#!/bin/sh

if ! wget --help >> /dev/null ; then echo "[missing dep] please install wget" ; exit 1 ; fi

cd /tmp
wget https://github.com/git-lfs/git-lfs/releases/download/v2.9.0/git-lfs-linux-amd64-v2.9.0.tar.gz
tar zxvf git-lfs-linux-amd64-v2.9.0.tar.gz
chmod 755 ./install.sh

./install.sh

