#!/bin/bash
set -e  # exit on first error
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main()
{
  install_texLive2018
  install_texStudio
}

install_texLive2018()
{
  echo "Installing TeXLive2018 for ubuntu 16.04."
 
    # check if the texlive2018 is installed 
  if [ -n "$(find /usr/local/texlive/2018/bin/x86_64-linux -name 'tex' | head -1)" ]; then
     echo "The texlive2018 exists in '/usr/local/texlive'"
  else 
     echo "Installing texlive2018 to '/usr/local'........"
     ## purge the old version texlive
     sudo apt-get purge texlive*
     mkdir -p ~/tex
     # check if a file exists by absolute paths
     if [ -n "$(find ~/ -name 'texlive2018.iso' | head -1)" ]; then
         echo "texlive2018.iso has already been downloaded."
     else
         echo "texlive2018.iso will be downloaded."
         wget -P ~/ http://mirror.bit.edu.cn/CTAN/systems/texlive/Images/texlive2018.iso   
     fi

     # check if the iso file has been mounted 	
     if mount | grep ~/tex > /dev/null; then
         echo "The texlive2018.iso has already been mounted to ~/tex ."
     else
         echo "Mounting the texlive2018.iso to ~/tex."
         sudo mount -t iso9660 ~/texlive2018.iso -o rw ~/tex
     fi
     cd ~/tex
     echo "Start to install the texlive2018 with a customized profile"
     sudo ./install-tl -profile $SCRIPT_DIR/ivrc.profile
     echo "TeXLive is installed on your computer."
     # configure the texlive path env
     if ( grep 'export PATH=${PATH}:/usr/local/texlive/2018/bin/x86_64-linux' ~/.bashrc); then 
         echo "The texlive path env variables have been set." 
     else
         echo "Set the path env for texlive2018.........."
     
         sudo sed -i '$a\export MANPATH=${MANPATH}:/usr/local/texlive/2018/texmf-dist/doc/man' ~/.bashrc

         sudo sed -i '$a\export INFOPATH=${INFOPATH}:/usr/local/texlive/2018/texmf-dist/doc/info' ~/.bashrc

         sudo sed -i '$a\export PATH=${PATH}:/usr/local/texlive/2018/bin/x86_64-linux' ~/.bashrc

         sudo sed -i '$s/"$/:\/usr\/local\/texlive\/2018\/bin\/x86_64-linux"/' /etc/environment
     fi
  fi
}


install_texStudio()
{ 
    echo "Installing TeXStudio for ubuntu 16.04........"
    export MANPATH=${MANPATH}:/usr/local/texlive/2018/texmf-dist/doc/man
    export INFOPATH=${INFOPATH}:/usr/local/texlive/2018/texmf-dist/doc/info
    export PATH=${PATH}:/usr/local/texlive/2018/bin/x86_64-linux
    echo "Remove the old version TexStudio......" 
    cd /tmp && sudo apt-get -y purge texstudio* && sudo dpkg -r texstudio
    cd $SCRIPT_DIR
    wget -O texstudio-qt5.deb https://dev.tencent.com/u/aRagdoll/p/software_install/git/raw/master/texstudio_2.12.14-1%2B2.1_amd64.deb
    sudo apt-get -y install libpoppler-qt5-1 libqt5script5
    sudo dpkg --install --force-overwrite texstudio-qt5.deb && rm -rf texstudio-qt5.deb
    echo "TeXStudio is installed on your computer."
    echo "Installing the fonts for BIT thesis........."
    install_winfonts
    texstudio
}

install_winfonts()
{
   cd $HOME
   if [ ! -d winfonts ]; then
     echo "As it is downloading the windows fonts, this will take a while......"
     git clone https://git.coding.net/aRagdoll/winfonts.git 
   else 
     cd winfonts && git reset --hard && git checkout master && git pull && cd ..
     echo "winfonts exists in $HOME."
   fi
   sudo cp -rf winfonts /usr/share/fonts/ 
   cd /usr/share/fonts/winfonts && sudo rm -rf .git && sudo chmod 644 *
   sudo mkfontscale && sudo mkfontdir && sudo fc-cache -fv
   echo "Windows fonts have been installed successfully."
}

main
