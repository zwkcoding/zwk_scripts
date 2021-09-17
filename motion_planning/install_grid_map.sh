#!/bin/bash
set -e  # exit on first error

main() {
  sudo apt-get update
  sudo apt-get -y install ros-kinetic-pcl-ros ros-kinetic-costmap-2d ros-kinetic-grid-map
  echo "grid_map is installed successfully!"
}

main
