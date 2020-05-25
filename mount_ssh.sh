#!/bin/bash

set -ev

# sudo apt-get install sshfs

sudo sshfs -o cache=yes,allow_other worker@10.8.0.166:/home/worker/disk /mnt/worker


