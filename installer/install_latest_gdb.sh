#/bin/bash

DOWNLOAD_PATH=${1:-"~/software"}

set -ev

wget -O ${DOWNLOAD_PATH}/gdb-9.2.tar.xz http://ftp.gnu.org/gnu/gdb/gdb-9.2.tar.xz
sudo apt-get install texinfo

cd ${DOWNLOAD_PATH} && tar -xf gdb-9.2.tar.xz
cd gdb-9.2
rm -rf build && mkdir -p build && cd build
../configure
make -j$(nproc)
sudo cp gdb/gdb /usr/local/bin/gdb
sudo mkdir -p /usr/local/share/gdb/python/gdb
sudo cp -rf ~/software/gdb-9.2/gdb/python/lib/gdb/* /usr/local/share/gdb/python/gdb/
