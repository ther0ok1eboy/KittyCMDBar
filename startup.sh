#!/bin/bash

# 获取终端的宽度
cols=$(tput cols)

# 终端全屏才打印
if (( $cols < 150 )); then
    exit 0
fi

# 预加载图库
~/KittyCMDBar/src/load.sh &

if [ -e /tmp/weather.txt ] && [ -e /tmp/lib.txt ]; then
    cd ~/KittyCMDBar
    ./config/config.sh
else
    cd ~/KittyCMDBar
    ./init.sh
fi


