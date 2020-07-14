#!/bin/bash
#  ~/.fonts/   /usr/share/fonts: for all users, /usr/.local/share/fonts
# font files' permission: 644 containing folder should have 755
sudo mkdir -p "~/.fonts/truetype/choose_a_font_folder_name_here"
sudo cp Example.otf "~/.fonts/truetype/choose_a_font_folder_name_here"
sudo fc-cache -f -v

