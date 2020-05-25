#!/bin/bash

set -e

branch_name="dev-cq2"

if [ "`git branch --list "$branch_name"`" ]
then
   echo "Branch name $branch_name already exists."
fi
