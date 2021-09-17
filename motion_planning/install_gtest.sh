#!/bin/bash
set -e  # exit on first error

main() 
{
  install_gtest
}


install_gtest()
{
  sudo apt-get update
  sudo apt-get install -qq libgtest-dev
  echo "gtest is installed successfully!"
}

main


