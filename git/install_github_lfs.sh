#!/bin/bash
set -e # exit on first error 

main()
{
    echo "Installing github lfs ........."
    install_github_lfs
}


install_github_lfs()
{
  rm -rf git_lfs_install
  git clone https://git.coding.net/aRagdoll/git_lfs_install.git
  cd git_lfs_install && sudo dpkg -i git-lfs_2.3.4_amd64.deb
  cd .. && rm -rf git_lfs_install
  git lfs install
}

main
