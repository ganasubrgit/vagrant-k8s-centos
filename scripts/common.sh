#!/usr/bin/env bash

if [ ! -f /bin/vim ]; then
  echo "Installing vim"
  yum install -y vim
fi

if [ ! -f /bin/netstat ]; then
  echo "Installing net-tools"
  yum install -y net-tools
fi
