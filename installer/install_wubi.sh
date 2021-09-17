#!/bin/bash
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

GREEN_COLOR='\E[1;32m'
YELOW_COLOR='\E[1;33m'
WRITE_COLOR='\E[1;37m'

main()
{
install_wubi
}

install_wubi()
{
  echo "installing wubi....."
  #./install_bit_source_list.sh
  sudo apt-get update
  sudo apt-get install -y fcitx-table-wubi
  sudo apt-get install -y fcitx-config-gtk
  im-config -n fcitx
  echo -e  "${GREEN_COLOR}=============================  Click <<+>>  =============================${RES}"
  echo -e  "${GREEN_COLOR}===== Uncheck <<Only Show Current Language>> And Search <<Wubi>>!!! =====${RES}"
  echo -e  "${YELOW_COLOR}======= If you can't find it,you need to <<restart>> your computer ======${RES}"
  echo -e  "${YELOW_COLOR}==================  And <<./install_wubi.sh>> again!!!  =================${RES}"
  echo " "
  echo -e  "${WRITE_COLOR}#########################################################${RES}"
  cd /usr/bin/
  ./fcitx-configtool
  echo "wubi_input_method has been installed in your computer"
}

main
