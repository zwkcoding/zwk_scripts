#!/bin/bash

#ref to:https://apt.llvm.org/
#To install the latest stable version:
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

#To install a specific version of LLVM:
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh <version number>

# temporary method
#export CC=/usr/bin/clang-10
#export CPP=/usr/bin/clang-cpp-10
#export CXX=/usr/bin/clang++-10
#export LD=/usr/bin/ld.lld-10

sudo update-alternatives --install /usr/bin/cc cc /usr/bin/clang-10 100
sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-10 100
sudo update-alternatives --config cc
sudo update-alternatives --config c++
