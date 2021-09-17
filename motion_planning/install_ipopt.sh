#!/bin/bash
set -e # exit on first error
SOURCE_DIR="/tmp"

install_ipopt()
{
    echo "Prepare to install IPOPT ..."
    IPOPT_URL="https://git.coding.net/aRagdoll/Ipopt-3.12.4.git"

    sudo apt-get update
    sudo apt-get -y install \
        gfortran \
        cmake  \
        build-essential \
        gcc \
        g++
    if ( ldconfig -p | grep libipopt ); then
        echo "Ipopt is already installed......."
    else
        echo "Start installing Ipopt, version: 3.12.4  .........."
        cd $SOURCE_DIR
        rm -rf Ipopt-3.12.4 && git clone "$IPOPT_URL" && cd Ipopt-3.12.4
        # configure,build and install the IPOPT
        echo "Configuring and building IPOPT ..."
        ./configure --prefix /usr/local
        make -j$(nproc)
        make test
        sudo make install
        if (grep 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' $HOME/.bashrc); then
          echo "LD_LIBRARY_PATH has been set."
        else
          echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> $HOME/.bashrc
        fi
        sudo ldconfig
        echo "IPOPT installed successfully"
        source $HOME/.bashrc
    fi
}

install_ipopt
