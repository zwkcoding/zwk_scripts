#!/bin/bash

set -ev

username=`whoami`

sudo su
chmod 740 /etc/sudoers
sed -i '/root[[:space]]*ALL=(ALL:ALL) ALL/a\username ALL=(ALL:ALL) NOPASSWD : ALL' /etc/sudoers
chmod 0440 /etc/sudoers
exit
