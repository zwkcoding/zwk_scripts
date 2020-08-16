#!/bin/bash

set -ev

# 如果要让终端下的命令被代理转发，这时我们就要用上 proxychains-ng 这款神器
# proxychains-ng 是 proxychains 的加强版, 支持 http/https/socks4/socks5

cd /tmp && git clone https://github.com/rofl0r/proxychains-ng
cd proxychains-ng ./configure --prefix=/usr --sysconfdir=/etc
make && sudo make install #&& sudo make install-config 

sudo sed -i '/socks4 [[:space:]] 127.0.0.1/s/^/#&/' /etc/proxychains.conf
sudo sed -i '$a socks5 127.0.0.1 1080' /etc/proxychains.conf

curl myip.ipip.net

