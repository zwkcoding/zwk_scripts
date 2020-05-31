#!/bin/bash

wget -O ~/software/tifig.tar.gz https://github.com/monostream/tifig/releases/download/0.2.2/tifig-static-0.2.2.tar.gz
cd ~/software
tar -zxvf tifig.tar.gz
sudo chmod +x tifig

cd $1
for f in *.HEIC; do mv "$f" "\`echo $f | sed s/.HEIC/.heic/`"; done
for file in *.heic; do echo $file | xargs ~/software/tifig -v -p $file ${file%.heic}.jpg; done
