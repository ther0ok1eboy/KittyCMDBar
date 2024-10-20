#!/bin/bash

# 获取终端的宽度
cols=$(tput cols)

# 终端全屏才打印
if (( $cols < 150 )); then
    exit 0
fi

if [ -e ~/KittyCMDBar/tmp/lib.txt ]; then
    # 预加载图库
    ~/KittyCMDBar/src/load.sh &
    cd ~/KittyCMDBar
    ./config/config.sh
else
    cd ~/KittyCMDBar
    ./init.sh
fi


