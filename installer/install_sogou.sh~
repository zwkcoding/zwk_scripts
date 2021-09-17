#!/bin/bash
set -e  # exit on first error

GREEN_COLOR='\E[1;32m'
YELOW_COLOR='\E[1;33m'
WRITE_COLOR='\E[1;37m'
echo "Installing sogoupinyin for ubuntu 16.04."
sudo sed -i '$a\deb http://archive.ubuntukylin.com:10006/ubuntukylin xenial main' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y sogoupinyin --allow-unauthenticated
echo -e  "${GREEN_COLOR}=============================  Click <<+>>  =============================${RES}"
echo -e  "${GREEN_COLOR}===== Uncheck <<Only Show Current Language>> And Search <<Sogou>>!!! =====${RES}"
echo -e  "${YELOW_COLOR}======= If you can't find it,you need to <<restart>> your computer ======${RES}"
echo -e  "${YELOW_COLOR}================  And <<./install_sogou.sh>> again!!!  ================${RES}"
echo " "
echo -e  "${WRITE_COLOR}#########################################################${RES}"
cd /usr/bin/
./fcitx-configtool

echo "sogoupinyin has been installed in your computer"
