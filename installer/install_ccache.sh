#/bin/bash

sudo apt install -y ccache
# Prepend ccache into the PATH
echo 'export PATH="/usr/lib/ccache:$PATH"' | tee -a ~/.bashrc

sudo ln -s /usr/bin/ccache /usr/local/bin/gcc
sudo ln -s /usr/bin/ccache /usr/local/bin/g++
sudo ln -s /usr/bin/ccache /usr/local/bin/cc

# Update symlinks
sudo /usr/sbin/update-ccache-symlinks

#sudo sed '/export/a\export USE_CCACHE=1\nexport CCACHE_DIR=$HOME/.ccache' ~/.bashrc
ccache -M 100G
#sudo sed '/PATH/a\export PATH=/usr/lib/ccache:$PATH'
#If you want no limit to the number of files and size of the cache:

#ccache -F 0
#ccache -M 0
#Show cache statistics:

#ccache -s

#Empty the cache and reset the stats:

#ccache -C -z

which g++ gcc

