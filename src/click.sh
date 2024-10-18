#!/bin/bash

choice=$(echo $1 | awk -F '.' '{print$1}')

case "$choice" in
    1)
        # 音量设置
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        clear
        ~/KittyCMDBar/startup.sh
        ;;
    2)
        # 切换壁纸
        ~/KittyCMDBar/scripts/background.sh
        clear
        ~/KittyCMDBar/startup.sh
        ;;
    3)
        # 增加亮度
        brightnessctl s 10%+
        clear
        ~/KittyCMDBar/startup.sh
        ;;
    4)
        # 减少亮度
        brightnessctl s 10%-
        clear
        ~/KittyCMDBar/startup.sh
        ;;
    5)
        # 增加音量
        pactl set-sink-volume @DEFAULT_SINK@ +10%
        clear
        ~/KittyCMDBar/startup.sh
        ;;
    6)
        # 减少音量
        pactl set-sink-volume @DEFAULT_SINK@ -10%
        clear
        ~/KittyCMDBar/startup.sh
        ;;
    7)
        clear
        ~/KittyCMDBar/startup.sh
        ~/KittyCMDBar/scripts/power.sh
        ;;
    8)
        # cpu 占用情况
        ~/KittyCMDBar/scripts/core.sh
        ;;
    9)
        # wifi面板
        count=10
        ~/KittyCMDBar/scripts/wifi.sh $count
        ;;
    10)
        echo "TODO"
        ;;
    *)
        # 连接wifi
        nmcli device wifi connect $choice --ask 
        ;;
esac
