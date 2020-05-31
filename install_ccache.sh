#/bin/bash

sudo apt install ccache
#sudo sed '/export/a\export USE_CCACHE=1\nexport CCACHE_DIR=$HOME/.ccache' ~/.bashrc
ccache -M 100G
#sudo sed '/PATH/a\export PATH=/usr/lib/ccache:$PATH'
