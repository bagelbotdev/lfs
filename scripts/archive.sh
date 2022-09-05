#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

data_path=$1
archive_name=$2

cd $SCRIPT_DIR/..

git fetch --all
git reset --hard origin/master
git pull origin master

(cd $data_path && tar cf - *) |
	gzip -9 > $SCRIPT_DIR/../$archive_name

cd $SCRIPT_DIR/..

git config user.name "bagelbot-lfs"
git config user.email "bagelbot@erwijet.com"

git commit -a -m "$(date)"
git push origin master
