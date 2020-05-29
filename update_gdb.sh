#/bin/bash

set -ev

#wget -O ~/software/gdb-9.2.tar.xz http://ftp.gnu.org/gnu/gdb/gdb-9.2.tar.xz

cd ~/software && tar -xf gdb-9.2.tar.xz
cd gdb-9.2
mkdir -p build && cd build
../configure
make $(nproc)
sudo cp ../gdb/gdb /usr/local/bin/gdb
