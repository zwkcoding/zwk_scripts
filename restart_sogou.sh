#!/bin/bash

set -e

# terminal command
# fcitx | xargs kill
# sogou-qimpanel | xargs kill

cd ~/.config/
rm -rf SogouPY 
rm -rf SogouPY.users 
rm -rf sogou-qimpanel

rm -rf ~/.sogouinput

#pidof fcitx | xargs kill
#pidof sogou-qimpanel | xargs kill -9
kill $(pidof fcitx)
kill $(pidof sogou-qimpanel)
fcitx&
sogou-qimpanel&

echo "Sogou restarted"

exit
#sudo pkill -9 -f 'fcitx'
#sudo pkill -9 -f 'sogou-qimpanel'
#sudo killall 'fcitx'
#sudo killall 'sogou-qimpanel'

#nohup fcitx 1>/dev/null 2>/dev/null &
#nohup sogou-qimpanel 1>/dev/null 2>/dev/null &
