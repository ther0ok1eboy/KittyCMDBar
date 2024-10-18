#!/bin/bash

# 加载CPU利用信息
~/KittyCMDBar/scripts/cpu.sh &

# 获取图标
get_icon() {
    
    text=$(cat /tmp/lib.txt | grep $1)
    if (( ${#text} != 0 )); then
        icon=$(echo $text | awk -F ':' '{print$2}')
            if (( ${#icon} != 0 )); then
                echo $icon
            fi
    fi
}

# 查找应用
all_app=$(ls /usr/share/applications/ | sort| awk -F '.' '{print$1}'| awk -F '-' '{print$1}' | uniq | grep -v -E 'com|org|nm|qt')

for i in $all_app; do
    if (( $(ps -aux | grep $i | wc -l &) > 1 )); then
        # 获取图标
        echo "$(get_icon $i) " >> /tmp/icon.txt
    fi
done

