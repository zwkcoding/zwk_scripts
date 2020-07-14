#!/bin/bash

# gets the script's source file pathname
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

files=$(ls)

for filename in $files
do
 echo $filename
 ln -fvs ${DIR}/$filename $1/$filename
done
