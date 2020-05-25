#!/bin/bash
# backup my wiki to github everyday

set -e

DATE=$(date +"%m-%d")
WIKI_PATH=$HOME/software/my_wiki

echo -e "Backup my_wiki ${DATE}"
cd ${WIKI_PATH}
git add .
git diff-index --quiet HEAD || git commit -m 'Backup ${DATE}'
git push origin $(git rev-parse --abbrev-ref HEAD) --force
