#!/bin/bash

set -e

#if [ $# -ge 1 ]; then
#   params_file_dir=$1
#else
#   echo "need params fiel dir input"
#   exit 0
#fi

sed -i "s?\"coeff_clear_cost\"[[:space:]]*: 3,?\"coeff_clear_cost\": 0,?g" `grep "coeff_clear_cost" -rl ./`

# insert in next line
sed -i '/\"output_ap_planner_performance\"[[:space:]]*: 1,/a\"is_enable_rs_expansions": 1,' `grep "output_ap_planner_performance" -rl ./`

sed -i '/\"is_enable_rs_expansions\"[[:space:]]*: 0,/a\"best_max_dist_low_q": 0.5,\n"best_max_theta_low_q": 0.14,\n"best_high_q_time": 0,' `grep "is_enable_rs_expansions" -rl ./`

# batch replace
find . -name "uos_common.json" -exec sed -i "s?\"plan_max_steer_ratio_last\"?\"plan_max_steer_ratio_when_veh_stop\"?g" {} \;

# first match line. then add in end of line
find . -name "ap_traj_ref.txt" -exec sed -i '/AP_searched_alg / s/$/& 0/g' {} \;

# first match line. then delete line
find . -name "uos_common.json" -exec sed -i '/"coeff_clear_cost"/d' {} \;


# 先匹配空白行开头的，然后在行尾插入数据，user，

sed '/^[[:space:]]/ s/$/&,user/g' site.pp

# 匹配aaa~eee（开始结束字符串确定），然后替换123这样的
sed -i '/aaa/{:a;n;s/123/xyz/g;/eee/!ba}' yourfile
 

