#!/bin/bash
set -e  # exit on first error

main()
{
  cd /tmp
  sudo rm -rf snopt_binary*
  git clone git@github.com:bit-ivrc/snopt_binary.git && cd snopt_binary
  sudo bash install.sh
  cd ..
  rm -rf snopt_binary
}

main
