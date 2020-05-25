#!/bin/bash
#
# Add desktop shortcut launcher for software(no .desktop file in
# /usr/share/applications) in ubuntu.

set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

read -p "input name for your app:" app_name
echo $app_name
read -p "input The path to the executable to run:" app_path
echo $app_path
# read -p "input The name of the icon that will be used to display this entry:" icon
# echo $icon
read -p "whether this application needs to be run in a terminal or not:(y/n)" ans
if echo "$ans" | grep -iq "^y" ;then
    echo Yes
    terminal_flag="true"
else
    echo no
    terminal_flag="false"
fi

app_desktop="$app_name.desktop"

main()
{
    install_apt_dependencies
    create_desktop_for_app
}

install_apt_dependencies()
{
    sudo apt-get install --no-install-recommends gnome-panel
    # gnome-desktop-item-edit ~/Desktop/ --create-new
}

create_desktop_for_app()
{
    echo "create file in ~/.local/share/applications"
    cd ~/.local/share/applications
    touch '$app_desktop'
    # write lines
    echo "[Desktop Entry]" >> $app_desktop
    echo "Name=$app_name" >> $app_desktop
    echo "Exec=$app_path" >> $app_desktop
    # echo "Icon=$icon" >> $app_desktop
    echo "Type=Application" >> $app_desktop
    echo "Terminal=$terminal_flag" >> $app_desktop
    echo "Encoding=UTF-8" >> $app_desktop
    sudo chmod a+x $app_desktop
}

main


