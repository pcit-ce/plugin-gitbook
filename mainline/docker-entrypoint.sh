#!/bin/sh
date
du -sh /tmp/gitbook/node_modules
cp -r /tmp/gitbook/node_modules .
echo $PWD
if [ $1 = "server" ];then
  gitbook serve
else
  gitbook build
fi
