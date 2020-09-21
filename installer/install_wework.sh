#/bin/bash

set -e 

# https://github.com/zq1997/deepin-wine

wget -O- https://deepin-wine.i-m.dev/setup.sh | sh


sudo apt-get install deepin.com.weixin.work

# uninstall
# sudo apt-get purge --autoremove deepin.xxxxx
# sudo rm /etc/apt/preferences.d/deepin-wine.i-m.dev.pref \
#       /etc/apt/sources.list.d/deepin-wine.i-m.dev.list
#sudo apt-get update

