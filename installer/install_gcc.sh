#/bin/bash

set -ev

# default distribute version
sudo apt install build-essential
sudo apt install gcc

# keep different gcc version
# ref: https://gist.github.com/application2000/73fd6f4bf1be6600a2cf9f56315a2d91
sudo apt-get update -y && \
sudo apt-get upgrade -y && \
sudo apt-get dist-upgrade -y && \
sudo apt-get install build-essential software-properties-common -y && \
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
sudo apt-get update -y && \
sudo apt-get install gcc-7 g++-7 -y && \
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/g++ g++ /usr/bin/g++-7 && \
sudo update-alternatives --config gcc

# broken gcc packages: https://askubuntu.com/a/428242/942228
sudo apt clean && sudo apt-get update
sudo apt upgrade -y
sudo apt autoremove
sudo dpkg --list
sudo apt-get purge "file-name"
sudo dpkg --get-selections | grep hold
sudo aptitude install gcc
sudo aptitude -f install gcc

#sudo apt-get update && \
# sudo apt-get install build-essential software-properties-common -y && \
# sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
# sudo apt-get update && \
# sudo apt-get install gcc-snapshot -y && \
# sudo apt-get update && \
# sudo apt-get install gcc-6 g++-6 -y && \
# sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6 && \
# sudo apt-get install gcc-5 g++-5 -y && \
# sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 60 --slave /usr/bin/g++ g++ /usr/bin/g++-5;
#
#sudo update-alternatives --config gcc

# uninstall
# sudo apt-get --purge remove gcc-<version>

ls /usr/bin/gcc*
gcc -v
