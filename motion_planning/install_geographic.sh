#!/bin/bash
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main()
{
    echo "Installing geographiclib....."
    sudo apt-get update && sudo apt-get -y install libgeographic-dev
}

main
