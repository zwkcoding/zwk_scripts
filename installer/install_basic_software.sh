#!/bin/bash
 
set -ev

sudo apt install -y htop
sudo apt install -y openssh-server
sudo apt install -y subversion
sudo apt install -y git
sudo apt install -y vim
sudo apt install -y global

sudo apt install gdebi
sudo apt install synaptic
sudo apt install xclip
sudo apt install jq
sudo apt install gnome-tweak-tool
sudo apt install cloc # count lines of code
sudo apt install screenfetch # system info

# aptitude handled the dependencies correctly and even removed the packages that were creating the trouble

sudo apt install aptitude


# Screensaver
sudo apt-get remove gnome-screensaver
sudo apt-get install xscreensaver xscreensaver-data-extra xscreensaver-gl-extra
sudo apt-add-repository ppa:alexanderk23/ppa
sudo apt-get update
sudo apt-get install gluqlo
# edit ~/.xscreensaver [programs] :gluqlo -root \n\

