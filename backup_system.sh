#!/bin/bash

tar -cvpzf /media/zwk/My Passport/ubuntu_backup@`date +%Y-%m+%d`.tar.gz --exclude=/proc --exclude=/tmp --exclude=/boot --exclude=/home --exclude=/lost+found --exclude=/media --exclude=/mnt --exclude=/run /


## System Tar and Restore: Backup and Restore your system using tar or Transfer it with rsync

### ref: https://github.com/tritonas00/system-tar-and-restore

### download release : https://github.com/tritonas00/system-tar-and-restore/releases

sudo tar -xf system-tar-and-restore-6.8.tar.gz
cd system-tar-and-restore-6.8
./star.sh
./star-gui.sh
