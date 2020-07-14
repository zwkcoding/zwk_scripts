#!/bin/bash

set -ev

# https://github.com/zq1997/deepin-wine
wget -O- https://deepin-wine.i-m.dev/setup.sh | sh
sudo apt-get install deepin.com.weixin.work
