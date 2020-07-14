#!/bin/bash

# cheat-linux-amd64.gz https://github.com/cheat/cheat/releases
cd ~/software
gunzip cheat-linux-amd64.gz
sudo chmod 777 cheat-linux-amd64 && mv cheat-linux-amd64 cheat
sudo mv cheat /usr/local/bin
mkdir -p ~/.config/cheat && cheat --init > ~/.config/cheat/conf.yml
cheat -v

# docker install
#alias cheat='docker run --rm bannmann/docker-cheat'

##sudo apt-get install python
##sudo apt-get install python-pip
##sudo pip install docopt pygments
##sudo pip install cheat
##cheat -v
