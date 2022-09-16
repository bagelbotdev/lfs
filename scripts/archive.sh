#!/bin/bash


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if ! git lfs --help > /dev/null ; then $SCRIPT_DIR/use-gitlfs.sh ; fi
if ! gpg --help > /dev/null ; then echo "[FAIL] please install gpg" ; exit 1 ; fi

data_path=$1
archive_name=$2

cd $SCRIPT_DIR/..

git fetch --all
git reset --hard origin/master
git pull origin master

(cd $data_path && tar cf - *) |
	gzip -9 > $SCRIPT_DIR/../$archive_name.tgz

cd $SCRIPT_DIR/..
gpg -c $SCRIPT_DIR/../$archive_name.tgz
rm $SCRIPT_DIR/../$archive_name.tgz

git config user.name "bagelbot-lfs"
git config user.email "bagelbot@erwijet.com"

git lfs track $archive_name.tgz.gpg
git add $archive_name.tgz.gpg
git add .gitattributes

git commit -m "$(date)"
git push origin master
