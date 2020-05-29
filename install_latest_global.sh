#!/bin/bash

set -ev

sudo apt update
sudo apt build-dep global
sudo apt install libncurses5-dev libncursesw5-dev

wget -O ~/software/global-6.6.tar.gz https://ftp.gnu.org/pub/gnu/global/global-6.6.tar.gz 

cd ~/software/
tar -zxvf global-6.6.tar.gz
cd global-6.6
./configure --with-sqlite3   # gtags可以使用Sqlite3作为数据库, 在编译时需要加这个参数

make -j`nproc`
sudo make install
