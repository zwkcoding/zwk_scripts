#!/bin/bash

current="$(pwd)"
cd "$(dirname "$(readlink -f "$0")")"

echo "'$current'" '->' "'$(pwd)'" #show paths for demo purposes

cd "$1" #change to the directory provided (relative to the script)

echo "'$1'" '->' "'$(pwd)'" #show new path for demo purposes
