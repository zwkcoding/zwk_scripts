#!/bin/bash

set -e 

proj_list='uos_base uos_core uos_rcslib
uos_lateralctrl uos_speedctrl uos_hmi
uos_emulation uos_planner_base uos_local_planner
uos_park_planner uos_planner_framework uos_planner_exp
uos_ideal_vehicle uos_agile_planner  uos_3rdparty'


if [ $# -ge 1 ]; then
   target_branch=$1
else
   target_branch=dev-cq2
fi

for proj in ${proj_list}; do
    echo $proj
    cd src/$proj
    git checkout $target_branch
   # git pull
    cd ../..
done

