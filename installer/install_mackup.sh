#!/bin/bash

set -e

mkdir -p $HOME/dotfiles/
cd $HOME/dotfiles
git clone git@github.com:zwkcoding/mackup.git
cd mackup
cp .mackup.cfg ~/
#markup backup
markup restore
