#!/bin/sh
SDK_PATH=/usr/lib/
if [ ! -d $SDK_PATH ]; then
  echo "no dir ${SDK_PATH}"
  exit 1
fi
cd $SDK_PATH
source ./qt_env_set.sh
cd /home/root/
chmod +x B302
./B302

